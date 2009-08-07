//
//  returnValueForMessageTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>
#import "ObjectReturnsForMessage.h"

@interface ReturnValueForMessageTest : SenTestCase {
	ObjectReturnsForMessage * objThatReturnsHelloForMessage;
}

@end



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



- (void) testReturnValueForMessagePositiveFail
{
	OMMatcher * matcher = [objThatReturnsHelloForMessage should];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"returnValue:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"Not Hello", @"message", [NSArray array], nil]];
}

- (void) testReturnValueForMessageNegativeFail
{
	OMMatcher * matcher = [objThatReturnsHelloForMessage shouldNot];
	
    [[matcher should] throw:OMFailure 
		 forMessage: @"returnValue:forMessage:withArguments:"
		  withArguments: [NSArray arrayWithObjects:@"Hello", @"message", [NSArray array], nil]];
}

- (void) testReturnValueForMessage_andArg_PositiveFail
{
	
	OMMatcher * matcher = [objThatReturnsHelloForMessage should];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"returnValue:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"Not Hello", @"message:", [NSArray arrayWithObject:@"Hello"],  nil]];
}

- (void) testReturnValueForMessage_andArg_NegativeFail
{
	
	OMMatcher * matcher = [objThatReturnsHelloForMessage shouldNot];
	
    [[matcher should] throw:OMFailure 
				 forMessage: @"returnValue:forMessage:withArguments:"
			  withArguments: [NSArray arrayWithObjects:@"Hello", @"message:", [NSArray arrayWithObject:@"Hello"], nil]];
}

- (void) testReturnValueForMessage_andArg_andOtherArg_PositiveFail
{
	
	OMMatcher * matcher = [objThatReturnsHelloForMessage should];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"returnValue:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"Not Hello", @"message:andOtherArg:", [NSArray arrayWithObjects:@"Hello", @"Something",nil],  nil]];
}


- (void) testReturnValueForMessage_andArg_andOtherArg_NegativeFail
{
	
	OMMatcher * matcher = [objThatReturnsHelloForMessage shouldNot];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"returnValue:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"Hello", @"message:andOtherArg:", [NSArray arrayWithObjects:@"Hello", @"Hello",nil],  nil]];
}

@end
