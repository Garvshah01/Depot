class Category < ApplicationRecord

  belongs_to :parent_category, class_name: "Category", optional: true
  has_many :products, dependent: :restrict_with_error
  has_many :subcategories_products, through: :sub_categories, source: :products, dependent: :restrict_with_error
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_category_id", dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true, if: :parent_category, allow_nil: true
  validates :name, uniqueness: { scope: :parent_category_id }, allow_nil: true
  validate NoChildOfSubCategoryValidator

  scope :root, -> { where(parent_category_id: nil) }

  private

  def ensure_no_child_Of_sub_category
    if parent_category.parent_category_id
      errors.add :parent_category_id, message: 'is a sub category'
    end
  end
end
