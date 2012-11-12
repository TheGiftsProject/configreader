require 'active_support/dependencies'
require 'configreader/config'
require 'yaml'
require 'pathname'

module ConfigReader

  def self.config
    @config ||= ConfigReader::Config.default
  end

  def self.auto_build(app)
    return unless config.auto_build_config_objects

    build_config_files(app, config.config_folder, FlatConfigReader)
    build_config_files(app, "#{config.config_folder}/env", EnvConfigReader)
  end

  private

  def self.build_config_files(app, folder, klass)
    Dir["#{folder}/*"].each do |file|
      path = Pathname.new(file)
      next if path.directory?

      app.instance_eval do
        const_set(Pathname.new(file).basename('.*').to_s.upcase, klass.new(YAML.load_file(file)))
      end
    end
  end

end

require 'configreader/engine'
require 'configreader/flat_configreader'
