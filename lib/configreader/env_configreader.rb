require 'singleton'
require 'ostruct'
require_relative 'flat_configreader'

module ConfigReader
  class EnvConfigReader < FlatConfigReader
    include Singleton

    class EnvironmentNotFoundInYaml < StandardError ; end

    def self.load(file_name)
      data = super(file_name)

      begin
        env_data = data.send(Rails.env.to_sym) || data.defaults
      rescue ArgumentError #openstruct seems to throw Argument error if we're using send to access invalid value
      end

      raise EnvironmentNotFoundInYaml.new if env_data.nil?

      OpenStruct.new(env_data)
    end
  end
end

