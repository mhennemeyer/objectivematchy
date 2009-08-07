//
//  OMException.m
//  ObjectiveMatchyIphone
//
//  Created by Matthias Hennemeyer on 04.08.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//

#import "OMException.h"


@implementation OMException
+ (OMException *) oMfailure:(NSString *)filename 
					 atLine:(int)lineNumber 
			withDescription:(NSString *)failureMessage
{
    NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:
						   filename, OMFilenameKey,
						   [NSNumber numberWithInt:lineNumber], OMLineNumberKey,
						   failureMessage, OMFailureMessageKey,
						   nil];
	
    return (OMException *) [self exceptionWithName:OMFailure
											reason:failureMessage
										  userInfo:info];
}

- (NSString *) filename
{
	return [[self userInfo] objectForKey:OMFilenameKey];
}

- (NSNumber *) lineNumber
{
	return [[self userInfo] objectForKey:OMLineNumberKey];
}
@end


NSString * const OMFilenameKey = @"OMFilenameKey";
NSString * const OMLineNumberKey = @"OMLineNumberKey";
NSString * const OMFailureMessageKey = @"OMFailureMessageKey";
NSString * const OMFailure = @"OMFailure";

