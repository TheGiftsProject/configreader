# -*- encoding: utf-8 -*-
require File.expand_path("../lib/configreader/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "configreader"
  s.version     = ConfigReader::VERSION
  s.authors     = ["Itay Adler"]
  s.email       = ["itayadler@gmail.com"]
  s.homepage    = "https://github.com/TheGiftsProject/configreader"
  s.summary     = %q{ConfigReader - An easy way to manage your configuration files}
  s.description = %q{ConfigReader provides an easy way to load up your configuration YAML files into Ruby objects,
                  providing a more concise API to access your configuration data, by accessing methods instead of Hash keys. It also
                  allows you to configure environment aware configuration objects, and by so inverting the logic of
                  environment specific configuration into the ConfigReader.}

  s.files         = `git ls-files`.split("\n")
  s.require_path  = "lib"
  s.test_files = Dir.glob('spec/lib/*_spec.rb')


  s.add_dependency 'rails'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end