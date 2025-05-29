class RenameTransactionsToOrderTransactions < ActiveRecord::Migration[7.2]
  def change
    rename_table :transactions, :order_transactions
  end
end
