require 'ostruct'
require 'singleton'

module ConfigReader
  class FlatConfigReader
    include Singleton

    def self.load(config_file_name)
      OpenStruct.new(YAML.load_file(full_path(config_file_name)))
    end

    protected
    def self.full_path(file_name)
      File.join(ConfigReader.config_path, file_name)
    end
  end
end
