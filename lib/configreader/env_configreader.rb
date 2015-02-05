require File.expand_path('../flat_configreader', __FILE__)

module ConfigReader

  class EnvConfigReader < Hashie::Mash

    DEFAULT_KEY = 'defaults'

    include ConfigReader::FileLoading
    include Hashie::Extensions::DeepMerge

    class EnvironmentNotFoundInYaml < StandardError ; end

    def initialize(config)
      config_data = load_config(config)
      env_data = config_data[Rails.env] || {}
      default_data = config_data[DEFAULT_KEY] || {}

      super(default_data)
      self.deep_merge!(env_data)
      raise EnvironmentNotFoundInYaml.new(Rails.env) if self.empty?
    end

  end
end

