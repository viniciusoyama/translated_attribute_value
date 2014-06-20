# encoding: utf-8
require 'spec_helper'

describe TranslatedAttributeValue::Base do

  before(:each) do
    stub_const("I18n", Object.new)
  end

  describe "translated_value_for" do
    describe 'ActiveRecord', f:true do
      let(:test_model) {
        Class.new ActiveRecord::Base do
          translated_value_for :status
          def self.to_s
            "nome_classe"
          end
        end.new
      }

      specify do
        test_model.stub(:status).and_return('my_value')
        expect(I18n).to receive(:t).with("activerecord.attributes.nome_classe.status_translation.my_value")
        test_model.status_translated
      end

    end

    describe 'Mongoid' do
      let(:test_model) {
        Class.new do
          include Mongoid::Document
          translated_value_for :status
          def self.to_s
            "nome_classe"
          end
        end.new
      }

      specify do
        test_model.stub(:status).and_return('my_value')
        expect(I18n).to receive(:t).with("mongoid.attributes.nome_classe.status_translation.my_value")
        test_model.status_translated
      end

    end

    describe 'without ActiveRecord or Mongoid' do
      let(:test_model) {
        Class.new do
          extend TranslatedAttributeValue::Base
          translated_value_for :status
          def self.to_s
            "nome_classe"
          end
        end.new
      }

      specify do
        test_model.stub(:status).and_return('my_value')
        expect(I18n).to receive(:t).with("translated_attribute_value.nome_classe.status_translation.my_value")
        test_model.status_translated
      end

    end

  end

end
