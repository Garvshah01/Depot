class CategoriesController < ApplicationController
  def index
    @categories = Category.root
  end
end
