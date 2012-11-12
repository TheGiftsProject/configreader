module ConfigReader
  class Config

    attr_accessor :config_folder, :auto_build_config_objects, :auto_build_class

    def self.default
      new.instance_eval {
        @config_folder = "#{ConfigReader.app_root}/config/configreader"
        @auto_build_config_objects = false
        @auto_build_class = Object

        self
      }
    end
  end
end