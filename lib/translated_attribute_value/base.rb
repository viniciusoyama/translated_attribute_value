module TranslatedAttributeValue
  module Base
    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def translated_value_for(*args)
        args.each do |attribute_name|
          if defined?(ActiveRecord::Base)
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("activerecord.attributes.#{self.class.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
            end
          elsif defined?(Mongoid::Document)
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("mongoid.attributes.#{self.class.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
            end
          else
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("translated_attribute_value.#{self.class.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
            end
          end
        end
      end
    end
  end
end
