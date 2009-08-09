require File.dirname(__FILE__) + '/spec_helper'

describe Step do
  describe "no args" do
    before(:each) do
      @line = "Given a blank Object"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end

    it "has a title" do
      @step.title.should eql(@line)
    end

    it "has a body" do
      @step.body.should eql(@line)
    end

    it "has a message" do
      @step.message.should eql("Given_a_blank_Object")
    end
  end
  
  describe "one arg" do
    before(:each) do
      @line = "Given a custom Object 'Bob'"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end

    it "has a title" do
      @step.title.should eql(@line)
    end

    it "has a body" do
      @step.body.should eql(@line)
    end

    it "has a message" do
      @step.message.should eql('Given_custom_Object:@"Bob"')
    end
  end
end