//
//  BeTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 19.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "BeTest.h"


@implementation BeTest

- (void) setUp
{
	anObject = [[NSObject alloc] init];
	anotherObject = [[NSObject alloc] init];
}

- (void) testBeEqualPositivePass
{
	[[anObject should] be:@"Equal:", anObject, nil];
}

- (void) testBeEqualNegativePass
{
	[[anObject shouldNot] be:@"Equal:", anotherObject, nil];
}


@end
