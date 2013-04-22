class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    begin
      uri = URI.parse(value)
      throw unless uri.host
    rescue => e
      record.errors[attribute] << 'bad URI(is not URI?)'
    end
  end
end
