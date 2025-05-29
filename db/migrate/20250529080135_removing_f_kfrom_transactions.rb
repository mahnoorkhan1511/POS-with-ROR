class RemovingFKfromTransactions < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :transactions, column: :order_id
    remove_foreign_key :transactions, column: :customer_id
    remove_foreign_key :transactions, column: :payment_method_id
  end
end
