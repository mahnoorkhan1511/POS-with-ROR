class Tag < ApplicationRecord
  has_and_belongs_to_many :products

  validates :tag, presence: true, uniqueness: { case_sensitive: false }
end
