class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.string :product_status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
