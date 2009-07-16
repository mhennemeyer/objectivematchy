//
//  SimpleInvocationTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "SimpleInvocationTest.h"


@implementation SimpleInvocationTest

- (void) testSimpleInvocationReturnsInvocation
{
	NSObject * obj = [[NSObject alloc] init];
	NSArray * arr = [NSArray arrayWithObjects:@"isEqual:", [NSNumber numberWithInt:1], nil];
	STAssertEquals([[obj simpleInvocationFromArray:arr] class], [NSInvocation class], @"");
}

- (void) testSimpleInvocationSetsAppropriateSelector
{
	NSObject * obj = [[NSObject alloc] init];
	NSArray * arr = [NSArray arrayWithObjects:@"isEqual:", [NSNumber numberWithInt:1], nil];
	NSInvocation * inv = [obj simpleInvocationFromArray:arr];
	[inv description];
	//[[inv should] haveKey:@"selector" withValue:@selector(isEqual:)]; 
}

@end
