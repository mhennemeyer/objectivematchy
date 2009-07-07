//
//  HaveKeyTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//
#import "ObjectWithKey.h"
#import "HaveKeyTest.h"
#import "NSObject-Expectations.h"
#import "Matcher-MatcherMethods.h"



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


testCase(HaveKeyWithMacro, ObjectWithKey * sut ,
		 setUp(sut = [[ObjectWithKey alloc] init])
		 tearDown([sut release]) 
		 test(HasKey,
			  [sut setValue:@"someValue"  forKey:@"aKey"];
			  [[sut should] haveKey:@"aKey" withValue:@"someValue"]))


