//
//  ThrowForMessageTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 17.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "BadObject.h"
#import "ThrowForMessageTest.h"

@implementation ThrowForMessageTest

- (void) setUp
{
	badObject = [[BadObject alloc] init];
}

- (void) testThrowForMessageWithEmptyExceptionPositivePass
{
	[[badObject should] throw:@"" forMessage:@"raise", nil]; 
}

- (void) testThrowForMessageWithEmptyExceptionNegativePass
{
	[[badObject shouldNot] throw:@"" forMessage:@"description", nil]; 
}

- (void) testThrowForMessageWithVeryBadExceptionPositivePass
{
	[[badObject should] throw:@"VeryBad" forMessage:@"raise:", @"VeryBad", nil]; 
}

@end
