//
//  ContainTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 20.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@interface ContainTest : SenTestCase {
	NSNumber * aContainedObject;
	NSNumber * two;
	NSArray  * arr;
	NSObject * anUnContainedObject;
}

@end

@implementation ContainTest

- (void) setUp
{
	aContainedObject = [NSNumber numberWithInt:1];
	two = [NSNumber numberWithInt:2];
	arr = [NSArray arrayWithObjects:aContainedObject, two, nil];
	anUnContainedObject = [[NSObject alloc] init];
}

- (void) testArrayContainsObjectPositivePass
{
	[[arr should] containObject:aContainedObject];

}

- (void) testArrayContainsObjectNegativePass
{
	[[arr shouldNot] containObject:anUnContainedObject];
}

- (void) testArrayContainsObjectPositiveFail
{
	OMMatcher * matcher = [arr should];
	[[matcher should] throw:OMFailure
				 forMessage:@"containObject:", anUnContainedObject, nil];
}

- (void) testArrayContainsObjectNegativeFail
{
	OMMatcher * matcher = [arr shouldNot];
	[[matcher should] throw:OMFailure
				 forMessage:@"containObject:", aContainedObject, nil];
}
@end
