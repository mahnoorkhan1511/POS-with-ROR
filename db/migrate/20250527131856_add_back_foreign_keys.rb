class AddBackForeignKeys < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :ordered_products, :orders
    add_foreign_key :transactions, :orders
  end
end
