class CategoriesController < ApplicationController
  def index
    @categories = Category.all.where(super_category_id: nil)
  end
end
