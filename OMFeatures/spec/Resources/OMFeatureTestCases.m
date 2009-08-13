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

