$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mongoid_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mongoid_cart"
  s.version     = MongoidCart::VERSION
  s.authors     = ["Jan Jezek"]
  s.email       = ["mail@mediatainment-productions.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MongoidCart."
  s.description = "TODO: Description of MongoidCart."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
