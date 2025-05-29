class RemoveFkFromCustomerReviews < ActiveRecord::Migration[7.2]
  def change
    remove_reference :customer_reviews, :product, foreign_key: true
    remove_reference :customer_reviews, :customer, foreign_key: true
  end
end
