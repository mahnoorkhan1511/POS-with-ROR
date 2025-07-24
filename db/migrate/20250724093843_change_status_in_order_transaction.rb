class ChangeStatusInOrderTransaction < ActiveRecord::Migration[7.2]
  def change
    rename_column :order_transactions, :status, :is_paid
  end
end
