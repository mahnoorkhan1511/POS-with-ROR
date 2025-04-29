class AddColumn < ActiveRecord::Migration[7.2]
  def change
    add_reference :customer_reviews, :product, null: false, foreign_key: true
  end
end
