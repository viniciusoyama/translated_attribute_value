require 'translated_attribute_value/base'
require "translated_attribute_value/version"

module TranslatedAttributeValue
end


ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:extend, TranslatedAttributeValue::Base)
end

ActiveSupport.on_load(:mongoid) do
  Mongoid::Document.send(:include, TranslatedAttributeValue::Base)
end
