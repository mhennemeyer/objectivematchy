//
//  OMMatcher-OMMatcherMethods.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMMatcher-OMMatcherMethods.h"
#import "OMSimpleInvocation-NSObject.h"
#import "OMWrapper.h"
#import "ObjectiveMatchyMacros.h"

@implementation OMMatcher (OMMatcherMethods)

#pragma mark eql:

- (id) eql:(id)anExpected
{
	self.expected               = anExpected;
	self.matches                = [self.actual isEqualTo:self.expected];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should be equal to: '%@', but isn't (with isEqualTo:).", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not be equal to: '%@', but is (with isEqualTo:).", 
								   self.actual, self.expected];
	
	[self handleExpectation];
	
	return self.expected;
}

#pragma mark -

#pragma mark containObject:

- (id) containObject:(id)anExpected
{
	self.expected               = anExpected;
	self.matches                = [self.actual containsObject:self.expected];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"Array should contain: '%@', but didn't (with containsObject:).", self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"Array should not contain: '%@', but did (with containsObject:).", self.expected];	
	[self handleExpectation];
	
	return self.expected;
}

#pragma mark -


#pragma mark respondTo:

- (id) respondToSelector:(SEL)selector
{
	self.expected               = [NSString stringWithCString:(char *)selector];
	self.matches                = [self.actual respondsToSelector:selector];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should respond to: '%@', but did't.", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not respond to: '%@', but did.", 
								   self.actual, self.expected];
	
	[self handleExpectation];
	
	return self.expected;
}

- (id) respondToSelector:(SEL)selector andReturn:(id)expectedValue
{
	self.expected = expectedValue;
	id actualValue = [self isWrapped] ? [[self.expected class] 
								          wrapperWithValue:[self.actual performSelector:selector]]
	                                  : [self.actual performSelector:selector];
	NSString *              key = [NSString stringWithCString:(char *)selector];
	self.matches                = [self.expected isEqualTo:actualValue];
	self.matches                = [self.expected isEqualTo:actualValue];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should respond to: '%@' and return '%@', but was '%@' (with isEqualTo).", 
								   self.actual, key, self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not respond to: '%@' and return '%@', but did (with isEqualTo).", 
								   self.actual, key, self.expected];
	[self handleExpectation];
	return self.expected;
}

- (id) respondToSelector:(SEL)selector withObject:(id)argument andReturn:(id)expectedValue
{
	
	self.expected               = expectedValue;
	id actualValue = [self isWrapped] ? [[ self.expected class] 
								         wrapperWithValue:[self.actual performSelector:selector withObject:argument]] 
	                                  : [self.actual performSelector:selector withObject:argument];

	NSString *              key = [NSString stringWithCString:(char *)selector];
	self.matches                = [self.expected isEqualTo:actualValue];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should respond to: '%@' with '%@' and return '%@', but was '%@' (with isEqualTo).", 
								   self.actual, key, argument, self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not respond to: '%@' with '%@' and return '%@', but did (with isEqualTo).", 
								   self.actual, key, argument, self.expected];
	[self handleExpectation];
	return self.expected;
}

#pragma mark -

#pragma mark haveKey:

- (id) haveKey:(NSString *)aKey
{
	self.expected               = aKey;
	BOOL hasKey = YES;
	@try {
		[self.actual valueForKey:aKey];
	}
	@catch (NSException * e) {
		if ([e name] == NSUndefinedKeyException) {
			hasKey = NO;
		} else {
			@throw e;
		}
			
	}
	self.matches                = hasKey;
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should have key: '%@'.", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not have key: '%@'. ", 
								   self.actual, self.expected];
	
	[self handleExpectation];
	
	return self.expected;
}

- (id) haveKey:(NSString *)aKey withValue:(id)value
{
	self.expected               = value;
	id actualValue = [self isWrapped] ? [[self.expected class] wrapperWithValue:[self.actual valueForKey:aKey]] 
							          : [self.actual valueForKey:aKey];
	self.matches                = [self.expected isEqualTo:actualValue];
	self.matches                = [self.expected isEqualTo:actualValue];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should have key: '%@', with Value: '%@', but was '%@'.", 
								   self.actual, aKey ,self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not have key: '%@', with Value: '%@'. But it has.", 
								   self.actual, aKey, self.expected];
	[self handleExpectation];
	
	return self.expected;
}

#pragma mark -

#pragma mark returnValue:forMessage

- (id) returnValue:(id)expectedValue forMessage:(id) aMessage, ...
{
	self.expected = expectedValue;
	
	// Throw if wrapped
	if ([self isWrapped]) {
		self.positiveFailureMessage = @"returnValue:forMessage won't work with wrapped values. Sorry.";
		@throw [self positiveException];
	}
	
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];

	OM_EXTRACT_DICT_FROM_VARARGS(dict, aMessage); // temporary Hack :)
	
	NSString * selectorString = [dict valueForKey:@"selectorString"];
	NSArray * arguments = [dict valueForKey:@"arguments"];

	//create selector
	SEL sel = NSSelectorFromString(selectorString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, selectorString];
		@throw [self positiveException];
	}
	
	// create invocation
	NSInvocation * inv = [self.actual simpleInvocationFromSelector:sel withArguments:arguments];
	
	// invoke	
	[inv invoke];
	
	// Get return value
	id actualValue;
	[inv getReturnValue:&actualValue];
	
	self.matches                = [self.expected isEqualTo:actualValue];
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should return: '%@', forMessage: '%@', but was '%@'.", 
								   self.actual, self.expected, selectorString, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not return: '%@', forMessage: '%@', but did.", 
								   self.actual, actualValue, selectorString];
	
	
	[self handleExpectation];
	return expectedValue;
}

#pragma mark  -

#pragma mark throw:forMessage

- (id) throw:(NSString *)expectedException forMessage:(id) aMessage, ...
{
	self.expected = expectedException;
	
	
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
	
	OM_EXTRACT_DICT_FROM_VARARGS(dict, aMessage); // temporary Hack :)
	
	NSString * selectorString = [dict valueForKey:@"selectorString"];
	NSArray * arguments = [dict valueForKey:@"arguments"];
	
	//create selector
	SEL sel = NSSelectorFromString(selectorString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, selectorString];
		@throw [self positiveException];
	}
	
	// create invocation
	NSInvocation * inv = [self.actual simpleInvocationFromSelector:sel withArguments:arguments];
	NSException * exception = nil;
	@try {
		[inv invoke];
	}
	@catch (NSException * e) {
		exception = e;
	}
	
	self.matches                = [self.expected isEqualTo:@""] ? !!exception : [[exception name] isEqualTo:self.expected];
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should throw: '%@', forMessage: '%@', but was '%@'.", 
								   self.actual, self.expected, selectorString, @"todo"];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not throw: '%@', forMessage: '%@', but did.", 
								   self.actual, self.expected, selectorString];
	
	
	[self handleExpectation];
	return self.expected;
}

#pragma mark -

#pragma mark be:

- (id) be:(id)expectedValue, ... 
{
	self.expected = expectedValue;

	
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
	
	OM_EXTRACT_DICT_FROM_VARARGS(dict, expectedValue); // temporary Hack :)
	
	NSMutableString * selectorString = [NSMutableString stringWithString:[dict valueForKey:@"selectorString"]];
	selectorString = [NSMutableString stringWithFormat:@"is%@", selectorString];
	NSArray * arguments = [dict valueForKey:@"arguments"];
	
	//create selector
	SEL sel = NSSelectorFromString(selectorString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, selectorString];
		@throw [self positiveException];
	}
	
	// create invocation
	NSInvocation * inv = [self.actual simpleInvocationFromSelector:sel withArguments:arguments];
	
	// invoke	
	[inv invoke];
	
	// Get return value
	BOOL * buffer = (BOOL *)malloc(1);
	[inv getReturnValue:buffer];
	
	self.matches                = *buffer;
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should return true for: '%@' but didn't.", 
								   self.actual, selectorString];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should return false for: '%@' but didn't.", 
								   self.actual, selectorString];
	
	
	[self handleExpectation];
	return expectedValue;
}

@end
