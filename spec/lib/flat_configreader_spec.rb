require 'spec_helper'

describe ConfigReader::FlatConfigReader do

  before do
    ConfigReader::FlatConfigReader.any_instance.stub(:config_path => "#{ConfigReader::Engine.root}/spec/config")
  end

  subject { ConfigReader::FlatConfigReader.new("fake_simple.yml") }
  let(:string_value) {"my name"}

  it "should enable you to read attributes from the yml" do
    subject.boolean_value.should be_true
    subject.integer_value.should == 3
    subject.string_value.should == string_value
    subject.quoted_string_value.should == "qtd my name"
    subject.complex_value.should == {'a' => 1, 'b' => 2}
  end

  it 'should act like a string hash' do
    subject['string_value'].should eq string_value
  end

  it 'should act like a symbol hash' do
    subject[:string_value].should eq string_value
  end

  it "should enable you to read the id attribute" do
    subject.id.should == "file"
  end

  it "should return nil for attributes that don't exist" do
    subject.blah_attribute.should be_nil
  end

  it "should raise File not found for wrong name of yml" do
    expect {
      ConfigReader::FlatConfigReader.new("non_existing.yml")
    }.to raise_error(Errno::ENOENT)
  end

  describe :to_h do
    let(:expected_hash) { YAML.load_file("spec/config/fake_simple.yml") }

    it "should return a hash" do
      subject.to_h.should be_a Hash
    end

    it "should return the correct data" do
      subject.to_h.should eq expected_hash
    end

  end

end