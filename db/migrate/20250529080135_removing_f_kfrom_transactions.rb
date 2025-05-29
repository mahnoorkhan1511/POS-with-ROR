class RemovingFKfromTransactions < ActiveRecord::Migration[7.2]
  def change
    remove_reference :transactions, :order, foreign_key: true
    remove_reference :transactions, :customer, foreign_key: true
    remove_reference :transactions, :payment_method, foreign_key: true
  end
end
