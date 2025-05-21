class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :featured_image
  has_rich_text :description
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags

  enum product_status: { drafted: "drafted", reviewed: "reviewed", published: "published" }

  validates :name, presence: true, uniqueness: true
  validates :cost_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sales_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  attr_accessor :tag_names

  after_initialize :set_default_status, if: :new_record?

  def self.manager_statuses
    {
      drafted: "drafted",
      reviewed: "reviewed"
    }
  end

  def set_default_status
    self.product_status ||= "drafted"
  end
end
