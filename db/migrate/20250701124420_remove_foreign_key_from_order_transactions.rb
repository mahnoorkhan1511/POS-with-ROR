class RemoveForeignKeyFromOrderTransactions < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :order_transactions, :payment_methods
    remove_index :order_transactions, :payment_method_id
    remove_column :order_transactions, :payment_method_id, :bigint
  end
end
