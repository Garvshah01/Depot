module Admin
  class CategoriesController < ApplicationController

    def index
      @categories = Category.all.where(parent_category_id: nil)
    end

    def products
      category = Category.find_by(id: params[:category_id])
      @products = category.subcategories_products.or(category.products)
    end
  end
end
