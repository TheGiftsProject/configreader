module ConfigReader
  class Config

    attr_accessor :config_folder, :auto_build_config_objects, :auto_build_class

    def self.default
      new.instance_eval {
        @config_folder = "#{ConfigReader::Engine.root}/config"
        @auto_build_config_objects = true
        @auto_build_class = Object

        self
      }
    end
  end
end