module TranslatedAttributeValue
  module Base
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:alias_method_chain, :method_missing, :translation)
    end


    def method_missing_with_translation(name, *args, &block)
      attribute_name = name.to_s.gsub!(/_translated/, '') # this will return nil or the modified string
      if (attribute_name) && self.respond_to?(attribute_name)
        self.class.define_translated_value_for(attribute_name)
        self.send(name)
      else
        method_missing_without_translation(name, args, block)
      end
    end

    module ClassMethods
      def define_translated_value_for(*args)
        args.each do |attribute_name|
          if defined?(ActiveRecord::Base) && self.ancestors.include?(ActiveRecord::Base)
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("activerecord.attributes.#{self.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
            end
          elsif defined?(Mongoid::Document) && self.ancestors.include?(Mongoid::Document)
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("mongoid.attributes.#{self.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
            end
          else
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("translated_attribute_value.#{self.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
            end
          end # of if chain
        end # of each
      end # of define_translated_value_for
    end # of ClassMethods
  end # of Base module
end # of TranslatedAttributeValue module
