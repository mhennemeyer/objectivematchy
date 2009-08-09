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
    
    @with_blank_object_scenario_body = <<-END
        Given a blank Object
    		When i send it hello
    		It should return 'Hello, World!'
    END
    
    @with_custom_object_scenario_body = <<-END
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
    
    it "has scenarios" do
      @feature.scenarios.should_not be_nil
    end
    
    it "has 'With a blank Object' Scenario" do
      scenario = @feature.scenarios.detect {|s| s.title == 'With a blank Object'}
      scenario.should_not be_nil
      scenario.body.should eql(@with_blank_object_scenario_body.strip)
    end
    
    it "has 'With a custom Object' Scenario" do
      scenario = @feature.scenarios.detect {|s| s.title == 'With a custom Object'}
      scenario.should_not be_nil
      scenario.body.should eql(@with_custom_object_scenario_body.strip)
    end
  end
end