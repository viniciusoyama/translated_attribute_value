module TranslatedAttributeValue
  module Base
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.send(:alias_method_chain, :method_missing, :translation)
    end

    def self.extended(base)
      base.send(:include, InstanceMethods)
      base.send(:alias_method_chain, :method_missing, :translation)
    end

    module InstanceMethods
      def method_missing_with_translation(name, *args, &block)
        attribute_name = name.to_s.gsub!(/_translated$/, '') # this will return nil or the modified string
        if (attribute_name) && self.respond_to?(attribute_name)
          self.define_translated_value_for(attribute_name)
          self.send(name)
        else
          method_missing_without_translation(name, args, block)
        end
      end

      protected

        def define_translated_value_for(*args)
          args.each do |attribute_name|
            if defined?(ActiveRecord::Base) && self.class.ancestors.include?(ActiveRecord::Base)
              self.class.send(:define_method, "#{attribute_name}_translated") do
                attribute_value = self.send(attribute_name)
                I18n.t("activerecord.attributes.#{self.class.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
              end
            elsif defined?(Mongoid::Document) && self.class.ancestors.include?(Mongoid::Document)
              self.class.send(:define_method, "#{attribute_name}_translated") do
                attribute_value = self.send(attribute_name)
                I18n.t("mongoid.attributes.#{self.class.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
              end
            else
              self.class.send(:define_method, "#{attribute_name}_translated") do
                attribute_value = self.send(attribute_name)
                I18n.t("translated_attribute_value.#{self.class.to_s.downcase}.#{attribute_name}_translation.#{attribute_value}")
              end
            end # of if chain
          end # of each
        end # of define_translated_value_for

    end # of InstanceMethods module
  end # of Base module
end # of TranslatedAttributeValue module
