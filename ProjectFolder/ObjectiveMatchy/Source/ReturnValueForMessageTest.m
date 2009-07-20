//
//  returnValueForMessageTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ReturnValueForMessageTest.h"
#import "ObjectReturnsForMessage.h"


@implementation ReturnValueForMessageTest

- (void) setUp	
{
	objThatReturnsHelloForMessage = [[ObjectReturnsForMessage alloc] init];
}

- (void) testReturnValueForMessagePositivePass
{
	[[objThatReturnsHelloForMessage should] returnValue:@"Hello"
											 forMessage:@"message", nil];
}

- (void) testReturnValueForMessageNegativePass
{
	[[objThatReturnsHelloForMessage shouldNot] returnValue:@"Not Hello"
											    forMessage:@"message", nil];
}

- (void) testReturnValueForMessage_andArg_PositivePass
{
	
	[[objThatReturnsHelloForMessage should] returnValue:@"Hello Again"
											 forMessage:@"message:", @"Hello Again", nil];
}

- (void) testReturnValueForMessage_andArg_NegativePass
{
	
	[[objThatReturnsHelloForMessage shouldNot] returnValue:@"Something Else"
											 forMessage:@"message:", @"Hello Again", nil];
}

- (void) testReturnValueForMessage_andArg_andOtherArg_PositivePass
{
	
	[[objThatReturnsHelloForMessage should] returnValue:@"Hello Again"
											 forMessage:@"message:", @"Hello", 
													@"andOtherArg:", @"Hello Again", nil];
}

- (void) testReturnValueForMessage_andArg_andOtherArg_NegativePass
{
	
	[[objThatReturnsHelloForMessage shouldNot] returnValue:@"Hello"
											    forMessage:@"message:", @"Hello", 
													   @"andOtherArg:", @"Hello Again", nil];
}

@end
