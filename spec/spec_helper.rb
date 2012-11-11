require 'rubygems'
require 'bundler/setup'
require 'configreader'

#Monkey patching rails env to be test
Rails.env = "test"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end