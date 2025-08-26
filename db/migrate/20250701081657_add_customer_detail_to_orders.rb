class AddCustomerDetailToOrders < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :customer_detail, null: false, foreign_key: true
  end
end
