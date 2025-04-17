class CreateBankDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :bank_details do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :bank_name
      t.integer :last_4_digits
      t.string :card_type

      t.timestamps
    end
  end
end
