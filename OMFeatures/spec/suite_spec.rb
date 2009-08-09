require File.dirname(__FILE__) + '/spec_helper'

describe Suite do
  before(:each) do
    @feature_files_path = File.dirname(__FILE__) + "/Resources"
    @suite = Suite.new({
      :feature_files_path => @feature_files_path,
      :feature_file_suffix => "feature"
    })
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
  
  it "finds the feature files located at supplied path" do
    @suite.feature_files.should include(@feature_files_path + "/HelloWorld.feature")
  end
  
  it "won't find other files in location" do
    @suite.feature_files.should_not include(@feature_files_path + "/other.file")
  end
  
  it "reads the feature files" do
    @suite.should_receive(:feature_files).and_return([@feature_files_path + "/HelloWorld.feature"])
    File.should_receive(:open).with(@feature_files_path + "/HelloWorld.feature")
    @suite.all_feature_files_as_strings
  end
  
  it "stores feature files as strings in feature_files array" do
    content_of_feature_file = ""
    File.open(@feature_files_path + "/HelloWorld.feature") do |f|
      f.readlines.each do |l|
        content_of_feature_file << l
      end
    end
    @suite.feature_files_as_strings.should include(content_of_feature_file)
  end
  
  it "has features" do
    @suite.features.should_not be_nil
  end
end