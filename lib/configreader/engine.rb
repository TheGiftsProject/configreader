require 'rails'

module ConfigReader

  class Engine < Rails::Engine
    initializer "engine.auto_create_configreader_before_initializers", :before => :load_config_initializers do |app|

      config_reader_config = config.paths["config/initializers"].existent.select{|file| File.basename(file)=="configreader.rb"}
      load(config_reader_config) if config_reader_config

      ConfigReader.build_config_files(paths) if ConfigReader.auto_create_config_objects
    end

  end
end
