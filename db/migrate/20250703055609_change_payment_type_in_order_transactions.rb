class ChangePaymentTypeInOrderTransactions < ActiveRecord::Migration[7.2]
  def change
    change_column :order_transactions, :payment_type, :integer, using: 'payment_type::integer', default: 0, null: false
  end
end
