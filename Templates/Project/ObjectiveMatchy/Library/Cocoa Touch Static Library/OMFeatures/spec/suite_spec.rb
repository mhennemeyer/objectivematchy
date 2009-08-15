require File.dirname(__FILE__) + '/spec_helper'

describe Suite do
  before(:each) do
    @feature_files_path = File.dirname(__FILE__) + "/Resources"
    @suite = Suite.new({
      :feature_files_path         => @feature_files_path,
      :feature_file_suffix        => "feature",
      :test_cases_file            => @feature_files_path + "/OMFeatureTestCases.m",
      :feature_class_header_files => ["OMFeature.h"],
      :project_name               => "ObjectiveMatchy Features"
    })
  end
  
  it "has a feature_keyword" do
    @suite.feature_keyword.should eql("Feature:")
  end
  
  it "has a scenario_keyword" do
    @suite.scenario_keyword.should eql("Scenario:")
  end
  
  it "has a given_scenario_keyword" do
    @suite.given_scenario_keyword.should eql("GivenScenario:")
  end
  
  it "has a project_name" do
    @suite.project_name.should == "ObjectiveMatchy Features"
  end
  
  it "has feature_class_header_files" do
    @suite.feature_class_header_files.should eql(["OMFeature.h"])
  end

  it "has a test_cases_file" do
    @suite.test_cases_file.should eql(@feature_files_path + "/OMFeatureTestCases.m")
  end
    
  it "has feature files" do
    @suite.feature_files.should_not be_nil
  end
  
  it "inits feature files path from hash passed to .new" do
    @suite.feature_files_path.should eql(@feature_files_path)
  end
  
  it "has feature file suffix" do
    @suite.feature_file_suffix.should_not be_nil
  end
  
  it "finds HelloWorld.feature feature files" do
    @suite.feature_files.should include(@feature_files_path + "/HelloWorld.feature")
  end
  
  it "finds OtherFeatureFile.feature feature files" do
    @suite.feature_files.should include(@feature_files_path + "/OtherFeatureFile.feature")
  end
  
  it "won't find other files in location" do
    @suite.feature_files.should_not include(@feature_files_path + "/other.file")
  end
  
  it "reads the HelloWorld.feature feature file" do
    File.stub!(:open)
    File.should_receive(:open).with(@feature_files_path + "/HelloWorld.feature")
    @suite.all_feature_files_as_strings
  end
  
  it "reads the OtherFeatureFile.feature feature file" do
    File.stub!(:open)
    File.should_receive(:open).with(@feature_files_path + "/OtherFeatureFile.feature")
    @suite.all_feature_files_as_strings
  end
  
  it "stores content of HelloWorld.feature as string in feature_files array" do
    content_of_feature_file = ""
    File.open(@feature_files_path + "/HelloWorld.feature") do |f|
      f.readlines.each do |l|
        content_of_feature_file << l
      end
    end
    @suite.feature_files_as_strings.should include(content_of_feature_file)
  end
  
  it "stores content of OtherFeatureFile.feature as string in feature_files array" do
    content_of_feature_file = ""
    File.open(@feature_files_path + "/OtherFeatureFile.feature") do |f|
      f.readlines.each do |l|
        content_of_feature_file << l
      end
    end
    @suite.feature_files_as_strings.should include(content_of_feature_file)
  end
  
  context "parse_features" do
    before(:each) do
      @suite.parse_features
    end
    it "has features" do
      @suite.features.should_not be_nil
    end

    it "finds Say Hello World Feature" do
      @suite.features.detect {|f| f.title == "Say Hello World"}.should_not be_nil
    end

    it "finds Say Hello Universe Feature" do
      @suite.features.detect {|f| f.title == "Say Hello World"}.should_not be_nil
    end

    it "finds Say Hello Feature" do
      @suite.features.detect {|f| f.title == "Say Hello"}.should_not be_nil
    end
  end
  
  describe "parse_feature_scenarios" do
    it "sends parse_scenarios  message to features" do
      mock_feature_1 = mock_feature_2 = mock(Feature)
      mock_feature_1.should_receive(:parse_scenarios)
      mock_feature_2.should_receive(:parse_scenarios)
      @suite.should_receive(:features).and_return([mock_feature_1, mock_feature_2])
      @suite.parse_feature_scenarios
    end
  end
  
  context "with features and scenarios parsed" do
    
    before(:each) do
      @suite.parse_features
      @suite.parse_feature_scenarios
    end
    
    it "exposes itself as a string" do
      expected = <<-END
    #import "OMFeature.h"
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
    @interface SayHelloUniverseTest : OMFeature
    @end
    @implementation SayHelloUniverseTest
    -(void) testWithABlankObject
    {
        [self Given_a_blank_Object]; [self When_i_send_it_helloUniverse]; [self It_should_return___:@"Hello, Universe!"];
    }
    -(void) testWithACustomObject
    {
        [self Given_a_custom_Object_with_name___:@"Bob"]; [self When_i_send_it_helloUniverse]; [self It_should_return___:@"Hello, Universe! I am Bob."];
    }
    @end
    @interface SayHelloTest : OMFeature
    @end
    @implementation SayHelloTest
    -(void) testWithABlankObject
    {
        [self Given_a_blank_Object]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World!"];
    }
    -(void) testWithACustomObject
    {
        [self Given_a_blank_Object]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World!"]; [self Given_a_custom_Object_with_name___:@"Bob"]; [self When_i_send_it_hello]; [self It_should_return___:@"Hello, World! I am Bob."];
    }
    @end
    END
      @suite.to_s.ignore_whitespace.should eql(expected.ignore_whitespace)
    end
  end
  
  describe "#run" do
    before(:each) do
      @suite.run
    end
    
    it "overwrites its test_cases_file with itself as string" do
      content = File.open(@suite.test_cases_file) {|f| f.readlines}
      content = ""
      File.open(@suite.test_cases_file) do |f|
        f.readlines.each do |l|
          content << l
        end
      end
      content.should eql(@suite.to_s)
    end
  end
  
  context "validation" do
    it "won't accept two features with the same test_case_names" do
      @suite.parse_features
      @suite.features << mock(Feature, :test_case_name => "SayHelloTest")
      @suite.should_not be_valid
    end
  end
  
  context "Result parsing" do
    
    before(:each) do
      @results = <<-END
      PhaseScriptExecution /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/build/ObjectiveMatchyIphone.build/Debug-iphonesimulator/ObjectiveMatchyIphoneTest.build/Script-5D7676BA10282073001EBA91.sh
          cd /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone
          /bin/sh -c /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/build/ObjectiveMatchyIphone.build/Debug-iphonesimulator/ObjectiveMatchyIphoneTest.build/Script-5D7676BA10282073001EBA91.sh
      /Developer/Tools/RunPlatformUnitTests.include:364: note: Started tests for architectures 'i386'
      /Developer/Tools/RunPlatformUnitTests.include:371: note: Running tests for architecture 'i386' (GC OFF)
      objc[1586]: GC: forcing GC OFF because OBJC_DISABLE_GC is set
      objc[1586]: GC: forcing GC OFF because OBJC_DISABLE_GC is set
      Test Suite '/Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/build/Debug-iphonesimulator/ObjectiveMatchyIphoneTest.octest(Tests)' started at 2009-08-13 15:21:58 +0200
      Test Suite 'OMFeature' started at 2009-08-13 15:21:58 +0200
      Test Suite 'OMFeature' finished at 2009-08-13 15:21:58 +0200.
      Executed 0 tests, with 0 failures (0 unexpected) in 0.000 (0.000) seconds

      Test Suite 'RootViewControllerTest' started at 2009-08-13 15:21:58 +0200
      2009-08-13 15:21:58.922 otest[1586:80f] 
       out: Hello
      Test Case '-[RootViewControllerTest testView]' passed (0.001 seconds).
      Test Suite 'RootViewControllerTest' finished at 2009-08-13 15:21:58 +0200.
      Executed 1 test, with 0 failures (0 unexpected) in 0.001 (0.001) seconds

      Test Suite 'SayHelloWorldAgainTest' started at 2009-08-13 15:21:58 +0200
      2009-08-13 15:21:58.924 otest[1586:80f] 
      Hello!!!
      2009-08-13 15:21:58.924 otest[1586:80f] HelloAgain
      /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/OMFeature.m:28: error: -[SayHelloWorldAgainTest testJustOpenedTheApp] : '' should be equal to: 'h', but isn't (with isEqual:).
      Test Case '-[SayHelloWorldAgainTest testJustOpenedTheApp]' failed (0.001 seconds).
      2009-08-13 15:21:58.925 otest[1586:80f] 
      Hello!!!
      2009-08-13 15:21:58.926 otest[1586:80f] HelloAgain
      Test Case '-[SayHelloWorldTest testWithABlankObject]' passed (0.001 seconds).
      /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/OMFeature.m:28: error: -[SayHelloWorldAgainTest testWithAGivenScenario] : '' should be equal to: 'h', but isn't (with isEqual:).
      Test Case '-[SayHelloWorldAgainTest testWithAGivenScenario]' failed (0.001 seconds).
      Test Suite 'SayHelloWorldAgainTest' finished at 2009-08-13 15:21:58 +0200.
      Executed 2 tests, with 2 failures (2 unexpected) in 0.002 (0.002) seconds

      Test Suite 'SayHelloWorldTest' started at 2009-08-13 15:21:58 +0200
      2009-08-13 15:21:58.926 otest[1586:80f] 
      
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

      Touch /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone/build/Debug-iphonesimulator/ObjectiveMatchyIphoneTest.octest
          cd /Users/mhennemeyer/Projekte/ObjectiveMatchy/ObjectiveMatchyIphone
      
      END
    end
    
    it "verifies that SayHello:WithACustomObject passes" do
      @suite.parse_results(@results)
      @suite.features.detect {|f| f.title == "Say Hello"}.
        scenarios.detect {|s| s.title == "With a custom Object"}.passed?.should be_true
    end
    
    it "verifies that SayHelloUniverse:WithABlankObject fails" do
      @suite.parse_results(@results)
      @suite.features.detect {|f| f.title == "Say Hello Universe"}.
        scenarios.detect {|s| s.title == "With a blank Object"}.passed?.should be_false
    end
    
    it "knows if it has passed or failed" do
      @suite.parse_results(@results)
      @suite.passed?.should be_false
    end
    
    describe "#html" do
      before(:each) do
        @suite.parse_results(@results)
        @html = @suite.html
      end
      
      it "renders Feature: Say Hello World" do
        puts @html
        @html.should =~ /Feature:\sSay\sHello\sWorld/
      end
      
      it "renders project_name" do
        @html.should =~ /ObjectiveMatchy\sFeatures/
      end
      
      it "show in browser" do
        %x(touch '/tmp/out.html' && echo '#{@html}' > /tmp/out.html && open '/tmp/out.html' )
      end
      
      
    end
    
  end
end