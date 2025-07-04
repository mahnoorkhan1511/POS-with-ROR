class CreateCustomerDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :customer_details do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :street_apt
      t.string :city
      t.string :country
      t.string :state
      t.string :zipcode
      t.string :phone
      t.string :email
      t.references :customer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
