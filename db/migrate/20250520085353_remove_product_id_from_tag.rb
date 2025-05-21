class RemoveProductIdFromTag < ActiveRecord::Migration[7.2]
  def change
    remove_column :tags, :product_id, foreign_key: true
  end
end
