require File.dirname(__FILE__) + '/spec_helper'

describe Parser do
  before(:each) do
    @parser = Parser.new(["Feature: Hello\n", "Feature: World\n"])
  end
  
  it "has a string" do
    @parser.string.should_not be_nil
  end
  
  it "string consists of concatenated init-array elements" do
    @parser.string.should eql("Feature: Hello\nFeature: World\n")
  end
  
  it "raises if there are no features" do
    lambda { Parser.new(["NoFeature!"]) }.should raise_error
  end
end

describe FeatureParser do
  before(:each) do
    @feature_file_string_1 = <<-END
    Feature: Say Hello World

    	As a Developer 
    	I want to let my system say 'Hello, World!'
    	So that i have a starting point.

    	Scenario: With a blank Object
    		Given a blank Object
    		When i send it hello
    		It should return 'Hello, World!'

    	Scenario: With a custom Object
    		Given a custom Object with name 'Bob'
    		When i send it hello
    		It should return 'Hello, World! I am Bob.'


    Feature: Say Hello Universe

    	As a Developer 
    	I want to let my system say 'Hello, Universe!'
    	So that i have a starting point.

    	Scenario: With a blank Object
    		Given a blank Object
    		When i send it helloUniverse
    		It should return 'Hello, Universe!'

    	Scenario: With a custom Object
    		Given a custom Object with name 'Bob'
    		When i send it helloUniverse
    		It should return 'Hello, Universe! I am Bob.'
    END
    
    @feature_file_string_2 = <<-END
    Feature: Say Hello

    	As a Developer 
    	I want to let my system say 'Hello, World!'
    	So that i have a starting point.

    	Scenario: With a blank Object
    		Given a blank Object
    		When i send it hello
    		It should return 'Hello, World!'

    	Scenario: With a custom Object
    		Given a custom Object with name 'Bob'
    		When i send it hello
    		It should return 'Hello, World! I am Bob.'
    END
    
    @feature_parser = FeatureParser.new([@feature_file_string_1, @feature_file_string_2])
  end
  
  describe "#parse" do
    it "returns features" do
      @feature_parser.parse.each do |f|
        f.class.should eql(Feature)
      end
    end
    
    it "returns Say Hello Feature" do
      @feature_parser.parse.map {|f| f.title }.should include("Say Hello")
    end
    
    it "returns Say Hello World Feature" do
      @feature_parser.parse.map {|f| f.title }.should include("Say Hello World")
    end
    
    it "returns Say Hello Universe Feature" do
      @feature_parser.parse.map {|f| f.title }.should include("Say Hello Universe")
    end
  end
  
end