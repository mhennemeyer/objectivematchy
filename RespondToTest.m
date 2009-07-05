//
//  RespondToTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "RespondToTest.h"
#import "NSObject-Expectations.h"
#import "Matcher-MatcherMethods.h"


@implementation RespondToTest

- (void) testRespondToPass
{
	NSObject * anObject = [[NSObject alloc] init];
	[[anObject should] respondTo:@selector(copy)];
}

- (void) testRespondToFail
{
	NSObject * anObject = [[NSObject alloc] init];
	STAssertThrows([[anObject should] respondTo:@selector(opy)], @"Should Throw");
}

@end
