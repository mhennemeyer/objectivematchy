//
//  OMFloatWrapper.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 20.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMFloatWrapper.h"


@implementation OMFloatWrapper

@synthesize wrapperValue;

+ (OMFloatWrapper *) wrapperWithValue:(float)aFloatValue
{
	OMFloatWrapper * wrapper = [[OMFloatWrapper alloc] init];
	[wrapper autorelease];
	wrapper.wrapperValue = aFloatValue;
	return wrapper;
}

- (BOOL) isEqual:(id)aValue
{
	if ([aValue respondsToSelector:@selector(isAOMWrapper)])
		return ([self wrapperValue] == [aValue wrapperValue]);
	return [super isEqual:aValue];
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"%f", self.wrapperValue];
}


@end
