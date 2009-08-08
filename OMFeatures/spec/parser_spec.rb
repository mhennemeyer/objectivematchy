require File.dirname(__FILE__) + '/spec_helper'

describe Parser do
  before(:each) do
    @parser = Parser.new(["string1\n", "string2"])
  end
  
  it "has a string" do
    @parser.string.should_not be_nil
  end
  
  it "string consists of concatenated init-array elements" do
    @parser.string.should eql("string1\nstring2")
  end
  
end

describe FeatureParser do
  before(:each) do
    @feature_file_string_1 = <<-END
    
    END
    @feature_parser = FeatureParser.new(["string1\n", "string2"])
  end
  
  
end