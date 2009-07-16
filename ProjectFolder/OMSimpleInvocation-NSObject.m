//
//  OMSimpleInvocation-NSObject.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMSimpleInvocation-NSObject.h"


@implementation NSObject (OMSimpleInvocation)

- (NSInvocation *) simpleInvocationFromArray:(NSArray *)anArray
{
	// create selector
	SEL sel;
	sel = @selector(isEqual:);
	
	// create signature
	NSMethodSignature * sig = nil;
	sig = [[self class] instanceMethodSignatureForSelector:sel];
	
	// create invocation
	NSInvocation * inv = nil;
	inv = [NSInvocation invocationWithMethodSignature:sig];
	[inv setTarget:self];
	[inv setSelector:sel];
	
	NSArray * arguments = [NSArray arrayWithObject:[NSNumber numberWithInt:1]];
	
	// add args to invocation
	int index = 2; // Arguments start at index 2
	for (id arg in arguments) {
		[inv setArgument:&arg atIndex:2];
		index++;
	}
	
	
	return inv;
}

@end
