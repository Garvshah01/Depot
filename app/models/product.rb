class Product < ApplicationRecord

  PERMALINK_REGEXP =  %r{\A[a-z0-9-]+\Z}i.freeze
  MINIMUM_PERMALINK_LENGTH = 3
  MINIMUM_DESCRIPTION_LENGTH = 5
  MAXIMUM_DECRIPTION_LENGTH = 10

  belongs_to :category, counter_cache: true
  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, url: true, allow_blank: true
  validates :permalink, format: {
    with: PERMALINK_REGEXP,
    message: 'should not contains any special characters'
  }
  validates :permalink, uniqueness: true, allow_nil: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}, if: :price
  validates :price, comparison: { greater_than_or_equal_to: :discount_price },  allow_nil: true
  validates_with PriceValidator, if: :price
  validate :validate_words_in_permalink
  validate :validate_words_in_description

  before_validation :set_name_default
  before_validation :set_discount_price
  after_create :product_increment_counter
  after_destroy :product_decrement_counter

  private

  def product_increment_counter
    Category.increment_counter(:products_count, category.parent_category_id)
  end

  def product_decrement_counter
    Category.decrement_counter(:products_count, category.parent_category_id)
  end

  def validate_words_in_permalink
    words_count = permalink.split('-').size
    if words_count < MINIMUM_PERMALINK_LENGTH
      errors.add :permalink, "should not have words less than 3"
    end
  end

  def validate_words_in_description
    words_count = description.split(' ').size
    if words_count < MINIMUM_DESCRIPTION_LENGTH
      errors.add :description, "should not have words less than 5"
    elsif words_count > MAXIMUM_DECRIPTION_LENGTH
      errors.add :description, "should not have words greater than 10"
    end
  end

  def set_name_default
    self.title ||= 'abc'
  end

  def set_discount_price
    self.discount_price = price if discount_price == 0.0
  end
end
