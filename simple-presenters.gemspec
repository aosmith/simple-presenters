$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple-presenters/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple-presenters"
  s.version     = SimplePresenters::VERSION
  s.authors     = ["Alex Smith"]
  s.email       = ["aosmith@gmail.com"]
  s.homepage    = "http://alexsmith.io"
  s.summary     = "A Simple Presenter Gem"
  s.description = "TLDR"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.13.0"
  #s.add_development_dependency "sqlite3"
end
