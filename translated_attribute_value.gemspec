$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "translated_attribute_value/version"

Gem::Specification.new do |spec|
  spec.name          = "translated_attribute_value"
  spec.version       = TranslatedAttributeValue::VERSION.freeze
  spec.authors       = ["Vinícius Oyama"]
  spec.email         = ["vinicius.oyama@gmail.com"]
  spec.description   = %q{Translate attribute values}
  spec.summary       = %q{Translate attribute values}
  spec.authors       = ['Vinícius Oyama']
  spec.email         = "vinicius.oyama@gmail.com.br"
  spec.homepage      = "https://github.com/viniciusoyama/translated_attribute_value"
  spec.license       = "MIT"

  spec.test_files = Dir["spec/**/*"]
  spec.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 4.1"
end
