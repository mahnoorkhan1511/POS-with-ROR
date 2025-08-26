class UpdateCartsTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :carts, :quantity, :integer

    change_column_null :carts, :customer_id, true
  end
end
