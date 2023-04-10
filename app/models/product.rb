load 'Validators/price_validator.rb'
load 'Validators/url_validator.rb'


class Product < ApplicationRecord

  PERMALINK_REGEXP =  %r{\A[a-z0-9-]+\Z}.freeze

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, url: true
  validates :permalink, format: {
    with: PERMALINK_REGEXP,
    message: 'should not contains any special characters'
  }
  validates :permalink, uniqueness: true, allow_nil: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}, if: :price
  validates :price, comparison: { greater_than: :discount_price },  allow_nil: true
  validates_with PriceValidator, if: :price
  validate :validate_words_in_permalink
  validate :validate_words_in_description

  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item


  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end

  MINIMUM_PERMALINK_LENGTH = 3

  def validate_words_in_permalink
    words = permalink.split '-'
    if words.size < MINIMUM_PERMALINK_LENGTH
      errors.add :permalink, "should not have words less than 3"
    end
  end

  MINIMUM_DESCRIPTION_LENGTH = 5
  MAXIMUM_DECRIPTION_LENGTH = 10

  def validate_words_in_description
    words = description.split(' ')
    if words.size() < MINIMUM_DESCRIPTION_LENGTH
      errors.add :description, "should not have words less than 5"
    elsif words.size() > MAXIMUM_DECRIPTION_LENGTH
      errors.add :description, "should not have words greater than 10"
    end
  end
end
