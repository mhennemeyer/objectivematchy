//
//  MatchTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 20.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.


//#import "ObjectiveMatchy.h"
//#import <SenTestingKit/SenTestingKit.h>
//
//
//@interface MatchTest : SenTestCase {
//	NSString * multilineStringWithCriticalChars;
//}
//
//@end
//
//
//@implementation MatchTest
//
//
//
//- (void) setUp	
//{
//	multilineStringWithCriticalChars = @"Line Number One \" } '' % \n"
//									   @"Line Number Two \n"	
//					                   @"Line Number Three \n";
//}
//
//#pragma mark simple String without critical characters
//
//- (void) testStringMatchPositivePass
//{
//	[[@"Hello" should] match:@"/.*/"];
//}
//
//- (void) testStringMatchNegativePass
//{
//	[[@"Hello" shouldNot] match:@"/World/"];
//}
//
//- (void) testStringMatchPositiveFail
//{
//	OMMatcher * matcher = [@"Hello" should];
//	[[matcher should] throw:OMFailure 
//				 forMessage:@"match:" 
//			  withArguments:[NSArray arrayWithObject:@"/World/"]];
//}
//
//- (void) testStringMatchNegativeFail
//{
//	OMMatcher * matcher = [@"Hello" shouldNot];
//	[[matcher should] throw:OMFailure 
//				 forMessage:@"match:" 
//			  withArguments:[NSArray arrayWithObject:@"/.*/"]];
//}
//
//#pragma mark -
//
//#pragma mark multiline String
//
//- (void) testMultilineStringMatchPositivePass
//{
//	[[multilineStringWithCriticalChars should] match:@"/Three/"];
//}
//
//- (void) testMultilineStringMatchNegativePass
//{
//	[[multilineStringWithCriticalChars shouldNot] match:@"/^Blah/"];
//}
//
//- (void) testMultilineStringMatchPositiveFail
//{
//	OMMatcher * matcher = [multilineStringWithCriticalChars should];
//	[[matcher should] throw:OMFailure 
//				 forMessage:@"match:" 
//			  withArguments:[NSArray arrayWithObject:@"/World/"]];
//}
//
//- (void) testMultilineStringMatchNegativeFail
//{
//	OMMatcher * matcher = [multilineStringWithCriticalChars shouldNot];
//	[[matcher should] throw:OMFailure 
//				 forMessage:@"match:" 
//			  withArguments:[NSArray arrayWithObject:@"/.*/"]];
//}
//
//- (void) testMatchRaisesIfThereIsAnApostropheInRegex
//{
//	OMMatcher * matcher = [multilineStringWithCriticalChars should];
//	[[matcher should] throw:@"" forMessage:@"match:" withArguments:[NSArray arrayWithObject:@"/'/"]];
//}
//
//
//@end
