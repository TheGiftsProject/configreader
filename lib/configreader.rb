require 'active_support/dependencies'
require 'configreader/config'
require 'yaml'
require 'pathname'

module ConfigReader

  mattr_accessor :app_root
  mattr_accessor :initialized

  def self.initialize(&block)
    return if ConfigReader.initialized
    ConfigReader.module_eval &block
    build_config_files
    ConfigReader.initialized = true
  end

  def self.config
    @config ||= ConfigReader::Config.default
  end

  def self.build_config_files
    return unless config.auto_build_config_objects

    build_files(config.config_folder, FlatConfigReader)
    build_files("#{config.config_folder}/env", EnvConfigReader)
  end

  def self.build_files(folder, klass)
    Dir["#{folder}/*.yml"].each do |file|
      path = Pathname.new(file)
      next if path.directory? or !path.exist?

      config.auto_build_class.class_eval do
        const_set(path.basename('.*').to_s.upcase, klass.new(YAML.load_file(file)))
      end
    end

  end

end

require 'configreader/engine'
require 'configreader/flat_configreader'
require 'configreader/env_configreader'
