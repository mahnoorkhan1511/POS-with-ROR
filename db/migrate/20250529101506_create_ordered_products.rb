class CreateOrderedProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :ordered_products do |t|
      t.timestamps
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :price
      t.integer :quantity
    end
  end
end
