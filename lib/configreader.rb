require 'active_support/dependencies'

module ConfigReader

  mattr_accessor :app_root

  def self.setup
    yield self
  end

end

require 'configreader/engine'
require 'configreader/flat_configreader'
