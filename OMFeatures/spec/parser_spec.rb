require File.dirname(__FILE__) + '/spec_helper'

describe Parser do
  
  before(:each) do
    @valid_attributes = {
      :string => "Feature: f1 \n body",
      :keyword => "Feature:",
    }
    @parser = Parser.new(@valid_attributes)
  end
  
  it "has a string" do
    @parser.string.should_not be_nil
  end
  
  it "has a keyword" do
    @parser.keyword.should_not be_nil
  end
  
  describe ".title_and_body_by_keyword_from_string({:string => s, :keyword => 'Title:'})" do
    it "returns :title => 'Title', body => 'Body' for :string => 'Title: Title \\n Body'" do
      Parser.title_and_body_by_keyword_from_string({
        :string => "Title: Title \n Body", 
        :keyword => "Title:"
      }).should == ([{
          :title => "Title",
          :body  => "Body"
        }])
    end
    
    it "returns [{:title => 'Title', body => 'Body'}, {:title => 'Title', body => 'Body'}] for :string => 'Title: Title \\n Body \\n Title: Title \\n Body'" do
      Parser.title_and_body_by_keyword_from_string({
        :string => "Title: Title \n Body \n Title: Title \n Body", 
        :keyword => "Title:"
      }).should == ([{ :title => "Title", :body  => "Body"},   
                     { :title => "Title", :body  => "Body"}])
    end
  end
  
  context "with :keyword => 'Feature:' and :create => Feature" do
       
    before(:each) do
      @feature_file_string_1 = <<-END
      Feature: Say Hello World

      	As a Developer 
      	I want to let my system say 'Hello, World!'
      	So that i have a starting point.

      	Scenario: With a blank Object
      		Given a blank Object
      		When i send it hello
      		It should return 'Hello, World!'

      	Scenario: With a custom Object
      		Given a custom Object with name 'Bob'
      		When i send it hello
      		It should return 'Hello, World! I am Bob.'


      Feature: Say Hello Universe

      	As a Developer 
      	I want to let my system say 'Hello, Universe!'
      	So that i have a starting point.

      	Scenario: With a blank Object
      		Given a blank Object
      		When i send it helloUniverse
      		It should return 'Hello, Universe!'

      	Scenario: With a custom Object
      		Given a custom Object with name 'Bob'
      		When i send it helloUniverse
      		It should return 'Hello, Universe! I am Bob.'
      END

      @feature_file_string_2 = <<-END
      Feature: Say Hello

      	As a Developer 
      	I want to let my system say 'Hello, World!'
      	So that i have a starting point.

      	Scenario: With a blank Object
      		Given a blank Object
      		When i send it hello
      		It should return 'Hello, World!'

      	Scenario: With a custom Object
      	  GivenScenario: With a blank Object
      		Given a custom Object with name 'Bob'
      		When i send it hello
      		It should return 'Hello, World! I am Bob.'
      END

      @say_hello_features_body = <<-END
        As a Developer 
      	I want to let my system say 'Hello, World!'
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

    	@say_hello_world_features_body = <<-END
        As a Developer 
      	I want to let my system say 'Hello, World!'
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

    	@say_hello_universe_features_body = <<-END
        As a Developer 
      	I want to let my system say 'Hello, Universe!'
      	So that i have a starting point.

      	Scenario: With a blank Object
      		Given a blank Object
      		When i send it helloUniverse
      		It should return 'Hello, Universe!'

      	Scenario: With a custom Object
      		Given a custom Object with name 'Bob'
      		When i send it helloUniverse
      		It should return 'Hello, Universe! I am Bob.'
    	END

      @parser = Parser.new({
        :string => [@feature_file_string_1, @feature_file_string_2].join(" "),
        :keyword => "Feature:"})
    end

    it "raises if there are no features" do
      lambda { 
        Parser.new({
          :string  => "NoFeature!",
          :keyword => "Feature:",}) 
        }.should raise_error(/No Feature/)
    end

    describe "#parse_titles" do
      it "finds Say Hello" do
        @parser.parse_titles.should include("Say Hello")
      end

      it "finds Say Hello World" do
        @parser.parse_titles.should include("Say Hello World")
      end

      it "finds Say Hello Universe" do
        @parser.parse_titles.should include("Say Hello Universe")
      end
    end

    describe "#parse_bodies" do
      it "finds Say Hello body" do
        @parser.parse_bodies.should include(@say_hello_features_body.strip)
      end

      it "finds Say Hello World body" do
        @parser.parse_bodies.should include(@say_hello_world_features_body.strip)
      end

      it "finds Say Hello Universe body" do
        @parser.parse_bodies.should include(@say_hello_universe_features_body.strip)
      end

    end
    
  end
  
  context "with :keyword => 'Scenario:' and :create => Scenario" do
       
    before(:each) do
      @scenarios_string = <<-END
      Blah Blah Blah
    	Scenario: With a blank Object
    		Given a blank Object
    		When i send it hello
    		It should return 'Hello, World!'

    	Scenario: With a custom Object
    		Given a custom Object with name 'Bob'
    		When i send it hello
    		It should return 'Hello, World! I am Bob.'
      END

      @with_blank_object_body = <<-END
    		Given a blank Object
    		When i send it hello
    		It should return 'Hello, World!'
    	END

    	@with_custom_object_body = <<-END
    		Given a custom Object with name 'Bob'
    		When i send it hello
    		It should return 'Hello, World! I am Bob.'
    	END

      @parser = Parser.new({
        :string => @scenarios_string,
        :keyword => "Scenario:"
      })
    end

    it "raises if there are no Scenarios" do
      lambda { 
        Parser.new({
          :string => "NoScenario!",
          :keyword => "Scenario:"}) 
        }.should raise_error(/No Scenario/)
    end

    describe "#parse_titles" do
      it "finds With a blank Object" do
        @parser.parse_titles.should include("With a blank Object")
      end

      it "finds With a custom Object" do
        @parser.parse_titles.should include("With a custom Object")
      end
    end

    describe "#parse_bodies" do
      it "finds With a blank Object body" do
        @parser.parse_bodies.should include(@with_blank_object_body.strip)
      end

      it "finds With a custom Object body" do
        @parser.parse_bodies.should include(@with_custom_object_body.strip)
      end

    end
    
  end
  
end