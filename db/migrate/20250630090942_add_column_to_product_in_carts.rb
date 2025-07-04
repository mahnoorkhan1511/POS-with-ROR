class AddColumnToProductInCarts < ActiveRecord::Migration[7.2]
  def change
    add_column :product_in_carts, :to_be_ordered, :boolean, default: true
  end
end
