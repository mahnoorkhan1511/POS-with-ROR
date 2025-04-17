class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.timestamps
    end
    add_index :orders, [ :order_id, :customer_id ], unique: true
  end
end
