require 'rails'

module ConfigReader

  class Engine < Rails::Engine

    initializer "engine.auto_build_configreader", :before => :load_config_initializers do |app|
      ConfigReader.app_root = app.root
    end
  end
end