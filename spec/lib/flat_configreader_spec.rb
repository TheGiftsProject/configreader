require 'spec_helper'

describe ConfigReader::FlatConfigReader do

  before do
    ConfigReader.config_path = "#{ConfigReader::Engine.root}/spec/config"
  end

  subject { ConfigReader::FlatConfigReader.load("fake_simple.yml") }

  it "should enable you to read attributes from the yml" do
    subject.boolean_value.should be_true
    subject.integer_value.should == 3
    subject.string_value.should == "my name"
    subject.quoted_string_value.should == "qtd my name"
    subject.complex_value.should == {'a' => 1, 'b' => 2}
  end

  it 'should enable you to read the id attribute' do
    subject.id.should == "file"
  end

  it 'should return nil for attributes that dont exist' do
    subject.blah_attribute.should be_nil
  end

  it 'should raise File not found for wrong name of yml' do
    expect {
      ConfigReader::FlatConfigReader.load('non_existing.yml')
    }.to raise_error(Errno::ENOENT)
  end

  it 'should be singleton, and not allow initialization' do
    expect {
      ConfigReader::FlatConfigReader.new('something')
    }.to raise_error(NoMethodError)
  end
end
