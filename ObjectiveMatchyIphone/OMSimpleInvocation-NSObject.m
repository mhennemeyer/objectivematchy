//
//  OMSimpleInvocation-NSObject.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMSimpleInvocation-NSObject.h"


@implementation NSObject (OMSimpleInvocation)

- (NSInvocation *) simpleInvocationFromSelector:(SEL)aSelector withArguments:(NSArray *)arguments
{

	// create signature
	NSMethodSignature * sig = nil;
	sig = [[self class] instanceMethodSignatureForSelector:aSelector];
	
	// create invocation
	NSInvocation * inv = nil;
	inv = [NSInvocation invocationWithMethodSignature:sig];
	[inv setTarget:self];
	[inv setSelector:aSelector];
	
	// add args to invocation
	int index = 2; // Arguments start at index 2
	for (id arg in arguments) {
		[inv setArgument:&arg atIndex:index];
		index++;
	}
		
	return inv;
}

- (id) simpleInvoke:(SEL)aSelector withArguments:(NSArray *)arguments
{
	// create invocation
	NSInvocation * inv = [self simpleInvocationFromSelector:aSelector withArguments:arguments];
	
	// invoke
	[inv invoke];
	
	// if void
	if ( ![[inv methodSignature] methodReturnLength] )
		return nil;
	
	// get return Value
	id returnValue;
	[inv getReturnValue:&returnValue];
	
	return returnValue;
}

@end
