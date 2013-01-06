require 'spec_helper'
require File.expand_path('../../../lib/configreader/env_configreader', __FILE__)

describe ConfigReader::EnvConfigReader do

  before do
    ConfigReader::EnvConfigReader.any_instance.stub(:relative_path => "#{ConfigReader::Engine.root}/spec/config")
  end

  subject { ConfigReader::EnvConfigReader.new("fake_env.yml") }

  it "should let you access data under the right env" do
    subject.devid.should == "devid"
    subject.appid.should == "appid"
  end

  it "should not let you access data under other enviroments" do
    subject.only_production.should be_nil
    subject.devid.should_not == "wrong"
  end

  it "should enable you to read the id attribute" do
    subject.id.should == "testID"
  end

  context 'when an environment does not exist in the configuration' do

    it 'should fallback to default settings if defaults exist' do
      Rails.stub(:env) { 'unknown' }
      config = ConfigReader::EnvConfigReader.new 'fake_env.yml'

      config.id.should == 'defaultID'
      config.appid.should == 'defaultAppID'
      config.certid.should == 'defaultCertID'
    end

    it 'should raise an EnvironmentNotFoundInYaml when loading if defaults do not exist' do
      expect {
        ConfigReader::EnvConfigReader.new("fake_invalid.yml")
      }.to raise_error(ConfigReader::EnvConfigReader::EnvironmentNotFoundInYaml)
    end

  end

end