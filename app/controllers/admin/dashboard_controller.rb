class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    # authorize! :access, :dashboard
    ids_with_count = OrderedProduct.top_sold_products
    @products = ids_with_count.map do |id, count|
      product = Product.find_by(id: id)
      { product: product, count: count }
    end

    @daily_profit_data = OrderedProduct.daily_profit.map do |item|
      [ item.order_date.to_s, item.total_profit.to_s ]
    end
    @monthly_profit_data = OrderedProduct.monthly_revenue.map do |item|
      [ item.order_month.to_s, item.monthly_profit.to_s ]
    end
    Rails.logger.info "🧪 #{@monthly_profit_data}"
  end
end
