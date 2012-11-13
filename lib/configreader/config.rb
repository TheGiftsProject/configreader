module ConfigReader
  class Config

    attr_accessor :auto_create_config_folder, :auto_create_config_objects, :auto_create_class

    def self.default
      new.instance_eval {
        @auto_create_config_folder = "#{ConfigReader.app_root}/config/configreader"
        @auto_create_config_objects = false
        @auto_create_class = Object

        self
      }
    end
  end
end