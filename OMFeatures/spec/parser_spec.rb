require File.dirname(__FILE__) + '/spec_helper'

describe Parser do
  
  before(:each) do
    @valid_attributes = {
      :strings => ["Feature: f1 \n body"],
      :keyword => "Feature:",
      :create  => Feature
    }
    @parser = Parser.new(@valid_attributes)
  end
  
  it "has a string" do
    @parser.string.should_not be_nil
  end
  
  it "has a keyword" do
    @parser.keyword.should_not be_nil
  end
  
  it "has a class to create" do
    @parser.create.should_not be_nil
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
        :strings => [@feature_file_string_1, @feature_file_string_2],
        :keyword => "Feature:",
        :create  => Feature})
    end

    it "raises if there are no features" do
      lambda { 
        Parser.new({
          :strings => ["NoFeature!"],
          :keyword => "Feature:",
          :create  => Feature }) 
        }.should raise_error(/No Feature/)
    end

    describe "#parse" do
      it "returns features" do
        @parser.parse.each do |f|
          f.class.should eql(Feature)
        end
      end

      it "returns Say Hello Feature" do
        feature = @parser.parse.detect {|f| f.title == "Say Hello"}
        feature.should_not be_nil
        feature.body.should eql(@say_hello_features_body.strip)
      end

      it "returns Say Hello World Feature" do
        feature = @parser.parse.detect {|f| f.title == "Say Hello World"}
        feature.should_not be_nil
        feature.body.should eql(@say_hello_world_features_body.strip)
      end

      it "returns Say Hello Universe Feature" do
        feature = @parser.parse.detect {|f| f.title == "Say Hello Universe"}
        feature.should_not be_nil
        feature.body.should eql(@say_hello_universe_features_body.strip)
      end


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
        :strings => [@scenarios_string],
        :keyword => "Scenario:",
        :create  => Scenario
      })
    end

    it "raises if there are no Scenarios" do
      lambda { 
        Parser.new({
          :strings => ["NoScenario!"],
          :keyword => "Scenario:",
          :create  => Scenario }) 
        }.should raise_error(/No Scenario/)
    end

    describe "#parse" do
      it "returns scenarios" do
        @parser.parse.each do |s|
          s.class.should eql(Scenario)
        end
      end

      it "returns 'With a blank Object' scenario" do
        scenario = @parser.parse.detect {|s| s.title == "With a blank Object"}
        scenario.should_not be_nil
        scenario.body.should eql(@with_blank_object_body.strip)
      end

      it "returns 'With a custom Object' scenario" do
        scenario = @parser.parse.detect {|s| s.title == "With a custom Object"}
        scenario.should_not be_nil
        scenario.body.should eql(@with_custom_object_body.strip)
      end
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