//
//  OMIntWrapper.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMIntWrapper.h"


@implementation OMIntWrapper

@synthesize wrapperValue;

+ (OMIntWrapper *) wrapperWithValue:(int)anIntValue
{
	OMIntWrapper * wrapper = [[OMIntWrapper alloc] init];
	[wrapper autorelease];
	wrapper.wrapperValue = anIntValue;
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
	return [NSString stringWithFormat:@"%i", self.wrapperValue];
}

@end
