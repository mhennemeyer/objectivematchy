//
//  ChangeValueForKeyTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 20.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ChangeValueForKeyTest.h"
#import "ObjectWithKey.h"


@implementation ChangeValueForKeyTest

- (void) setUp
{
	obj = [ObjectWithKey object];
	otherObj = [ObjectWithKey object];
}

#pragma mark changeValueForKey:forMessage:withArguments:

- (void) testChangeValueForKeyForMessageWithArgumentsPositivePass
{
	[[obj should] changeValueForKey:@"aKey" 
						 forMessage:@"setValue:forKey:" 
					  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", nil]];
}

- (void) testChangeValueForKeyForMessageWithArgumentsNegativePass
{
	[obj setValue:@"aValue" forKey:@"aKey"];
	[[obj shouldNot] changeValueForKey:@"aKey" 
						    forMessage:@"setValue:", @"aValue", @"forKey:", @"aKey", nil];
}

- (void) testChangeValueForKeyForMessageWithArgumentsPositiveFail
{
	OMMatcher * matcher = [obj should];
	[obj setValue:@"aValue" forKey:@"aKey"];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"changeValueForKey:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"aKey", @"setValue:forKey:", [NSArray arrayWithObjects:@"aValue", @"aKey", nil], nil]];
	
}

- (void) testChangeValueForKeyForMessageWithArgumentsNegativeFail
{
	OMMatcher * matcher = [obj shouldNot];

	[[matcher should] throw:OMFailure 
				 forMessage:@"changeValueForKey:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"aKey", @"setValue:forKey:", [NSArray arrayWithObjects:@"aValue", @"aKey", nil], nil]];
}

#pragma mark -

#pragma mark changeValueForKey:from:to:forMessage:withArguments:

- (void) testChangeValueForKeyFromToForMessageWithArgumentsPositivePass
{
	[[obj should] changeValueForKey:@"aKey" 
							   from:nil 
								 to:@"aValue"
						 forMessage:@"setValue:forKey:" 
					  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", nil]];
}

- (void) testChangeValueForKeyFromToForMessageWithArgumentsNegativePass
{
	[obj setValue:@"aValue" forKey:@"aKey"];
	
	[[obj shouldNot] changeValueForKey:@"aKey" 
								  from:nil 
									to:@"aValue"
							forMessage:@"setValue:forKey:" 
						 withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", nil]];
}

- (void) testChangeValueForKeyFromToForMessageWithArgumentsPositiveFail
{
	OMMatcher * matcher = [obj should];
	[obj setValue:@"aValue" forKey:@"aKey"];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"changeValueForKey:from:to:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"aKey", [NSNull null], @"aValue", @"setValue:forKey:", [NSArray arrayWithObjects:@"aValue", @"aKey", nil], nil]];
	
}

- (void) testChangeValueForKeyFromToForMessageWithArgumentsNegativeFail
{
	OMMatcher * matcher = [obj shouldNot];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"changeValueForKey:from:to:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"aKey", [NSNull null], @"aValue", @"setValue:forKey:", [NSArray arrayWithObjects:@"aValue", @"aKey", nil], nil]];
}

#pragma mark -

#pragma mark changeValueForKey:ofObject:forMessage:withArguments:

- (void) testChangeValueForKeyOfObjectForMessageWithArgumentsPositivePass
{
	
	[[obj should] changeValueForKey:@"aKey" 
						   ofObject:otherObj
						 forMessage:@"setValue:forKey:ofObject:" 
					  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", otherObj, nil]];
}

- (void) testChangeValueForKeyOfObjectForMessageWithArgumentsNegativePass
{
	[otherObj setValue:@"aValue" forKey:@"aKey"];
	[[obj shouldNot] changeValueForKey:@"aKey" 
						   ofObject:otherObj
						 forMessage:@"setValue:forKey:ofObject:" 
					  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", otherObj, nil]];
}

- (void) testChangeValueForKeyOfObjectForMessageWithArgumentsPositiveFail
{
	OMMatcher * matcher = [obj should];
	[otherObj setValue:@"aValue" forKey:@"aKey"];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"changeValueForKey:ofObject:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"aKey", otherObj,  @"setValue:forKey:ofObject:", [NSArray arrayWithObjects:@"aValue", @"aKey", otherObj, nil], nil]];
	
}

- (void) testChangeValueForKeyOfObjectForMessageWithArgumentsNegativeFail
{
	OMMatcher * matcher = [obj shouldNot];
	
	[[matcher should] throw:OMFailure 
				 forMessage:@"changeValueForKey:ofObject:forMessage:withArguments:"
			  withArguments:[NSArray arrayWithObjects:@"aKey", otherObj,  @"setValue:forKey:ofObject:", [NSArray arrayWithObjects:@"aValue", @"aKey", otherObj, nil], nil]];
}

@end
