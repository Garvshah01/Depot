class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    unless value =~ %r{\.(gif|jpg|png)\z}i
      record.errors.add attr, 'must be a URL for GIF, JPG or PNG images'
    end
  end
end

class PriceValidator < ActiveModel::Validator
  def validate(record)
    if record[:price] < record[:discount_price]
      record.errors.add :price, "should be greater than #{record[:discount_price]}"
    end
  end
end

class Product < ApplicationRecord

  validates :permalink, uniqueness:true
  validates :permalink, format: {
    with: %r{\A[A-Za-z0-9-]+\Z},
    message: 'should not contains any special characters'
  }
  validates :words_in_permalink, length: {minimum: 3}
  validates :words_in_description , length: {in: 5..10}
  validates :price, comparison: { greater_than: :discount_price }
  validates_with PriceValidator
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}, if: :price
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, url:true

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
  def words_in_permalink
    permalink.split('-')
  end
  def words_in_description
    description.split(' ')
  end
end












# validates :permalink, format: {
#   with: %r{\A([A-Za-z0-9]+\-){2,}([A-Za-z0-9]+)\Z}
# }
