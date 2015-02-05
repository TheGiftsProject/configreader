require 'spec_helper'

describe ConfigReader::EnvConfigReader do

  before do
    ConfigReader::EnvConfigReader.any_instance.stub(:config_path => "#{ConfigReader::Engine.root}/spec/config")
  end

  subject { ConfigReader::EnvConfigReader.new("fake_env.yml") }

  it "should let you access data under the right env" do
    subject.devid.should eq "devid"
    subject.appid.should eq "appid"
  end

  it "should not let you access data under other environments" do
    subject.only_production.should be_nil
    subject.devid.should_not eq "productionDevId"
  end

  it "should enable you to read the id attribute" do
    subject.id.should eq "testID"
  end

  context 'when an environment does not exist in the configuration' do

    it 'should fallback to default settings if defaults exist' do
      Rails.stub(:env) { 'unknown' }

      subject.id.should eq 'defaultID'
      subject.appid.should eq 'defaultAppID'
      subject.certid.should eq 'defaultCertID'
    end

    it 'should raise an EnvironmentNotFoundInYaml when loading if defaults do not exist' do
      expect {
        ConfigReader::EnvConfigReader.new("fake_invalid.yml")
      }.to raise_error(ConfigReader::EnvConfigReader::EnvironmentNotFoundInYaml)
    end

  end

  context 'when an environment only exists partially' do
    before { Rails.stub(:env) { 'production' } }
    it 'should deep merge the defaults' do
      subject.devid.should eq 'productionDevId'
      subject.certid.should eq 'defaultCertID'
    end
  end

end