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
      @feature = Feature.new
    end
    
    it "has a title" do
      @feature.title = 'a features title'
      @feature.title.should eql('a features title')
    end
    
    it "has a body" do
      @feature.body = @feature_body
      @feature.body.should eql(@feature_body)
    end
  end
end