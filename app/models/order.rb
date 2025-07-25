class Order < ApplicationRecord
  belongs_to :customer
  has_one :order_transaction, dependent: :destroy
  has_many :ordered_products, dependent: :destroy
  has_many :products, through: :ordered_products
  belongs_to :customer_detail

  accepts_nested_attributes_for :customer_detail
  accepts_nested_attributes_for :order_transaction

  enum status: {
    processing: 0,
    confirmed: 1,
    dispatched: 2,
    delivered: 3,
    failed: 4
  }

  delegate :payment_type, :is_paid, :amount, to: :order_transaction
  delegate :username, :email, to: :customer, prefix: :customer
  delegate :address, :street_apt, :city, :country, :state, :zipcode, :phone, to: :customer_detail, prefix: :customer

  def save_customer_details(customer:, attributes:)
    existing_cd = CustomerDetail.find_by(
      customer_id: customer.id,
      address: attributes[:address],
      street_apt: attributes[:street_apt],
      city: attributes[:city],
      country: attributes[:country],
      state: attributes[:state],
      zipcode: attributes[:zipcode],
      phone: attributes[:phone]
    )

    if existing_cd
      self.customer_detail = existing_cd
    elsif customer_detail
      customer_detail.customer = customer
    end
  end

  def create_ordered_products(cart)
    cart.products_to_order.each do |pto|
      self.ordered_products.create(
        product_id: pto.product_id,
        price: pto.product.sales_price,
        quantity: pto.quantity
      )
    end
  end

  def line_items
    ordered_products.map do |op|
      {
        price_data: {
          currency: "usd",
          product_data: {
            name: op.product.name
          },
          unit_amount: (op.product.sales_price * 100).to_i
        },
        quantity: op.quantity
      }
    end
  end
end
