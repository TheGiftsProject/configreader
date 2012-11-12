require 'spec_helper'

describe ConfigReader::Config do
  describe :auto_build do
    before :all do
      ConfigReader.config.auto_build_config_objects = true
      ConfigReader.config.config_folder = "#{ConfigReader::Engine.root}/spec/config/auto_build"
    end

    let(:fake_app) { Class.new }

    it "should auto-build flat config file" do
      ConfigReader.auto_build(fake_app)
      fake_app.const_get(:FAKE_SIMPLE).class.should == ConfigReader::FlatConfigReader
    end

    it "should auto-build env config file" do
      ConfigReader.auto_build(fake_app)
      fake_app.const_get(:FAKE_ENV).class.should == ConfigReader::EnvConfigReader
    end

    it "should not auto-build when auto_build_config_objects is false" do
      ConfigReader.config.auto_build_config_objects = false
      ConfigReader.auto_build(fake_app)
      expect {
        fake_app.const_get(:FAKE_SIMPLE).class
      }.to raise_error(NameError)
    end
  end
end