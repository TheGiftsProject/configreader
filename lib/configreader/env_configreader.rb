require_relative './flat_configreader'

module ConfigReader

  class EnvConfigReader < FlatConfigReader

    class EnvironmentNotFoundInYaml < StandardError ; end

    def initialize(file_name)
      super(file_name)
      @data = @data[Rails.env]
      raise EnvironmentNotFoundInYaml.new if @data.nil?
    end

  end
end

