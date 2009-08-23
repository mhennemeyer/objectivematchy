require File.dirname(__FILE__) + '/spec_helper'

describe "GivenScenario" do
  before(:each) do
    
    @given_scenario_body = <<-END 
Given a blank Object
When i send it hello
It should return 'Hello, World!'
    END
    
    @given_scenario = Scenario.new({
      :title => "An existing Scenario", 
      :body  => @given_scenario_body
    })
    
    @scenario_body = <<-END 
GivenScenario: An existing Scenario
When i send it hello
It should return 'Hello, World!'
    END
  
    @scenario = Scenario.new({
      :title => "A Scenario", 
      :body  => @scenario_body
    })
  end
  
  it "knows that it has GivenScenarios" do
    @scenario.has_given_scenarios?.should be_true
  end
  
  context "aggregated" do
    
    before(:each) do
      @mock_feature = mock(Feature)
      @mock_feature.stub!(:scenarios).and_return([@scenario, @given_scenario])
      @scenario.stub!(:parent).and_return(@mock_feature)
      @scenario.collect_steps
    end
    
    it "expands given_scenarios in body" do
      expected = <<-END 
Given a blank Object
When i send it hello
It should return 'Hello, World!'
When i send it hello
It should return 'Hello, World!'
  END
      
      @scenario.expand_given_scenarios_in_body.should eql(expected.strip)
    end
  end

end