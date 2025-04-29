class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :payment_method, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :amount
      t.string :payment_type
      t.boolean :status

      t.timestamps
    end
  end
end
