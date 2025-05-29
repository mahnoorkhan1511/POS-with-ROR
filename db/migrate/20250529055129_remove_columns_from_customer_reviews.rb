class RemoveColumnsFromCustomerReviews < ActiveRecord::Migration[7.2]
  def change
    remove_column :customer_reviews,  :customer_id, :bigint
    remove_column :customer_reviews, :product_id, :bigint
  end
end
