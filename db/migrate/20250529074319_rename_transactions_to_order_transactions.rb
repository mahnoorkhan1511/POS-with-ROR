class RenameTransactionsToOrderTransactions < ActiveRecord::Migration[7.2]
  def change
    remove_reference :transactions, :order, foreign_key: true
    remove_reference :transactions, :customer, foreign_key: true
    remove_reference :transactions, :payment_method, foreign_key: true

    rename_table :transactions, :order_transactions

    add_reference :order_transactions, :order, null: false, foreign_key: true
    add_reference :order_transactions, :customer, null: false, foreign_key: true
    add_reference :order_transactions, :payment_method, null: false, foreign_key: true
  end
end
