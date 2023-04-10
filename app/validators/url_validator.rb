class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attr, value)
    unless value.match URI::MailTo::EMAIL_REGEXP
      record.errors.add attr, 'must be a URL for GIF, JPG or PNG images'
    end
  end
end
