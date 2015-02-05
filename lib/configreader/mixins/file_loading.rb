module ConfigReader
  module FileLoading

    def load_config(config)
      config.is_a?(String) ? read_file(config) : config
    end

    private

    def config_path
      File.join(Rails.root, "config")
    end

    def full_path(file_name)
      File.join(config_path, file_name)
    end

    def read_file(file_name)
      YAML.load_file(full_path(file_name))
    end

  end
end