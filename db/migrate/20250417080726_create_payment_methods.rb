class CreatePaymentMethods < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_methods do |t|
      t.string :method

      t.timestamps
    end
  end
end
