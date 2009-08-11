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
  
  end
  
  it "knows that it has GivenScenarios" do
    Scenario.has_given_scenarios?(@scenario_body).should be_true
  end
  
  it "expands given_scenarios in body" do
    scenario = mock(Scenario)
    scenario.stub!(:body).and_return(@scenario_body.strip)
    given_scenario = mock(Scenario)
    given_scenario.stub!(:body).and_return(@given_scenario_body.strip)
    given_scenario.stub!(:title).and_return("An existing Scenario")
    feature = mock(Feature)
    feature.should_receive(:scenarios).and_return([given_scenario])
    scenario.should_receive(:parent).and_return(feature)
    expected = <<-END 
Given a blank Object
When i send it hello
It should return 'Hello, World!'
When i send it hello
It should return 'Hello, World!'
END
    Scenario.expand_given_scenarios_in_body(scenario).should eql(expected.strip)
  end

end