module TranslatedAttributeValue
  module Base
    def self.included(base)
      if defined?(Mongoid::Document) && base.ancestors.include?(Mongoid::Document)
        Mongoid::Document.send(:include, InstanceMethods)
        Mongoid::Document::ClassMethods.send(:include, ClassMethods)
      else
        base.send(:include, InstanceMethods)
        base.send(:extend, ClassMethods)
      end
    end

    module InstanceMethods
      def method_missing(name, *args, &block)
        attribute_name = name.to_s.gsub!(/_translated$/, '') # this will return nil or the modified string
        if (attribute_name) && self.respond_to?(attribute_name)
          self.class.translated_value_for(attribute_name)
          self.send(name)
        else
          super
        end
      end
    end

    module ClassMethods
      def translated_value_for(*args)
        args.each do |attribute_name|
          if defined?(ActiveRecord::Base) && self.ancestors.include?(ActiveRecord::Base)
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("activerecord.attributes.#{self.class.to_s.underscore}.#{attribute_name}_translation.#{attribute_value}")
            end
          elsif defined?(Mongoid::Document) && self.ancestors.include?(Mongoid::Document)
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("mongoid.attributes.#{self.class.to_s.underscore}.#{attribute_name}_translation.#{attribute_value}")
            end
          else
            self.send(:define_method, "#{attribute_name}_translated") do
              attribute_value = self.send(attribute_name)
              I18n.t("translated_attribute_value.#{self.class.to_s.underscore}.#{attribute_name}_translation.#{attribute_value}")
            end
          end # of if chain
        end # of each
      end # of translated_value_for
    end # of ClassMethods
  end # of Base module
end # of TranslatedAttributeValue module
