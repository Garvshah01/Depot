class Category < ApplicationRecord

  belongs_to :super_category, class_name: "Category", optional: true
  has_many :products, dependent: :restrict_with_error
  has_many :subcategories_products, through: :sub_categories, source: :products, dependent: :restrict_with_error
  has_many :sub_categories, class_name: "Category", foreign_key: "super_category_id", dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true, if: :super_category, unless: :name.nil?
  validates :name, uniqueness: { scope: :super_category_id}, unless: :name.nil?
  validates_with NoChildOfSubCategoryValidator
end
