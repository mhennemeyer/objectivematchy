require File.dirname(__FILE__) + '/spec_helper'

describe Step do
  describe "'Given a blank Object', with no args" do
    before(:each) do
      @line = "Given a blank Object"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_false
    end
    
    it "finds the first part" do
      @step.first_part.should eql("Given_a_blank_Object")
    end
    
    it "finds the args" do
      @step.args.should eql([])
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
    
    it "exposes itself as a string" do
      @step.to_s.should eql("[self Given_a_blank_Object];")
    end
    
  end
  
  describe "'Given a custom Object 'Bob'', with one arg 'Bob'" do
    before(:each) do
      @line = "Given a custom Object 'Bob'"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the first part" do
      @step.first_part.should eql("Given_a_custom_Object___")
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob"])
    end

    it "has message: Given_a_custom_Object___:@\"Bob\"" do
      @step.message.should eql('Given_a_custom_Object___:@"Bob"')
    end
    
    it "exposes itself as a string" do
      @step.to_s.should eql("[self Given_a_custom_Object___:@\"Bob\"];")
    end
  end
  
  describe "'Given a custom Object 'Bob' so far', with one arg 'Bob'" do
    before(:each) do
      @line = "Given a custom Object 'Bob' so far"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the first part" do
      @step.first_part.should eql("Given_a_custom_Object____so_far")
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob"])
    end

    it "has message: Given_a_custom_Object____so_far:@\"Bob\"" do
      @step.message.should eql('Given_a_custom_Object____so_far:@"Bob"')
    end
    
    it "exposes itself as a string" do
      @step.to_s.should eql("[self Given_a_custom_Object____so_far:@\"Bob\"];")
    end
  end
  
  describe "'Given a custom Object 'Bob' with attribute 'Jim'', with two args" do
    before(:each) do
      @line = "Given a custom Object 'Bob' with attribute 'Jim'"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob", "Jim"])
    end
    
    it "finds the first part" do
      @step.first_part.should eql("Given_a_custom_Object____with_attribute___")
    end

    it "has a message 'Given_a_custom_Object____with_attribute___:@\"Bob\" arg:@\"Jim\"'" do
      @step.message.should eql('Given_a_custom_Object____with_attribute___:@"Bob" arg:@"Jim"')
    end
    
    it "exposes itself as a string" do
      @step.to_s.should eql("[self Given_a_custom_Object____with_attribute___:@\"Bob\" arg:@\"Jim\"];")
    end
  end
  
  describe "'Given a custom Object 'Bob' with attribute 'Jim' so far', with two args" do
    before(:each) do
      @line = "Given a custom Object 'Bob' with attribute 'Jim' so far"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end

    it "has a message 'Given_a_custom_Object____with_attribute____so_far:@\"Bob\" arg:@\"Jim\"'" do
      @step.message.should eql('Given_a_custom_Object____with_attribute____so_far:@"Bob" arg:@"Jim"')
    end
  end
  
  describe "'Given a custom Object 'Bob' with attribute 'Jim' and 'John'', with three args" do
    before(:each) do
      @line = "Given a custom Object 'Bob' with attribute 'Jim' and 'John'"
      @step = Step.new({
        :title => @line, 
        :body  => @line
      })
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob", "Jim", 'John'])
    end
    
    it "finds the first part" do
      @step.first_part.should eql("Given_a_custom_Object____with_attribute____and___")
    end

    it "has a message 'Given_a_custom_Object____with_attribute___:@\"Bob\" arg:@\"Jim\" arg:@\"John\"'" do
      @step.message.should eql('Given_a_custom_Object____with_attribute____and___:@"Bob" arg:@"Jim" arg:@"John"')
    end
  end
end