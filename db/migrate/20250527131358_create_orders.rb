class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.timestamps
      t.references :customer, null: false, foreign_key: true
      t.string :status
    end
  end
end
