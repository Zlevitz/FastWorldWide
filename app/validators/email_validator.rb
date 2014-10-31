# app/validators/email_validator.rb
# require 'mail'
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@gentax\.com/
      record.errors[attribute] << (options[:message] || "must be a Gentax email.")
    end
  end
end
