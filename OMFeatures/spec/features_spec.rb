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
    
    @feature = Feature.new({:title => "Say Hello World", 
                            :body  => @feature_body})
  end
  
  it "has a title" do
    @feature.title.should eql('Say Hello World')
  end
  
  it "has a body" do
    @feature.body.should eql(@feature_body)
  end
  
  it "has a scenario_keyword" do
    @feature.scenario_keyword.should eql("Scenario:")
  end
  
  it "has a given_scenario_keyword" do
    @feature.given_scenario_keyword.should eql("GivenScenario:")
  end
  
  describe "#parse_scenarios" do
    
    before(:each) do
      @feature.parse_scenarios
    end
    
    it "has scenarios" do
      @feature.scenarios.should_not be_nil
    end

    it "has 'With a blank Object' Scenario" do
      scenario = @feature.scenarios.detect {|s| s.title == 'With a blank Object'}
      scenario.should_not be_nil
      scenario.body.should eql(@with_blank_object_scenario_body.strip)
      scenario.parent.should eql(@feature)
    end

    it "has 'With a custom Object' Scenario" do
      scenario = @feature.scenarios.detect {|s| s.title == 'With a custom Object'}
      scenario.should_not be_nil
      scenario.body.should eql(@with_custom_object_scenario_body.strip)
      scenario.parent.should eql(@feature)
    end

    it "exposes itself as a string" do
      expected = <<-END
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
    END
      @feature.to_s.ignore_whitespace.should eql(expected.ignore_whitespace)
    end
    
    it "has a keyword" do
      @feature.keyword.should == "Feature:"
    end
    
    it "has a story" do
      story = <<-END
      As a Developer 
    	I want to let my system say 'Hello World'
    	So that i have a starting point.
      END
      @feature.story.ignore_whitespace.should == story.ignore_whitespace
    end
    
    it "exposes story as html" do
      story = <<-END
      As a Developer <br />
    	I want to let my system say 'Hello World' <br />
    	So that i have a starting point. 
      END
      @feature.story_html.ignore_whitespace.should == story.ignore_whitespace
    end
    
    it "exposes itself as html" do
      @feature.scenarios.each {|s| s.stub!(:to_html).and_return("scenario")}
      expected = <<-END
      <div class="feature">
        <h2 class="feature_title">Feature: Say Hello World</h2>
        <p class="story">
          As a Developer <br />
        	I want to let my system say 'Hello World' <br />
        	So that i have a starting point.
        </p>
        scenario 
        scenario
      </div>
    END
      @feature.to_html.ignore_whitespace.should eql(expected.ignore_whitespace)
    end

    describe "Scenario: 'With a custom Object' " do

      before(:each) do
        @scenario = @feature.scenarios.detect {|s| s.title == 'With a custom Object'}
      end

      it "has steps" do
        @scenario.steps.should_not be_nil
      end

      describe "'Given a custom Object with name 'Bob'' Step" do
        before(:each) do
          @step = @scenario.steps.detect {|s| s.title == "Given a custom Object with name 'Bob'"}
        end

        it "exists" do
          @step.should_not be_nil
        end

        it "has message" do
          @step.message.should eql("Given_a_custom_Object_with_name___:@\"Bob\"")
        end

      end

      describe "'When i send it hello' Step" do
        before(:each) do
          @step = @scenario.steps.detect {|s| s.title == "When i send it hello"}
        end

        it "exists" do
          @step.should_not be_nil
        end

        it "has message" do
          @step.message.should eql("When_i_send_it_hello")
        end

      end

      describe "'It should return 'Hello, World! I am Bob.' Step" do
        before(:each) do
          @step = @scenario.steps.detect {|s| s.title == "It should return 'Hello, World! I am Bob.'"}
        end

        it "exists" do
          @step.should_not be_nil
        end

        it "has message" do
          @step.message.should eql("It_should_return___:@\"Hello, World! I am Bob.\"")
        end
      end 
  end

  end
end