class RemoveDescriptionFromProduct < ActiveRecord::Migration[7.2]
  def change
    remove_column :products, :description, :string
  end
end
