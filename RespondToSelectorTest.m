//
//  RespondToSelectorTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "RespondToSelectorTest.h"
#import "NSObject-Expectations.h"
#import "Matcher-MatcherMethods.h"


@implementation RespondToSelectorTest

#pragma mark respondToSelector:

- (void) setUp
{
	anObject = [[NSObject alloc] init];
}

- (void) testRespondToPositivePass
{
	[[anObject should] respondToSelector:@selector(copy)];
}

- (void) testRespondToSelectorPositiveFail
{
	STAssertThrows([[anObject should] respondToSelector:@selector(opy)], @"Should Throw");
}

- (void) testRespondToSelectorNegativePass
{
	[[anObject shouldNot] respondToSelector:@selector(opy)];
}

- (void) testRespondToSelectorNegativeFail
{
	STAssertThrows([[anObject shouldNot] respondToSelector:@selector(copy)], @"Should Throw");
}

#pragma mark -

#pragma mark respondToSelector:andReturn

- (void) testRespondToSelectorAndReturnPositivePass
{
	[[anObject should] respondToSelector:@selector(description) 
					   andReturn:[anObject description]];
}

- (void) testRespondToSelectorAndReturnPositiveFail
{
	STAssertThrows([[anObject should] respondToSelector:@selector(description) 
									  andReturn:@"Hello"], @"Should Throw");
}

- (void) testRespondToSelectorAndReturnNegativePass
{
	[[anObject shouldNot] respondToSelector:@selector(description) 
						  andReturn:@"Hello"];
}

- (void) testRespondToSelectorAndReturnNegativeFail
{
	STAssertThrows([[anObject shouldNot] respondToSelector:@selector(description) andReturn:[anObject description]], @"Should Throw");
}

#pragma mark -

#pragma mark respondToSelector:withObject:andReturn

- (void) testRespondToSelectorWithObjectAndReturnPositivePass
{
	[[anObject should] respondToSelector:@selector(isEqualTo:) 
					  withObject:anObject 
					   andReturn:OM_YES];
}

- (void) testRespondToSelectorWithObjectAndReturnPositiveFail
{
	STAssertThrows([[anObject should] respondToSelector:@selector(isEqualTo:) 
									 withObject:anObject
									  andReturn:OM_NO], @"Should Throw");
}

- (void) testRespondToSelectorWithObjectAndReturnNegativePass
{
	[[anObject shouldNot] respondToSelector:@selector(isEqualTo:) 
						 withObject:anObject
						  andReturn:OM_NO];
}

- (void) testRespondToSelectorWithObjectAndReturnNegativeFail
{
	STAssertThrows([[anObject shouldNot] respondToSelector:@selector(isEqualTo:) 
										withObject:anObject
										 andReturn:OM_YES], @"Should Throw");
}

#pragma mark -

@end
