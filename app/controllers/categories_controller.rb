class CategoriesController < ApplicationController
  def index
    @categories = Category.where(super_category_id: nil)
  end
end
