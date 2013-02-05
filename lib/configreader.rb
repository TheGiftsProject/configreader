require 'active_support/dependencies'
require 'yaml'
require 'pathname'

module ConfigReader
  mattr_accessor :config_path,
                 :app_root,
                 :auto_create_config_folder,
                 :auto_create_config_objects,
                 :auto_create_class

  @@app_root = defined?(Rails) ? Rails.root : Dir.pwd
  # root path of config files
  @@config_path = "#{@@app_root}/config"
  # root path of config files to auto load if the @@auto_create_config_objects is set
  # this folder will be read using the FlatConfigReader
  @@auto_create_config_folder = "#{@@config_path}/configreader"

  # this path would be read using the EnvConfigReader
  @@auto_create_env_config_folder = "#{@@auto_create_config_folder}/env"

  # should the gem auto load and create yaml files from the @@auto_create_config_folder
  # and the @@auto_create_env_config_folder?
  @@auto_create_config_objects = false

  # You can also override the default auto_create behavior to set the
  # consts instead on Object, to something else like ConfigReader,
  # so then you 'll be able to access them using that object: `ConfigReader::EXAMPLE`
  @@auto_create_class = Object

  def self.build_config_files
    build_files(@@auto_create_config_folder, FlatConfigReader)
    build_files(@@auto_create_env_config_folder, EnvConfigReader)
  end

  def self.build_files(folder, klass)
    Dir.glob(File.join(folder, "*.yml")).each do |file|
      path = Pathname.new(file)

      @@auto_create_class.class_eval do
        const_set(path.basename('.*').to_s.upcase, klass.new(YAML.load_file(file)))
      end
    end
  end

end

require 'configreader/engine'
require 'configreader/flat_configreader'
require 'configreader/env_configreader'
