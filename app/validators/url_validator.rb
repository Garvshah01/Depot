class UrlValidator < ActiveModel::EachValidator

  URL_REGEXP = %r{\.(gif|jpg|png)\z}i.freeze

  def validate_each(record, attr, value)
    unless value =~ URL_REGEXP
      record.errors.add attr, 'must be a URL for GIF, JPG or PNG images'
    end
  end
end
