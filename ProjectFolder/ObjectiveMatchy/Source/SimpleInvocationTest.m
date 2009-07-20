//
//  SimpleInvocationTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "SimpleInvocationTest.h"
#import "ObjectWithKey.h"


@implementation SimpleInvocationTest

- (void) setUp
{
	obj = [[NSObject alloc] init];
}

#pragma mark simpleInvocationFromSelector:withArguments:

- (void) testSimpleInvocationReturnsInvocation
{
	STAssertEquals([[obj simpleInvocationFromSelector:@selector(isEqual:) 
											 withArguments:[NSArray arrayWithObject:[NSNumber numberWithInt:1]]] class], 
				   [NSInvocation class], @"");
}

- (void) testSimpleInvocationSetsAppropriateSelector_IsEqualTo
{
	NSInvocation * inv = [obj simpleInvocationFromSelector:@selector(isEqual:) 
											 withArguments:[NSArray arrayWithObject:[NSNumber numberWithInt:1]]];
	[[inv should] respondToSelector:@selector(selector) andReturn:OM_SEL(@selector(isEqual:))]; 
}

- (void) testSimpleInvocationSetsAppropriateSelector_setValue_forKey
{
	NSInvocation * inv = [obj simpleInvocationFromSelector:@selector(setValue:forKey:) 
											 withArguments:[NSArray arrayWithObjects:@"value", @"key", nil]];
	[[inv should] respondToSelector:@selector(selector) andReturn:OM_SEL(@selector(setValue:forKey:))]; 
}

- (void) testSimpleInvocationInvokes
{
	ObjectWithKey * objectWithKey = [[ObjectWithKey alloc] init];
	[[objectWithKey shouldNot] haveKey:@"aKey" withValue:@"value"];
	NSInvocation * inv = [objectWithKey simpleInvocationFromSelector:@selector(setValue:forKey:) 
											 withArguments:[NSArray arrayWithObjects:@"value", @"aKey", nil]];
	[inv invoke];
	[[objectWithKey should] haveKey:@"aKey" withValue:@"value"];
}

- (void) testSimpleInvocationReturnsObject
{
	ObjectWithKey * objectWithKey = [[ObjectWithKey alloc] init];
	[objectWithKey setValue:@"aValue" forKey:@"aKey"];
	NSInvocation * inv = [objectWithKey simpleInvocationFromSelector:@selector(valueForKey:) 
													   withArguments:[NSArray arrayWithObject:@"aKey"]];
	[inv invoke];
	id returnValue;
	[inv getReturnValue:&returnValue];
	[[returnValue should] eql:@"aValue"];
}

#pragma mark -

#pragma mark simpleInvoke:withArguments:

- (void) testSimpleInvokeInvokes
{
	ObjectWithKey * objectWithKey = [[ObjectWithKey alloc] init];
	[[objectWithKey shouldNot] haveKey:@"aKey" withValue:@"value"];
	[objectWithKey simpleInvoke:@selector(setValue:forKey:) 
				  withArguments:[NSArray arrayWithObjects:@"value", @"aKey", nil]];
	[[objectWithKey should] haveKey:@"aKey" withValue:@"value"];
}

- (void) testSimpleInvokeReturnsNilIfVoidMessage
{
	ObjectWithKey * objectWithKey = [[ObjectWithKey alloc] init];
	[[objectWithKey shouldNot] haveKey:@"aKey" withValue:@"value"];
	id returnValue = [objectWithKey simpleInvoke:@selector(setValue:forKey:) 
								   withArguments:[NSArray arrayWithObjects:@"value", @"aKey", nil]];
	STAssertNil(returnValue, nil);
}

- (void) testSimpleInvokeReturnsValue
{
	ObjectWithKey * objectWithKey = [[ObjectWithKey alloc] init];
	[objectWithKey setValue:@"aValue" forKey:@"aKey"];
	id returnValue = [objectWithKey simpleInvoke:@selector(valueForKey:)
								   withArguments:[NSArray arrayWithObject:@"aKey"]];
	[[returnValue should] eql:@"aValue"];
}


#pragma mark -

@end
