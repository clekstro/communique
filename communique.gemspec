$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "communique/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "communique"
  s.version     = Communique::VERSION
  s.authors     = ["Curtis Ekstrom"]
  s.email       = ["ce@canvus.io"]
  s.homepage    = "https://www.github.com/clekstro/communique"
  s.summary     = "Simple Rails engine to send messages (with optional email notifications) between users"
  s.description = "Inbox-like messaging service for Rails 3.2 apps"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]


  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "devise", "~>2.1.2"
  s.add_dependency "sass-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "font-awesome-sass-rails"
  s.add_dependency "slim"
  s.add_dependency "jquery-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "backbone-on-rails"


  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "pry"
end
