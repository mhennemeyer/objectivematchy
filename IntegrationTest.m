//
//  IntegrationTest.m
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "IntegrationTest.h"
#import "NSObject-Expectations.h"
#import "Matcher-Eql.h"


@implementation IntegrationTest

- (void) testNumberEqualsEqualNumberPositive
{
	NSNumber * one = [NSNumber numberWithInt:1];
	[[one should] eql:one];
}

- (void) testNumberEqualsNonEqualNumberPositive
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	STAssertThrows([[one should] eql:two], @"One should not equal two");
}

- (void) testNumberNotEqualsNonEqualNumberNegative
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	[[one shouldNot] eql:two];
}

- (void) testNumberNotEqualsEqualNumberNegative
{
	NSNumber * one = [NSNumber numberWithInt:1];
	STAssertThrows([[one shouldNot] eql:one], @"One should not equal two");
}

@end
