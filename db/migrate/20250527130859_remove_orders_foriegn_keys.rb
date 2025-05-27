class RemoveOrdersForiegnKeys < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :ordered_products, :orders
    remove_foreign_key :transactions, :orders
  end
end
