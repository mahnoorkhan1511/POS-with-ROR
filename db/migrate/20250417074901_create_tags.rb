class CreateTags < ActiveRecord::Migration[7.2]
  def change
    create_table :tags do |t|
      t.references :product, null: false, foreign_key: true
      t.string :tag

      t.timestamps
    end
  end
end
