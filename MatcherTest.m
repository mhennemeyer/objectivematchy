//
//  MatcherTest.m
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MatcherTest.h"
#import "Matcher.h"
#import "Matcher-Eql.h"
#import "NSObject-Expectations.h"



@implementation MatcherTest

- (void) testMatcherWithActualAndPositive
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	[[actual should] eql:matcher.actual];
	STAssertEquals((id) actual, matcher.actual, @"Matcher should set actual.");
	STAssertTrue(matcher.isPositive, @"Matcher should set isPositive.");
}

- (void) testMatcherHasMatchesProperty
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	[matcher eql:actual];
	STAssertTrue(matcher.matches, @"Matcher should match.");
}

- (void) testMatcherKnowsPositiveFailureMessage
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertNotNil(matcher.positiveFailureMessage, @"Matcher should know positiveFailureMessage.");
}

- (void) testMatcherKnowsNegativeFailureMessage
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertNotNil(matcher.negativeFailureMessage, @"Matcher should know negativeFailureMessage.");
}




#pragma mark eql

- (void) testMatcherKnowsEqlMessage
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	[matcher eql:actual];
}

- (void) testMatcherThrowsForExpectingNonEqualToEqlActual
{
	NSObject * actual         = [[NSObject alloc] init];
	NSMutableArray * expected = [NSMutableArray array];
	Matcher  * matcher        = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertThrows([matcher eql:expected], @"Should throw");
}




@end
