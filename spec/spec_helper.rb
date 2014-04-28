ENV["RAILS_ENV"] ||= 'test'
require 'rubygems'
require 'bundler/setup'
require 'translated_attribute_value'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }
