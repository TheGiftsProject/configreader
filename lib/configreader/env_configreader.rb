require File.expand_path('../flat_configreader', __FILE__)

module ConfigReader

  class EnvConfigReader < FlatConfigReader

    class EnvironmentNotFoundInYaml < StandardError ; end

    def initialize(file_name)
      super(file_name)
      @data = @data[Rails.env] || @data['defaults']
      raise EnvironmentNotFoundInYaml.new if @data.nil?
    end

  end
end

