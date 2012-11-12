require 'spec_helper'

describe ConfigReader::Config do

  describe :initialize do
    it "should update config attributes" do
        ConfigReader.initialize do
          config.auto_build_config_objects = true
          ConfigReader.config.auto_build_class = ConfigReader
          ConfigReader.config.config_folder = "moshe"
        end
        ConfigReader.config.auto_build_config_objects.should == true
        ConfigReader.config.auto_build_class.should == ConfigReader
        ConfigReader.config.config_folder.should == "moshe"
    end

    it "should not be able to run initialize more than once" do
      ConfigReader.initialize do
        config.auto_build_config_objects = true
      end
      ConfigReader.config.auto_build_config_objects.should == true
      ConfigReader.initialize do
        config.auto_build_config_objects = false
      end
      ConfigReader.config.auto_build_config_objects.should == true
    end
  end

  describe :build_config_files do
    before :all do
      ConfigReader.config.config_folder = "#{ConfigReader::Engine.root}/spec/config/auto_build"
      ConfigReader.config.auto_build_class = Object
    end

    after :each do
      Object.send(:remove_const, :FAKE_SIMPLE) if Object.const_defined? :FAKE_SIMPLE
      Object.send(:remove_const, :FAKE_ENV) if Object.const_defined? :FAKE_ENV
    end

    it "should auto-build flat config file" do
      ConfigReader.config.auto_build_config_objects = true
      ConfigReader.build_config_files
      FAKE_SIMPLE.class.should == ConfigReader::FlatConfigReader
    end

    it "should auto-build env config file" do
      ConfigReader.config.auto_build_config_objects = true
      ConfigReader.build_config_files
      FAKE_ENV.class.should == ConfigReader::EnvConfigReader
    end

    it "should not auto-build when auto_build_config_objects is false" do
      ConfigReader.config.auto_build_config_objects = false
      ConfigReader.build_config_files
      expect { FAKE_SIMPLE }.to raise_error(NameError)
    end

  end
end