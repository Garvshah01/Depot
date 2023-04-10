class PriceValidator < ActiveModel::Validator
  def validate(record)
    if record[:price] < record[:discount_price]
      record.errors.add :price, "should be greater than #{ record[:discount_price] }"
    end
  end
end
