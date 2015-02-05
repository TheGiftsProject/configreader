module ConfigReader

  class FlatConfigReader < Hashie::Mash

    include ConfigReader::FileLoading

    def initialize(config)
      super(load_config(config))
    end

  end
end