class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :product_id, uniqueness: { scope: :user_id, message: 'User already rate this product' }
end
