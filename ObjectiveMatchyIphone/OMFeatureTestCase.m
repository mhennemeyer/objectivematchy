    #import "OMFeature.h"
        @interface SayHelloWorldTest : OMFeature
    @end
    @implementation SayHelloWorldTest
        -(void) testJustOpenedTheApp
    {
        [self Given_i_just_opened_the_app]; [self When_i_push_the____Button:@"HelloButtonHello"]; [self Then_the____Label_should_show___:@"HelloHelloLabel" arg:@"Hello, World!"]; [self Then_everything_should_be_fine];
    }

    @end
     @interface SayHelloWorldAgainTest : OMFeature
    @end
    @implementation SayHelloWorldAgainTest
        -(void) testJustOpenedTheApp
    {
        [self Given_i_just_opened_the_app]; [self When_i_push_the____Button:@"HelloAgain"]; [self Then_the____Label_should_show___:@"HelloAgainLabel" arg:@"Hello, World! Again"];
    }
     -(void) testWithAGivenScenario
    {
        [self Given_i_just_opened_the_app]; [self When_i_push_the____Button:@"HelloAgain"]; [self Then_the____Label_should_show___:@"HelloAgainLabel" arg:@"Hello, World! Again"]; [self Given_i_just_opened_the_app]; [self When_i_push_the____Button:@"HelloAgain"]; [self Then_the____Label_should_show___:@"HelloAgainLabel" arg:@"Hello, World! Again"];
    }

    @end
     @interface SayHelloWorldAgainAndAgainTest : OMFeature
    @end
    @implementation SayHelloWorldAgainAndAgainTest
        -(void) testJustOpenedTheApp
    {
        [self Given_i_just_opened_the_app]; [self When_i_push_the____Button:@"HelloAgain"]; [self Then_the____Label_should_show___:@"HelloAgainLabel" arg:@"Hello, World! Again"];
    }
     -(void) testWithAGivenScenario
    {
        [self Given_i_just_opened_the_app]; [self When_i_push_the____Button:@"HelloAgain"]; [self Then_the____Label_should_show___:@"HelloAgainLabel" arg:@"Hello, World! Again"]; [self Given_i_just_opened_the_app]; [self When_i_push_the____Button:@"HelloAgain"]; [self Then_the____Label_should_show___:@"HelloAgainLabel" arg:@"Hello, World! Again"];
    }

    @end

