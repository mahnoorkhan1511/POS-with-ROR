class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
