//
//  EqlTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>


@interface EqlTest : SenTestCase {
	NSNumber * one;
	NSNumber * two;
	NSArray  * arr;
}

@end


@implementation EqlTest

#pragma mark with Numbers

- (void) setUp
{
	one = [NSNumber numberWithInt:1];
	two = [NSNumber numberWithInt:2];
	arr = [NSArray arrayWithObjects:one, two, nil];
}

- (void) testNumberEqualsSameNumberPositive
{
	[[one should] eql:one];
	
}

- (void) testNumberEqualsDifferentNumberPositive
{
	OMMatcher * matcher = [one should];
	[[matcher should] throw:@"" forMessage:@"eql:", two, nil];
}

- (void) testNumberNotEqualsDifferentNumberNegative
{
	[[one shouldNot] eql:two];
}

- (void) testNumberNotEqualsSameNumberNegative
{
	OMMatcher * matcher = [one shouldNot];
	[[matcher should] throw:@"" forMessage:@"eql:", one, nil];
}

- (void) testNumberEqualsEqualNumberPositive
{
	NSNumber * anotherOne = [NSNumber numberWithInt:1];
	[[one should] eql:anotherOne];
}

- (void) testNumberNotEqualsEqualNumberNegative
{
	NSNumber * anotherOne = [NSNumber numberWithInt:1];
	OMMatcher * matcher = [one shouldNot];
	[[matcher should] throw:@"" forMessage:@"eql:", anotherOne, nil];
}

#pragma mark -

#pragma mark with Arrays

- (void) testArrayEqualsSameArrayPositive
{
	[[arr should] eql:arr];
}

- (void) testArrayEqualsSameArrayNegative
{
	OMMatcher * matcher = [arr shouldNot];
	[[matcher should] throw:@"" forMessage:@"eql:", arr, nil];
}

- (void) testArrayEqualsEqualArrayPositive
{
	NSArray  * equalArr = [NSArray arrayWithArray:arr];
	[[arr should] eql:equalArr];
}

- (void) testArrayEqualsEqualArrayNegative
{
	NSArray  * equalArr = [NSArray arrayWithArray:arr];
	OMMatcher * matcher = [arr shouldNot];
	[[matcher should] throw:@"" forMessage:@"eql:", equalArr, nil];
}



#pragma mark -

@end
