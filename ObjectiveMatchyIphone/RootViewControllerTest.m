//
//  RootViewControllerTest.m
//  ObjectiveMatchyIphone
//
//  Created by Matthias Hennemeyer on 04.08.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

#import <UIKit/UIKit.h>



@interface RootViewControllerTest : SenTestCase {
	
}

@end


@implementation RootViewControllerTest

- (void) testView {
	[@"" simpleInvoke:@selector(copy) withArguments:nil ];
	[[@"Hello" should] eql:@"Hello"];
    OMMatcher * m = [[OMMatcher alloc] initWithActual:self andIsPositive:YES filename:@"Hello" linenumber:12];
	NSLog(@"\n out: %@", [m filename]);
	[[[NSObject alloc] init] addPositiveExpectation:@"" line:10];
}

@end
