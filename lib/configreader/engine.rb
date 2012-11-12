require 'rails'

module ConfigReader

  class Engine < Rails::Engine

    initializer "engine.configure_rails_initialization" do |app|
      ConfigReader.auto_build(app)
    end
  end
end