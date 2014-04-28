# encoding: utf-8
require 'spec_helper'

describe TranslatedAttributeValue::Base do
  let(:test_model) { Class.new do
      include TranslatedAttributeValue::Base
      translated_value_for :status
    end.new
  }

  before(:each) do
    stub_const("I18n", double)
  end

  describe "translated_value_for" do
    describe 'ActiveRecord' do
      before(:each) do
        stub_const("I18n", Object.new)
        stub_const("ActiveRecord::Base", Object.new)
      end

      specify do
        test_model.stub(:status).and_return('my_value')
        expect(I18n).to receive(:t).with("activerecord.attributes.user.status_translation.status.my_value")
        test_model.status_translated
      end

    end
    describe 'Mongoid' do
      before(:each) do
        stub_const("I18n", Object.new)
        stub_const("Mongoid::Document", Object.new)
      end

      specify do
        test_model.stub(:status).and_return('my_value')
        expect(I18n).to receive(:t).with("mongoid.attributes.user.status_translation.status.my_value")
        test_model.status_translated
      end

    end
    describe 'Mongoid' do
      before(:each) do
        stub_const("I18n", Object.new)
      end

      specify do
        test_model.stub(:status).and_return('my_value')
        expect(I18n).to receive(:t).with("translated_attribute_value.user.status_translation.status.my_value")
        test_model.status_translated
      end

    end

  end

end
