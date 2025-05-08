class Category < ApplicationRecord
  has_many :product
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :published, -> { where(published: true) }
end
