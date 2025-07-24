class OrderedProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, :featured_image, to: :product

  scope :top_sold_products, -> {
    group("product_id").select("SUM(quantity) as count").order("count DESC").limit(3).pluck(:product_id, Arel.sql("SUM(quantity) AS count"))
  }
  scope :daily_profit, -> {
    joins(:product)
      .group("DATE(ordered_products.created_at)")
      .select("DATE(ordered_products.created_at) AS order_date, SUM(products.sales_price - products.cost_price) AS total_profit")
      .order("order_date DESC")
  }
  scope :monthly_revenue, -> {
    joins(:product)
      .group("DATE_TRUNC('month', ordered_products.created_at)")
      .select("DATE_TRUNC('month', ordered_products.created_at) As order_month, SUM(products.sales_price - products.cost_price) AS monthly_profit")
  }
end
