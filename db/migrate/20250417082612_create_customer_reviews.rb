class CreateCustomerReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :customer_reviews do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :stars
      t.string :review
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
