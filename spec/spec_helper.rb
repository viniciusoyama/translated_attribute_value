ENV["RAILS_ENV"] = 'test'
require 'rubygems'
require 'bundler/setup'
require 'active_support'
require 'active_record'
require 'mongoid'
require 'nulldb_rspec'
require 'translated_attribute_value'
require 'debugger'
include NullDB::RSpec::NullifiedDatabase

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

NullDB.configure {|ndb| def ndb.project_root;'./';end}
ActiveRecord::Base.establish_connection :adapter => :nulldb
