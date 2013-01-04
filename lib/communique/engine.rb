require 'rails'
require 'active_attr'
require 'slim'
require 'kaminari'
require 'wysihtml5-rails'
require 'ligature-symbols-rails'
require 'capybara-webkit'
require 'better_errors'

module Communique
  class Engine < ::Rails::Engine
    isolate_namespace Communique

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false, :helper_specs => false
      g.integration_tool :rspec
    end
    silence_warnings do
      require 'pry'
      IRB = Pry
    end
  end
end
