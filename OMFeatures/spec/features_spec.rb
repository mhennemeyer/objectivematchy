require File.dirname(__FILE__) + '/spec_helper'

describe Feature do
  before(:each) do
    @feature_body = <<-END 
    Feature: Say Hello World

    	As a Developer 
    	I want to let my system say 'Hello World'
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
  end
  context ", New" do
    
    before(:each) do
      @feature = Feature.new({:title => "Title", 
                              :body => @feature_body})
    end
    
    it "has a title" do
      @feature.title.should eql('Title')
    end
    
    it "has a body" do
      @feature.body.should eql(@feature_body)
    end
  end
end