class Customer < ApplicationRecord
  belongs_to :user
  has_many :bank_detail
  has_many :reviewed
  has_many :order
end
