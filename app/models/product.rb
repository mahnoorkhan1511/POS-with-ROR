class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :featured_image
  enum product_status: { created: "created", reviewed: "reviewed", published: "published" }
end
