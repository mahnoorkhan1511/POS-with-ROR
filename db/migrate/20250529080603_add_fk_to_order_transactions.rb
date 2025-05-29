class AddFkToOrderTransactions < ActiveRecord::Migration[7.2]
  def change
    add_reference :order_transactions, :customer, null: false, foreign_key: true
    add_reference :order_transactions, :order, null: false, foreign_key: true
    add_reference :order_transactions, :payment_method, null: false, foreign_key: true
  end
end
