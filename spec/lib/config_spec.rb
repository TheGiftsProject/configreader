require 'spec_helper'

describe ConfigReader::Config do
  describe :auto_build do
    before :all do
      ConfigReader.config.config_folder = "#{ConfigReader::Engine.root}/spec/config/auto_build"
      ConfigReader.config.auto_build_class = Object
      ConfigReader.config.auto_build_config_objects = true
    end

    after :each do
      Object.send(:remove_const, :FAKE_SIMPLE) if Object.const_defined? :FAKE_SIMPLE
      Object.send(:remove_const, :FAKE_ENV) if Object.const_defined? :FAKE_ENV
    end

    it "should auto-build flat config file" do
      ConfigReader.auto_build
      FAKE_SIMPLE.class.should == ConfigReader::FlatConfigReader
    end

    it "should auto-build env config file" do
      ConfigReader.auto_build
      FAKE_ENV.class.should == ConfigReader::EnvConfigReader
    end

    it "should not auto-build when auto_build_config_objects is false" do
      ConfigReader.config.auto_build_config_objects = false
      ConfigReader.auto_build
      expect { FAKE_SIMPLE }.to raise_error(NameError)
    end

  end
end