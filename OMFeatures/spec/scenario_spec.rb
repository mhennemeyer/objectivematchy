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
      })
      
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
  end
end