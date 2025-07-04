class ChangeStatusInOrders < ActiveRecord::Migration[7.2]
  def change
    change_column :orders, :status, :integer, using: 'status::integer', default: 0, null: false
  end
end
