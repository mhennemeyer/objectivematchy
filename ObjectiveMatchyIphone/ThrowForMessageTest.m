//
//  ThrowForMessageTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 17.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "BadObject.h"
#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@interface ThrowForMessageTest : SenTestCase {
	BadObject * badObject;
}

@end

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
	[[badObject should] throw:@"VeryBad" 
				   forMessage:@"raise:" 
				withArguments:[NSArray arrayWithObject:@"VeryBad"]]; 
}

- (void) testThrowForMessageWithEmptyExceptionPositiveFail
{
	OMMatcher * matcher = [badObject should];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"throw:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"", @"dontRaise", [NSArray array], nil]]; 
}

- (void) testThrowForMessageWithEmptyExceptionNegativeFail
{
	OMMatcher * matcher = [badObject shouldNot];
	
	[[matcher should] throw:OMFailure
				 forMessage:@"throw:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"", @"raise", [NSArray array], nil]];
}

- (void) testThrowForMessageWithVeryBadExceptionPositiveFail
{
	OMMatcher * matcher = [badObject should];
	
	[[matcher should] throw:OMFailure
				 forMessage:@"throw:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"VeryGood", @"raise:", [NSArray arrayWithObject:@"VeryBad"], nil]];
}

- (void) testThrowForMessageWithVeryBadExceptionNegativeFail
{
	OMMatcher * matcher = [badObject shouldNot];
	
	[[matcher should] throw:OMFailure
				 forMessage:@"throw:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"VeryBad", @"raise:", [NSArray arrayWithObject:@"VeryBad"], nil]];
}


@end
