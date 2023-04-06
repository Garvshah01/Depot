class UrlValidator < ActiveModel::EachValidator
  URL_REGEXP = %r{\.(gif|jpg|png)\z}i.freeze
  def validate_each(record, attr, value)
    unless value =~ REGEXP
      record.errors.add attr, 'must be a URL for GIF, JPG or PNG images'
    end
  end
end

class PriceValidator < ActiveModel::Validator
  def validate(record)
    if record[:price] < record[:discount_price]
      record.errors.add :price, "should be greater than #{ record[:discount_price] }"
    end
  end
end
