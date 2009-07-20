//
//  OM-NSException.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 13.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OM-NSException.h"

// Maybe it would be better to subclass NSException, because now i overwrite SenTests
// category added to NSException and so ST... Failures are not longer shown inline.

@implementation NSException (OM)
+ (NSException *) oMfailure:(NSString *)filename 
                         atLine:(int)lineNumber 
                withDescription:(NSString *)failureMessage
{
    NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:
								 filename, OMFilenameKey,
								 [NSNumber numberWithInt:lineNumber], OMLineNumberKey,
								 failureMessage, OMFailureMessageKey,
								 nil];
	
    return [self exceptionWithName:OMFailure
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