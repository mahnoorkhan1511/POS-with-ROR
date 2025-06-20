class Product < ApplicationRecord
  after_create :set_default_status, if: :new_record?

  belongs_to :category
  has_one_attached :featured_image
  has_rich_text :description
  has_and_belongs_to_many :tags
  has_many :customer_reviews
  has_many :product_in_carts
  has_many :carts, through: :product_in_carts

  accepts_nested_attributes_for :tags

  attr_accessor :tag_names

  enum product_status: {
    drafted: 0,
    reviewed: 1,
    published: 2
  }

  validates :name, presence: true, uniqueness: true
  validates :cost_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sales_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :search_by_name, ->(name) { where("name ILIKE ?", "#{name}%") }
  scope :search_by_tags, ->(tag) { joins(:tags).where("tags.tag ILIKE ?", "#{tag}%").distinct }
  scope :search_by_category, ->(category) { joins(:category).where("categories.name ILIKE ?", "#{category}%") }
  scope :filter_products, ->(categories, min, max) {
    joins(:category).where("categories.name = ANY (ARRAY[?]) and products.sales_price >= ? and products.sales_price <= ?", categories, min, max)
  }

  def self.manager_statuses
    {
      drafted: 0,
      reviewed: 1
    }
  end

  def set_default_status
    self.product_status ||= :drafted
  end
end
