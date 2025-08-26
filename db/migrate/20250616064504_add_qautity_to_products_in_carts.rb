class AddQautityToProductsInCarts < ActiveRecord::Migration[7.2]
  def change
    add_column :product_in_carts, :quantity, :integer, default: 0, null: false
  end
end
