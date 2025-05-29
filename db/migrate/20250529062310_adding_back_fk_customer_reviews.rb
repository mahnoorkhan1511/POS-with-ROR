class AddingBackFkCustomerReviews < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:customer_reviews, :customer_id)
      add_reference :customer_reviews, :customer, null: false, foreign_key: true
    end

    unless column_exists?(:customer_reviews, :product_id)
      add_reference :customer_reviews, :product, null: false, foreign_key: true
    end
  end
end
