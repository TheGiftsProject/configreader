require 'rails'

module ConfigReader

  class Engine < Rails::Engine

    initializer "engine.configure_rails_initialization" do |app|
      ConfigReader.auto_build
    end
  end
end