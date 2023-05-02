class RenameColumnInCategories < ActiveRecord::Migration[7.0]
  def change
    rename_column :categories, :parent_category_id, :parent_category_id
  end
end
