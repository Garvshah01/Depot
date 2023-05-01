class Category < ApplicationRecord

  scope :product_of_subcategory, -> { sub_categories.products }

  belongs_to :parent_category, class_name: "Category", optional: true
  has_many :products, dependent: :restrict_with_error
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_category_id", dependent: :destroy
  has_many :subcategories_products, through: :sub_categories, source: :products, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true, if: :parent_category, unless: :name.nil?
  validates :name, uniqueness: { scope: :parent_category_id}, unless: :name.nil?
  validates_with NoChildOfSubCategoryValidator

end
