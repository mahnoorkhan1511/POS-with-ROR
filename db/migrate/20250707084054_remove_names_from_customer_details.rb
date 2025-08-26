class RemoveNamesFromCustomerDetails < ActiveRecord::Migration[7.2]
  def change
    remove_column :customer_details,  :first_name, :string
    remove_column :customer_details,  :last_name, :string
  end
end
