class CategoriesController < ApplicationController
  def index
    @categories = Category.all.root
  end
end
