class NoChildOfSubCategoryValidator < ActiveModel::Validator
  def validate(record)
    if record.parent_category.parent_category_id
      record.errors.add :parent_category_id, message: 'is a sub category'
    end
  end
end
