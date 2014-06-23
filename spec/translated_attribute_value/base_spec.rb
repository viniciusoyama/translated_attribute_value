# encoding: utf-8
require 'spec_helper'

describe TranslatedAttributeValue::Base do
  before(:each) do
    stub_const("I18n", Object.new)
  end

  describe "translated_value_for" do
    describe 'ActiveRecord', f:true do
      let(:test_model_instance) {
        Class.new ActiveRecord::Base do

          def status
            'my_value'
          end

          def self.to_s
            "nome_classe"
          end

        end.new
      }

      specify do
        expect(test_model_instance).to receive(:method_missing).once.and_call_original
        expect(I18n).to receive(:t).with("activerecord.attributes.nome_classe.status_translation.my_value").twice
        2.times{ test_model_instance.status_translated }
      end

    end

    describe 'Mongoid' do
      let(:test_model_instance) {
        Class.new do
          include Mongoid::Document

          def status
            'my_value'
          end

          def self.to_s
            "nome_classe"
          end

        end.new
      }

      specify do
        expect(test_model_instance).to receive(:method_missing).once.and_call_original
        expect(I18n).to receive(:t).with("mongoid.attributes.nome_classe.status_translation.my_value").twice
        2.times{ test_model_instance.status_translated }
      end

    end

    describe 'without ActiveRecord or Mongoid' do
      let(:test_model_instance) {
        Class.new do
          include TranslatedAttributeValue::Base

          def status
            'my_value'
          end

          def self.to_s
            "nome_classe"
          end

        end.new
      }

      specify do
        expect(test_model_instance).to receive(:method_missing).once.and_call_original
        expect(I18n).to receive(:t).with("translated_attribute_value.nome_classe.status_translation.my_value").twice
        2.times{ test_model_instance.status_translated }
      end

    end

  end

end
