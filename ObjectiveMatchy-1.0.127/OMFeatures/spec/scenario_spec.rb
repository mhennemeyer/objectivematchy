require File.dirname(__FILE__) + '/spec_helper'

describe Scenario do
  before(:each) do
    @scenario_body = <<-END 
  		Given a blank Object
  		When i send it hello
  		It should return 'Hello, World!'
    END
    @mock_feature = mock(Feature)
    @mock_feature.stub!(:scenarios).and_return([])
  end
  context ", New" do
    
    before(:each) do
      
      @scenario = Scenario.new({
        :title   => "With a blank Object", 
        :body    => @scenario_body,
        :parent  => @mock_feature
      }).collect_steps
      
    end
    
    it "has a title" do
      @scenario.title.should eql("With a blank Object")
    end
    
    it "has a body" do
      @scenario.body.should eql(@scenario_body)
    end
    
    it "has a given_scenario_keyword" do
      @scenario.given_scenario_keyword.should eql("GivenScenario:")
    end
    
    it "has steps" do
      @scenario.steps.should_not be_empty
    end
    
    it "belongs to a feature" do
      @scenario.parent.should eql(@mock_feature)
    end
    
    it "exposes itself as a string" do
      expected = <<-END
    -(void) testWithABlankObject
    {
        [self Given_a_blank_Object]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World!"];
    }
      END
      @scenario.to_s.should eql(expected)
    end
    
    it "finds 'Given a blank Object' step" do
      step = @scenario.steps.detect {|s| s.title == 'Given a blank Object'}
      step.should_not be_nil
    end
    
    context "with Given a blank Object step" do
      before(:each) do
        @step = @scenario.steps.detect {|s| s.title == 'Given a blank Object'}
      end
      
      it "has first_part: Given_a_blank_Object" do
        @step.first_part.should eql("Given_a_blank_Object")
      end
      
      it "has no args" do
        @step.should have(0).args
      end
    end
    
    context "with 'It should return 'Hello, World!'' step" do
      before(:each) do
        @step = @scenario.steps.detect {|s| s.title == "It should return 'Hello, World!'"}
      end
      
      it "has first_part: Given_a_blank_Object" do
        @step.first_part.should eql("It_should_return___")
      end
      
      it "has arg: 'Hello, World!'" do
        @step.args[0].should eql('Hello, World!')
      end
    end
    
    context "verification" do
      
      before(:each) do
        @results = <<-END
        Test Case '-[SayHelloWorldTest testWithACustomObject]' passed (0.001 seconds).
        Hello!!!
        2009-08-13 15:21:58.927 otest[1586:80f] HelloButtonHello
        Test Case '-[SayHelloUniverseTest testWithACustomObject]' passed (0.001 seconds).
        /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/OMFeature.m:28: error: -[SayHelloWorldTest testJustOpenedTheApp] : '' should be equal to: 'h', but isn't (with isEqual:).
        Test Case '-[SayHelloWorldTest testJustOpenedTheApp]' failed (0.001 seconds).
        Test Case '-[SayHelloUniverseTest testWithABlankObject]' failed (0.001 seconds).
        Test Case '-[SayHelloTest testWithABlankObject]' failed (0.001 seconds).
        Test Case '-[SayHelloTest testWithACustomObject]' passed (0.001 seconds).
        Test Suite 'SayHelloWorldTest' finished at 2009-08-13 15:21:58 +0200.
        Executed 1 test, with 1 failure (1 unexpected) in 0.001 (0.001) seconds

        Test Suite '/Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/build/Debug-iphonesimulator/ObjectiveMatchyIphoneTest.octest(Tests)' finished at 2009-08-13 15:21:58 +0200.
        Executed 4 tests, with 3 failures (3 unexpected) in 0.004 (0.007) seconds

        /Developer/Tools/RunPlatformUnitTests.include:390: error: Failed tests for architecture 'i386' (GC OFF)
        /Developer/Tools/RunPlatformUnitTests.include:399: note: Completed tests for architectures 'i386'
        
        END
        @mock_feature.should_receive(:test_case_name).and_return("SayHelloTest")
        @scenario.verify_status(@results)
      end
      
      it "verifies its status" do
        @scenario.passed?.should be_false
      end
      
      describe "#to_html" do
        it "does something" do
          @mock_feature.should_receive(:scenario_keyword).and_return("Scenario:")
          @scenario.should_receive(:steps).and_return([mock(Step, :to_html => "steps")])
          expected = <<-END
        <div class="scenario failed">
          <h2 class="scenario_title">Scenario: With a blank Object</h2>
          steps
        </div>
          END
          @scenario.to_html.ignore_whitespace.should == expected.ignore_whitespace
        end
      end
    end
    
  end
end