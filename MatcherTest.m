//
//  MatcherTest.m
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MatcherTest.h"
#import "Matcher.h"
#import "Matcher-MatcherMethods.h"
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

- (void) testMatcherHasExpectedProperty
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	[matcher eql:actual];
	STAssertEquals(matcher.actual, matcher.expected, @"Matcher should have expected Property.");
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

#pragma mark -

#pragma mark positiveFailure

- (void) testMatcherRespondsToPositiveFailure
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertTrue([matcher respondsToSelector:@selector(positiveFailure)] , 
				 @"Matcher should respondTo positiveFailure.");
}

- (void) testMatcherRespondsToPositiveFailureWithYESIfPositiveAndNotMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertThrows([matcher eql:[NSMutableArray array]], @"Should throw");
	STAssertTrue([matcher positiveFailure] , 
				 @"Matcher should respond to positiveFailure with YES for positive Expectation and no match.");
}

- (void) testMatcherRespondsToPositiveFailureWithNOIfPositiveAndMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	[matcher eql:actual];
	STAssertFalse([matcher positiveFailure] , 
				 @"Matcher should respond to positiveFailure with NO for positive Expectation and match.");
}

- (void) testMatcherRespondsToPositiveFailureWithNOIfNOTPositiveAndMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:NO];
	STAssertThrows([matcher eql:actual], @"Should throw");
	STAssertFalse([matcher positiveFailure] , 
				  @"Matcher should respond to positiveFailure with NO for negative Expectation and match.");
}

- (void) testMatcherRespondsToPositiveFailureWithNOIfNOTPositiveAndNOTMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:NO];
	[matcher eql:[NSMutableArray array]];
	STAssertFalse([matcher positiveFailure] , 
				  @"Matcher should respond to positiveFailure with NO for negative Expectation and no match.");
}

#pragma mark -

#pragma mark negativeFailure

- (void) testMatcherRespondsToNegativeFailure
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertTrue([matcher respondsToSelector:@selector(negativeFailure)] , 
				 @"Matcher should respondTo negativeFailure.");
}

- (void) testMatcherRespondsToNegativeFailureWithYESIfNotPositiveAndMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:NO];
	STAssertThrows([matcher eql:actual], @"Should throw");
	STAssertTrue([matcher negativeFailure] , 
				 @"Matcher should respond to negativeFailure with YES for negative Expectation and match.");
}

- (void) testMatcherRespondsToNegativeFailureWithNOIfNotPositiveAndNotMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:NO];
	[matcher eql:[NSMutableArray array]];
	STAssertFalse([matcher negativeFailure] , 
				  @"Matcher should respond to negativeFailure with NO for negative Expectation and no match.");
}

- (void) testMatcherRespondsToNegativeFailureWithNOIfPositiveAndMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	[matcher eql:actual];
	STAssertFalse([matcher negativeFailure] , 
				  @"Matcher should respond to negativeFailure with NO for positive Expectation and match.");
}

- (void) testMatcherRespondsToNegativeFailureWithNOIfPositiveAndNOTMatches
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertThrows([matcher eql:[NSMutableArray array]], @"Should throw");
	STAssertFalse([matcher negativeFailure] , 
				  @"Matcher should respond to negativeFailure with NO for positive Expectation and no match.");
}

#pragma mark -

#pragma mark handleExpectation

- (void) testMatcherRespondsToHandleExpectation
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertTrue([matcher respondsToSelector:@selector(handleExpectation)] , 
				 @"Matcher should respond to handleExpectation.");
}

- (void) testMatcherRaisesOnHandleExpectationIfPositiveFailure
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	STAssertThrows([matcher eql:[NSMutableArray array]], @"Should throw");
	STAssertThrows([matcher handleExpectation], @"Should throw");
}

- (void) testMatcherRaisesOnHandleExpectationIfNegativeFailure
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:NO];
	STAssertThrows([matcher eql:actual], @"Should throw");
	STAssertThrows([matcher handleExpectation], @"Should throw");
}

- (void) testMatcherDoesntRaiseOnHandleExpectationIfNoFailure
{
	NSObject * actual  = [[NSObject alloc] init];
	Matcher  * matcher = [[Matcher alloc] initWithActual:actual andIsPositive:YES];
	[matcher eql:actual];
	[matcher handleExpectation];
}

#pragma mark -




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
