require 'spec_helper'
require_relative '../../lib/configreader/env_configreader'

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

  context "configuration file with out test env" do
    it "should raise an EnvironmentNotFoundInYaml when loading" do
      expect {
        ConfigReader::EnvConfigReader.new("fake_invalid.yml")
      }.to raise_error(ConfigReader::EnvConfigReader::EnvironmentNotFoundInYaml)
    end
  end



end