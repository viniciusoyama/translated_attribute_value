ENV["RAILS_ENV"] = 'test'
require 'rubygems'
require 'bundler/setup'
require 'active_support'
require 'active_record'
require 'mongoid'
require 'translated_attribute_value'
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

require 'nulldb_rspec'
include NullDB::RSpec::NullifiedDatabase
NullDB.configure {|ndb| def ndb.project_root;'./';end}
ActiveRecord::Base.establish_connection :adapter => :nulldb
