//
//  MatchTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 20.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.


#import "MatchTest.h"


@implementation MatchTest

- (void) testStringMatchPositivePass
{
	[[@"Hello" should] match:@"/.*/"];
}

- (void) testStringMatchNegativePass
{
	[[@"Hello" shouldNot] match:@"/World/"];
}

- (void) testStringMatchPositiveFail
{
	OMMatcher * matcher = [@"Hello" should];
	[[matcher should] throw:OMFailure 
				 forMessage:@"match:" 
			  withArguments:[NSArray arrayWithObject:@"/World/"]];
}

- (void) testStringMatchNegativeFail
{
	OMMatcher * matcher = [@"Hello" shouldNot];
	[[matcher should] throw:OMFailure 
				 forMessage:@"match:" 
			  withArguments:[NSArray arrayWithObject:@"/.*/"]];
}

@end
