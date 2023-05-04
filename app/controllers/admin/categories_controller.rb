class Admin::CategoriesController < Admin::AdminBaseController
  def index
    @categories = Category.all.where(parent_category_id: nil)
  end

  def products
    category = Category.find_by(id: params[:category_id])
    redirect_to admin_categories_path, notice: t('.notice') and return unless category
    @products = category.subcategories_products.or(category.products)
  end
end
