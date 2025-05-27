class ChangeProductStatusToIntegerInProducts < ActiveRecord::Migration[7.2]
  def change
    change_column :products, :product_status, :integer, using: 'product_status::integer', default: 0, null: false
  end
end
