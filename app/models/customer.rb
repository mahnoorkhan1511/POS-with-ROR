class Customer < ApplicationRecord
  belongs_to :user
  has_many :bank_detail
  has_many :customer_reviews
  has_many :order
end
