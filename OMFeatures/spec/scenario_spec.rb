require File.dirname(__FILE__) + '/spec_helper'

describe Scenario do
  before(:each) do
    @scenario_body = <<-END 
  		Given a blank Object
  		When i send it hello
  		It should return 'Hello, World!'
    END
  end
  context ", New" do
    
    before(:each) do
      @scenario = Scenario.new({
        :title => "With a blank Object", 
        :body  => @scenario_body})
    end
    
    it "has a title" do
      @scenario.title.should eql("With a blank Object")
    end
    
    it "has a body" do
      @scenario.body.should eql(@scenario_body)
    end
    
    it "has steps" do
      @scenario.steps.should_not be_empty
    end
    
    it "has 'Given blank Object' step" do
      @scenario.steps.detect {|s| s.title == 'Given blank Object'}
    end
  end
end