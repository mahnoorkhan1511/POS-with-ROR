class AddFkToOrderTransactions < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :order_transactions, :orders, column: :order_id
    add_foreign_key :order_transactions, :customers, column: :customer_id
    add_foreign_key :order_transactions, :payment_methods, column: :payment_method_id
  end
end
