# encoding: utf-8
require 'spec_helper'

shared_examples_for 'class_with_translated_attribute' do |i18n_key_name|

  specify "I can call translated_value_for in the model" do
    expect(test_model_instance.class).to respond_to(:translated_value_for)
  end

  describe "I can call a attribute with attribute_translated without defining it" do
    specify "the translation must be called" do
      expect(I18n).to receive(:t).with(i18n_key_name)
      test_model_instance.status_translated
    end

    specify "the method should be defined" do
      test_model_instance.status_translated
      expect(test_model_instance).to respond_to(:status_translated)
    end
  end

end
describe TranslatedAttributeValue::Base do
  before(:each) do
    stub_i18n = Object.new
    stub_i18n.stub("t")
    stub_const("I18n", stub_i18n)
  end

  describe "translated_value_for" do
    describe 'ActiveRecord' do
      let(:test_model_instance) {
        Class.new ActiveRecord::Base do

          def status
            'my_value'
          end

          def self.to_s
            "NomeClasse"
          end

        end.new
      }

      it_behaves_like 'class_with_translated_attribute', "activerecord.attributes.nome_classe.status_translation.my_value"

    end

    describe 'Mongoid' do
      let(:test_model_instance) {
        Class.new do
          include Mongoid::Document

          def status
            'my_value'
          end

          def self.to_s
            "NomeClasse"
          end

        end.new
      }

      it_behaves_like 'class_with_translated_attribute', "mongoid.attributes.nome_classe.status_translation.my_value"
    end

    describe 'without ActiveRecord or Mongoid' do
      let(:test_model_instance) {
        Class.new do
          include TranslatedAttributeValue::Base

          def status
            'my_value'
          end

          def self.to_s
            "NomeClasse"
          end

        end.new
      }

      it_behaves_like 'class_with_translated_attribute', "translated_attribute_value.nome_classe.status_translation.my_value"

    end

  end

end
