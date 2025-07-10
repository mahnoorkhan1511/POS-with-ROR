class AddIndexToCustomerDetails < ActiveRecord::Migration[7.2]
  def change
    add_index :customer_details, [ :address, :street_apt, :city, :country, :state, :zipcode, :phone, :customer_id ], unique: true
  end
end
