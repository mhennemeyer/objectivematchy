//
//  HelloWorldTest.m
//  ___PROJECTNAME___


#import <SenTestingKit/SenTestingKit.h>
#import <ObjectiveMatchyIphone/ObjectiveMatchy.h>
#import <OCMock/OCMock.h>
#import <UIKit/UIKit.h>


@interface HelloWorldTest : SenTestCase {
	
}
@end

@implementation HelloWorldTest

- (void) testHelloWorld {
    [[@"Hello, World!" should] eql:@"Hello, World!"];
}

@end
