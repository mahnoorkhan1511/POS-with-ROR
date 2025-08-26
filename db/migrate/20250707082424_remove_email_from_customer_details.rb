class RemoveEmailFromCustomerDetails < ActiveRecord::Migration[7.2]
  def change
    remove_column :customer_details,  :email, :string
  end
end
