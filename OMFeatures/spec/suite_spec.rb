require File.dirname(__FILE__) + '/spec_helper'

describe Suite do
  before(:each) do
    @feature_files_path = File.dirname(__FILE__) + "/Resources"
    @suite = Suite.new({
      :feature_files_path => @feature_files_path,
      :feature_file_suffix => "feature",
      :test_cases_file => @feature_files_path + "/OMFeatureTestCases.m"
    })
  end

  it "has a test_cases_file" do
    @suite.test_cases_file.should eql(@feature_files_path + "/OMFeatureTestCases.m")
  end
    
  it "has feature files" do
    @suite.feature_files.should_not be_nil
  end
  
  it "inits feature files path from hash passed to .new" do
    @suite.feature_files_path.should eql(@feature_files_path)
  end
  
  it "has feature file suffix" do
    @suite.feature_file_suffix.should_not be_nil
  end
  
  it "finds HelloWorld.feature feature files" do
    @suite.feature_files.should include(@feature_files_path + "/HelloWorld.feature")
  end
  
  it "finds OtherFeatureFile.feature feature files" do
    @suite.feature_files.should include(@feature_files_path + "/OtherFeatureFile.feature")
  end
  
  it "won't find other files in location" do
    @suite.feature_files.should_not include(@feature_files_path + "/other.file")
  end
  
  it "reads the HelloWorld.feature feature file" do
    File.stub!(:open)
    File.should_receive(:open).with(@feature_files_path + "/HelloWorld.feature")
    @suite.all_feature_files_as_strings
  end
  
  it "reads the OtherFeatureFile.feature feature file" do
    File.stub!(:open)
    File.should_receive(:open).with(@feature_files_path + "/OtherFeatureFile.feature")
    @suite.all_feature_files_as_strings
  end
  
  it "stores content of HelloWorld.feature as string in feature_files array" do
    content_of_feature_file = ""
    File.open(@feature_files_path + "/HelloWorld.feature") do |f|
      f.readlines.each do |l|
        content_of_feature_file << l
      end
    end
    @suite.feature_files_as_strings.should include(content_of_feature_file)
  end
  
  it "stores content of OtherFeatureFile.feature as string in feature_files array" do
    content_of_feature_file = ""
    File.open(@feature_files_path + "/OtherFeatureFile.feature") do |f|
      f.readlines.each do |l|
        content_of_feature_file << l
      end
    end
    @suite.feature_files_as_strings.should include(content_of_feature_file)
  end
  
  it "has features" do
    @suite.features.should_not be_nil
  end
  
  it "finds Say Hello World Feature" do
    @suite.features.detect {|f| f.title == "Say Hello World"}.should_not be_nil
  end
  
  it "finds Say Hello Universe Feature" do
    @suite.features.detect {|f| f.title == "Say Hello World"}.should_not be_nil
  end
  
  it "finds Say Hello Feature" do
    @suite.features.detect {|f| f.title == "Say Hello"}.should_not be_nil
  end
  
  it "exposes itself as a string" do
    expected = <<-END
  #import "OMFeature.h"
  @interface SayHelloWorldTest : OMFeature
  @end
  @implementation SayHelloWorldTest
  -(void) testWithABlankObject
  {
      [self Given_a_blank_Object]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World!"];
  }
  -(void) testWithACustomObject
  {
      [self Given_a_custom_Object_with_name___:@"Bob"]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World! I am Bob."];
  }
  @end
  @interface SayHelloUniverseTest : OMFeature
  @end
  @implementation SayHelloUniverseTest
  -(void) testWithABlankObject
  {
      [self Given_a_blank_Object]; [self When_i_send_it_helloUniverse]; [self It_should_return___:@"Hello, Universe!"];
  }
  -(void) testWithACustomObject
  {
      [self Given_a_custom_Object_with_name___:@"Bob"]; [self When_i_send_it_helloUniverse]; [self It_should_return___:@"Hello, Universe! I am Bob."];
  }
  @end
  @interface SayHelloTest : OMFeature
  @end
  @implementation SayHelloTest
  -(void) testWithABlankObject
  {
      [self Given_a_blank_Object]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World!"];
  }
  -(void) testWithACustomObject
  {
      [self Given_a_custom_Object_with_name___:@"Bob"]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World! I am Bob."];
  }
  @end
  END
    @suite.to_s.ignore_whitespace.should eql(expected.ignore_whitespace)
  end
  
  it "overwrites its test_cases_file with itself as string" do
    content = File.open(@suite.test_cases_file) {|f| f.readlines}
    content = ""
    File.open(@suite.test_cases_file) do |f|
      f.readlines.each do |l|
        content << l
      end
    end
    content.should eql(@suite.to_s)
  end
end