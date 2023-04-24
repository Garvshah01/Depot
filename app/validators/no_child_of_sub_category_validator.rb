class NoChildOfSubCategoryValidator < ActiveModel::Validator
  def validate(record)
    if record.super_category.super_category_id
      record.errors.add :super_category_id, message: 'is a sub category'
    end
  end
end
