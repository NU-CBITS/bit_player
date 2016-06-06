# frozen_string_literal: true
module BitPlayer
  # Mountable application.
  class Engine < ::Rails::Engine
    isolate_namespace BitPlayer

    config.generators do |g|
      g.test_framework :rspec, view_specs: false
      g.assets false
      g.helper false
    end
  end
end
