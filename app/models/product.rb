class Product < ApplicationRecord
  belongs_to :category
  enum product_status: { created: "created", reviewed: "reviewed", published: "published" }
end
