module ConfigReader

  class FlatConfigReader

    def initialize(config)
      @data = config.is_a?(String) ? read_file(config) : config

      remove_id_method
    end

    def method_missing(name)
      @data[name.to_s]
    end

    #def local_constant_names
    #  nil
    #end

    protected

    def relative_path
      "#{Rails.root}/config"
    end

    def full_path(file_name)
      File.join(relative_path, file_name)
    end

    def read_file(file_name)
      YAML.load_file(full_path(file_name))
    end

    def remove_id_method
      instance_eval "undef id" if methods.any? { |method| method == "id" }
    end

  end
end