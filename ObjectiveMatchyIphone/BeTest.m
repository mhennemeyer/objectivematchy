//
//  BeTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 19.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>
#import "BadObject.h"

@interface BeTest : SenTestCase {
	NSObject * anObject;
	NSObject * anotherObject;
	BadObject * badObject;
}

@end

@implementation BeTest

- (void) setUp
{
	anObject = [[NSObject alloc] init];
	anotherObject = [[NSObject alloc] init];
	badObject = [BadObject badObject];
}

#pragma mark  be:with:

- (void) testBeWithEqualPositivePass
{
	[[anObject should] be:@"Equal:" with:anObject];
}

- (void) testBeWithEqualNegativePass
{
	[[anObject shouldNot] be:@"Equal:" with:anotherObject];
}

- (void) testBeWithEqualPositiveFail
{
	OMMatcher * matcher = [anObject should];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"be:with:"
			  withArguments:[NSArray arrayWithObjects:@"EqualTo:", anotherObject, nil]];
}

- (void) testBeWithEqualNegativeFail
{
	OMMatcher * matcher = [anObject shouldNot];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"be:with:"
			  withArguments:[NSArray arrayWithObjects:@"EqualTo:", anObject, nil]];
}

#pragma mark -

#pragma mark be:

- (void) testBeEqualPositivePass
{

	[[badObject should] be:@"Bad"];
}

- (void) testBeEqualNegativePass
{
	[[badObject shouldNot] be:@"Good"];
}

- (void) testBeEqualPositiveFail
{
	OMMatcher * matcher = [badObject should];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"be:"
			  withArguments:[NSArray arrayWithObject:@"Good"]];
}

- (void) testBeEqualNegativeFail
{
	OMMatcher * matcher = [anObject shouldNot];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"be:"
			  withArguments:[NSArray arrayWithObject:@"Bad"]];
}

#pragma mark -


@end
