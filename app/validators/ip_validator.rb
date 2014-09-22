class IpValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    !!IPAddr.new(value)
  rescue
    object.errors[attribute] << (options[:message] || "is not formatted properly")
  end
end
