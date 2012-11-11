module ConfigReader
  class Config

    attr_accessor :config_folder, :auto_build_config_objects

    def self.default
      new.instance_eval {
        @config_folder = "#{ConfigReader::Engine.root}/config"
        @auto_build_config_objects = true

        self
      }
    end
  end
end