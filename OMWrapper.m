//
//  OMWrapper.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 06.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//

#import "OMWrapper.h"


@implementation OMWrapper

@synthesize boolValue;

+ (id) wrapperWithBool:(BOOL)aBoolValue
{
	OMWrapper * wrapper = [[[OMWrapper alloc] init] autorelease];
	
	wrapper.boolValue = aBoolValue;
	
	return wrapper;
}

- (BOOL) isEqualTo:(BOOL)aBoolValue
{
	return (boolValue == aBoolValue);
}

- (BOOL)isAOMWrapper
{
	return YES;
}

@end
