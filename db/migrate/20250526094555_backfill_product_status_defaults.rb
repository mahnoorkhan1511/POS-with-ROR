class BackfillProductStatusDefaults < ActiveRecord::Migration[7.2]
  def up
    # Set all NULL product_status values to 0 (drafted)
    Product.where(product_status: nil).update_all(product_status: 0)
  end
end
