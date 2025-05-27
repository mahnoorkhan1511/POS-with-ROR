class CustomerReview < ApplicationRecord
  belongs_to :customer
  has_many_attached :featured_image
end
