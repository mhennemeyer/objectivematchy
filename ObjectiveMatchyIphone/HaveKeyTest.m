//
//  HaveKeyTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectWithKey.h"
#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@interface HaveKeyTest : SenTestCase {
	ObjectWithKey * objectWithKey;
}

@end

@implementation HaveKeyTest

- (void) setUp
{
	objectWithKey = [[ObjectWithKey alloc] init];
}

#pragma mark haveKey:

- (void) testHaveKeyPositivePass
{
	[[objectWithKey should] haveKey:@"aKey"];
}

- (void) testHaveKeyPositiveFail
{
	STAssertThrows([[objectWithKey should] haveKey:@"nonExistingKey"], @"Should Throw");
}

- (void) testHaveKeyNegativePass
{
	[[objectWithKey shouldNot] haveKey:@"nonExistingKey"];
}

- (void) testHaveKeyNegativeFail
{
	STAssertThrows([[objectWithKey shouldNot] haveKey:@"aKey"], @"Should Throw");
}

#pragma mark -

#pragma mark haveKey:withValue:

- (void) testHaveKeyWithValuePositivePass
{
	[objectWithKey setValue:@"Value"  forKey:@"aKey"];
	[[objectWithKey should] haveKey:@"aKey" withValue:@"Value"];
}

- (void) testHaveKeyWithValuePositiveFail
{
	[objectWithKey setValue:@"WrongValue"  forKey:@"aKey"];
	STAssertThrows([[objectWithKey should] haveKey:@"aKey" withValue:@"Value"],
	               @"Should throw.");
}

- (void) testHaveKeyWithValueNegativePass
{
	[objectWithKey setValue:@"Value"  forKey:@"aKey"];
	[[objectWithKey shouldNot] haveKey:@"aKey" withValue:@"WrongValue"];
}

- (void) testHaveKeyWithValueNegativeFail
{
	[objectWithKey setValue:@"Value"  forKey:@"aKey"];
	STAssertThrows([[objectWithKey shouldNot] haveKey:@"aKey" withValue:@"Value"],
	               @"Should throw.");
}

- (void) testHaveKeyWithValueRaisesIfNonExistingKeyPositive
{
	STAssertThrows([[objectWithKey should] haveKey:@"nonExistingKey" withValue:@"Value"],
	               @"Should throw.");
}

- (void) testHaveKeyWithValueRaisesIfNonExistingKeyNegative
{
	STAssertThrows([[objectWithKey shouldNot] haveKey:@"nonExistingKey" withValue:@"Value"],
	               @"Should throw.");
}

#pragma mark -

@end
