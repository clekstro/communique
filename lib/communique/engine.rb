module Communique
  class Engine < ::Rails::Engine    
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.integration_tool :rspec
    end

    isolate_namespace Communique
  end
end
