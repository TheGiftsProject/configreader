require 'active_support/dependencies'

module ConfigReader

  def self.config
    @config ||= ConfigReader::Config.default
  end

end

require 'configreader/engine'
require 'configreader/flat_configreader'
