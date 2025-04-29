class CreateProductInCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :product_in_carts do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
