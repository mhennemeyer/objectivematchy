//
//  OMMatcherTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.


#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@interface OMMatcherTest : SenTestCase {
	id actual;
	OMMatcher * positiveMatcherWithActual;
	OMMatcher * negativeMatcherWithActual;
	int linenumber;
	NSString * filename;
}

@end
@implementation OMMatcherTest

- (void) setUp
{
	filename = @"OMMatcherTest.m";
	linenumber = 20;
	actual  = [[NSObject alloc] init];
	positiveMatcherWithActual = [[OMMatcher alloc] initWithActual:actual 
												  andIsPositive:YES
													   filename:filename 
													 linenumber:linenumber];
	negativeMatcherWithActual = [[OMMatcher alloc] initWithActual:actual 
												  andIsPositive:NO
													   filename:filename 
													 linenumber:linenumber];
}

#pragma mark Properties

- (void) testMatcherWithActualAndPositive
{
	STAssertEquals((id) actual, positiveMatcherWithActual.actual, @"Matcher should set actual.");
	STAssertTrue(positiveMatcherWithActual.isPositive, @"Matcher should set isPositive.");
}

- (void) testMatcherHasLineNumber
{
	STAssertEquals(linenumber, positiveMatcherWithActual.linenumber, @"matcher should have linenumber.");
}

- (void) testMatcherHasFilename
{
	STAssertEquals(filename, positiveMatcherWithActual.filename, @"matcher should have Filename.");
}


- (void) testMatcherHasMatchesKey
{
	[positiveMatcherWithActual eql:actual];
	STAssertTrue(positiveMatcherWithActual.matches, @"Matcher should match.");
}

- (void) testMatcherHasExpectedKey
{
	[positiveMatcherWithActual eql:actual];
	STAssertEquals(positiveMatcherWithActual.actual, 
				   positiveMatcherWithActual.expected, 
				   @"Matcher should have expected Property.");
}


- (void) testMatcherHasPositiveFailureMessage
{
	STAssertNotNil(positiveMatcherWithActual.positiveFailureMessage, @"Matcher should know positiveFailureMessage.");
}

- (void) testMatcherHasNegativeFailureMessage
{
	STAssertNotNil(positiveMatcherWithActual.negativeFailureMessage, @"Matcher should know negativeFailureMessage.");
}

#pragma mark -

#pragma mark positiveException

- (void) testMatcherRespondsToPositiveException
{
	STAssertTrue([positiveMatcherWithActual respondsToSelector:@selector(positiveException)] , 
				 @"Matcher should respond to positiveException.");
}

- (void) testPositiveExceptionKnowsFilename
{
	STAssertEquals([[[positiveMatcherWithActual positiveException] userInfo] valueForKey:OMFilenameKey],
	               filename,
	               @"Exception should know filename");
}

- (void) testPositiveExceptionKnowsLinenumber
{
	STAssertEqualObjects([[[positiveMatcherWithActual positiveException] userInfo] valueForKey:OMLineNumberKey],
	               [NSNumber numberWithInt:linenumber],
	               @"Exception should know linenumber");
}

- (void) testPositiveExceptionKnowsPositiveFailureMessage
{
	STAssertEqualObjects([[[positiveMatcherWithActual positiveException] userInfo] valueForKey:OMFailureMessageKey],
						 positiveMatcherWithActual.positiveFailureMessage,
						 @"Exception should know positiveFailureMessage");
}


#pragma mark -

#pragma mark negativeException

- (void) testMatcherRespondsToNegativeException
{
	STAssertTrue([positiveMatcherWithActual respondsToSelector:@selector(negativeException)] , 
				 @"Matcher should respond to positiveException.");
}

- (void) testNegativeExceptionKnowsFilename
{
	STAssertEquals([[[positiveMatcherWithActual negativeException] userInfo] valueForKey:OMFilenameKey],
	               filename,
	               @"Exception should know filename");
}

- (void) testNegativeExceptionKnowsLinenumber
{
	STAssertEqualObjects([[[positiveMatcherWithActual negativeException] userInfo] valueForKey:OMLineNumberKey],
						 [NSNumber numberWithInt:linenumber],
						 @"Exception should know linenumber");
}

- (void) testNegativeExceptionHasPositiveFailureMessage
{
	STAssertEqualObjects([[[positiveMatcherWithActual negativeException] userInfo] valueForKey:OMFailureMessageKey],
						 positiveMatcherWithActual.negativeFailureMessage,
						 @"Negative Exception should know negativeFailureMessage");
}


#pragma mark -

#pragma mark positiveFailure

- (void) testMatcherRespondsToPositiveFailure
{
	STAssertTrue([positiveMatcherWithActual respondsToSelector:@selector(positiveFailure)] , 
				 @"Matcher should respond to positiveFailure.");
}

- (void) testMatcherRespondsToPositiveFailureWithYESIfPositiveAndNotMatches
{
	STAssertThrows([positiveMatcherWithActual eql:[NSMutableArray array]], @"Should throw");
	STAssertTrue([positiveMatcherWithActual positiveFailure] , 
				 @"Matcher should respond to positiveFailure with YES for positive Expectation and no match.");
}

- (void) testMatcherRespondsToPositiveFailureWithNOIfPositiveAndMatches
{
	[positiveMatcherWithActual eql:actual];
	STAssertFalse([positiveMatcherWithActual positiveFailure] , 
				 @"Matcher should respond to positiveFailure with NO for positive Expectation and match.");
}

- (void) testMatcherRespondsToPositiveFailureWithNOIfNOTPositiveAndMatches
{
	STAssertThrows([negativeMatcherWithActual eql:actual], @"Should throw");
	STAssertFalse([negativeMatcherWithActual positiveFailure] , 
				  @"Matcher should respond to positiveFailure with NO for negative Expectation and match.");
}

- (void) testMatcherRespondsToPositiveFailureWithNOIfNOTPositiveAndNOTMatches
{
	[negativeMatcherWithActual eql:[NSMutableArray array]];
	STAssertFalse([negativeMatcherWithActual positiveFailure] , 
				  @"Matcher should respond to positiveFailure with NO for negative Expectation and no match.");
}

#pragma mark -

#pragma mark negativeFailure

- (void) testMatcherRespondsToNegativeFailure
{
	STAssertTrue([positiveMatcherWithActual respondsToSelector:@selector(negativeFailure)] , 
				 @"Matcher should respondTo negativeFailure.");
}

- (void) testMatcherRespondsToNegativeFailureWithYESIfNotPositiveAndMatches
{
	STAssertThrows([negativeMatcherWithActual eql:actual], @"Should throw");
	STAssertTrue([negativeMatcherWithActual negativeFailure] , 
				 @"Matcher should respond to negativeFailure with YES for negative Expectation and match.");
}

- (void) testMatcherRespondsToNegativeFailureWithNOIfNotPositiveAndNotMatches
{
	[negativeMatcherWithActual eql:[NSMutableArray array]];
	STAssertFalse([negativeMatcherWithActual negativeFailure] , 
				  @"Matcher should respond to negativeFailure with NO for negative Expectation and no match.");
}

- (void) testMatcherRespondsToNegativeFailureWithNOIfPositiveAndMatches
{
	[positiveMatcherWithActual eql:actual];
	STAssertFalse([positiveMatcherWithActual negativeFailure] , 
				  @"Matcher should respond to negativeFailure with NO for positive Expectation and match.");
}

- (void) testMatcherRespondsToNegativeFailureWithNOIfPositiveAndNOTMatches
{
	STAssertThrows([positiveMatcherWithActual eql:[NSMutableArray array]], @"Should throw");
	STAssertFalse([positiveMatcherWithActual negativeFailure] , 
				  @"Matcher should respond to negativeFailure with NO for positive Expectation and no match.");
}

#pragma mark -

#pragma mark handleExpectation

- (void) testMatcherRespondsToHandleExpectation
{
	STAssertTrue([positiveMatcherWithActual respondsToSelector:@selector(handleExpectation)] , 
				 @"Matcher should respond to handleExpectation.");
}

- (void) testMatcherRaisesOnHandleExpectationIfPositiveFailure
{
	STAssertThrows([positiveMatcherWithActual eql:[NSMutableArray array]], @"Should throw");
	STAssertThrows([positiveMatcherWithActual handleExpectation], @"Should throw");
}

- (void) testMatcherRaisesOnHandleExpectationIfNegativeFailure
{
	STAssertThrows([negativeMatcherWithActual eql:actual], @"Should throw");
	STAssertThrows([negativeMatcherWithActual handleExpectation], @"Should throw");
}

- (void) testMatcherDoesntRaiseOnHandleExpectationIfNoFailure
{
	[positiveMatcherWithActual eql:actual];
	[positiveMatcherWithActual handleExpectation];
}

- (void) testHandleExpectationRaisesWithPositiveFailureMessageOnPositiveFailure
{
	NSException * exception = nil;
	@try {
		[positiveMatcherWithActual eql:[NSMutableArray array]];
	}
	@catch (NSException * e) {
		exception = e;
	}
	STAssertEqualObjects([[exception userInfo] valueForKey:OMFailureMessageKey], 
						 positiveMatcherWithActual.positiveFailureMessage,
						 @"handleExpectation raises with positiveFailureMessage");
}

- (void) testHandleExpectationRaisesWithLinenumberOnPositiveFailure
{
	@try {
		[positiveMatcherWithActual eql:[NSMutableArray array]];
	}
	@catch (NSException * e) {
		STAssertEqualObjects([[e userInfo] valueForKey:OMLineNumberKey], 
							 [NSNumber numberWithInt:positiveMatcherWithActual.linenumber],
							 @"handleExpectation raises with linenumber");
	}
}

- (void) testHandleExpectationRaisesWithFilenameOnPositiveFailure
{
	@try {
		[positiveMatcherWithActual eql:[NSMutableArray array]];
	}
	@catch (NSException * e) {
		STAssertEqualObjects([[e userInfo] valueForKey:OMFilenameKey], 
							 positiveMatcherWithActual.filename,
							 @"handleExpectation raises with filename");
	}
}

- (void) testHandleExpectationRaisesWithPositiveFailureMessageOnNegativeFailure
{
	@try {
		[negativeMatcherWithActual eql:actual];
	}
	@catch (NSException * e) {
		STAssertEqualObjects([[e userInfo] valueForKey:OMFailureMessageKey], 
							 negativeMatcherWithActual.negativeFailureMessage,
							 @"handleExpectation raises with positiveFailureMessage");
	}
}

- (void) testHandleExpectationRaisesWithLinenumberOnNegativeFailure
{
	@try {
		[negativeMatcherWithActual eql:actual];
	}
	@catch (NSException * e) {
		STAssertEqualObjects([[e userInfo] valueForKey:OMLineNumberKey], 
							 [NSNumber numberWithInt:negativeMatcherWithActual.linenumber],
							 @"handleExpectation raises with linenumber");
	}
}

- (void) testHandleExpectationRaisesWithFilenameOnNegativeFailure
{
	@try {
		[negativeMatcherWithActual eql:actual];
	}
	@catch (NSException * e) {
		STAssertEqualObjects([[e userInfo] valueForKey:OMFilenameKey], 
							 negativeMatcherWithActual.filename,
							 @"handleExpectation raises with filename");
	}
}


#pragma mark -

#pragma mark isWrapped

- (void) testMatcherKnowsThatExpectedIsWrapped
{
	positiveMatcherWithActual.expected = OM_NO;
	STAssertTrue([positiveMatcherWithActual isWrapped], nil);
}

- (void) testMatcherKnowsThatExpectedIsNotWrapped
{
	positiveMatcherWithActual.expected = [[NSObject alloc] init] ;
	STAssertFalse([positiveMatcherWithActual isWrapped], nil);
}
	

@end
