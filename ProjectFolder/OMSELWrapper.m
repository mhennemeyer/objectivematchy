//
//  OMSELWrapper.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMSELWrapper.h"


@implementation OMSELWrapper

@synthesize wrapperValue;

+ (id) wrapperWithValue:(SEL)aSELValue
{
	OMSELWrapper * wrapper = [[[OMSELWrapper alloc] init] autorelease];
	wrapper.wrapperValue = aSELValue;
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
	return NSStringFromSelector(self.wrapperValue);
}

@end
