//
//  EqlTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "EqlTest.h"


@implementation EqlTest

#pragma mark with Numbers

- (void) testNumberEqualsSameNumberPositive
{
	NSNumber * one = [NSNumber numberWithInt:1];
	[[one should] eql:one];
	
}

- (void) testNumberEqualsDifferentNumberPositive
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	STAssertThrows([[one should] eql:two], @"One should not equal two");
}

- (void) testNumberNotEqualsDifferentNumberNegative
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	[[one shouldNot] eql:two];
}

- (void) testNumberNotEqualsSameNumberNegative
{
	NSNumber * one = [NSNumber numberWithInt:1];
	STAssertThrows([[one shouldNot] eql:one], @"One should not equal two");
}

- (void) testNumberEqualsEqualNumberPositive
{
	NSNumber * one        = [NSNumber numberWithInt:1];
	NSNumber * anotherOne = [NSNumber numberWithInt:1];
	[[one should] eql:anotherOne];
}

- (void) testNumberNotEqualsEqualNumberNegative
{
	NSNumber * one        = [NSNumber numberWithInt:1];
	NSNumber * anotherOne = [NSNumber numberWithInt:1];
	STAssertThrows([[one shouldNot] eql:anotherOne], @"one should eql one");
}

#pragma mark -

#pragma mark with Arrays

- (void) testArrayEqualsSameArrayPositive
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	NSArray  * arr = [NSArray arrayWithObjects:one, two, nil];
	[[arr should] eql:arr];
}

- (void) testArrayEqualsSameArrayNegative
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	NSArray  * arr = [NSArray arrayWithObjects:one, two, nil];
	STAssertThrows([[arr shouldNot] eql:arr], @"arr should eql arr." );
}

- (void) testArrayEqualsEqualArrayPositive
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	NSArray  * arr = [NSArray arrayWithObjects:one, two, nil];
	NSArray  * equalArr = [NSArray arrayWithObjects:one, two, nil];
	[[arr should] eql:equalArr];
}

- (void) testArrayEqualsEqualArrayNegative
{
	NSNumber * one = [NSNumber numberWithInt:1];
	NSNumber * two = [NSNumber numberWithInt:2];
	NSArray  * arr = [NSArray arrayWithObjects:one, two, nil];
	NSArray  * equalArr = [NSArray arrayWithObjects:one, two, nil];
	STAssertThrows([[arr shouldNot] eql:equalArr], @"arr should eql equalArr." );
}

#pragma mark -

@end
