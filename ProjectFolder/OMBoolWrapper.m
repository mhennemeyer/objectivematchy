//
//  OMBoolWrapper.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMBoolWrapper.h"


@implementation OMBoolWrapper

@synthesize wrapperValue;

+ (id) wrapperWithValue:(BOOL)aBoolValue
{
	OMBoolWrapper * wrapper = [[[OMBoolWrapper alloc] init] autorelease];
	wrapper.wrapperValue = aBoolValue;
	return wrapper;
}

- (BOOL) isEqualTo:(id)aValue
{
	if ([aValue respondsToSelector:@selector(isAOMWrapper)])
		return ([self wrapperValue] == [aValue wrapperValue]);
	return [super isEqual:aValue];
}

- (NSString *) description
{
	return self.wrapperValue ? @"YES" : @"NO";
}

@end


