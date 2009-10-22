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
#import "OMException.h"

@implementation OMMatcher (OMMatcherMethods)

#pragma mark eql:

- (id) eql:(id)anExpected
{
	self.expected               = anExpected;
	self.matches                = [self.actual isEqual:self.expected];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should be equal to '%@', but isn't (with isEqual:).", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not be equal to '%@', but is (with isEqual:).", 
								   self.actual, self.expected];
	
	[self handleExpectation];
	
	return self.expected;
}

#pragma mark -

#pragma mark match:
#ifdef TARGET_MAC_OS
- (id) match:(NSString *)aRegEx
{
	self.expected               = aRegEx;
	
	// todo Refactor
	NSRange range;
	range = [self.expected rangeOfString:@"'"];
	if (range.location != NSNotFound)
		[NSException raise:@"Your Regex may not contain an apostrophe: >>'<< (U+0027). Sorry. " format:nil]; 
	NSMutableString * cmd = [NSMutableString stringWithString:@"ruby -e ' exit 1 unless %<"];
	[cmd appendString:[ [self.actual stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"] stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"]]; 
	[cmd appendString:[NSString stringWithFormat:@"> =~ %@ ' ", self.expected]];
	self.matches = system([cmd cStringUsingEncoding:NSASCIIStringEncoding]) ? NO : YES;

	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"String should match Regex: %@, but didn't (using ruby).String: '%@'", self.expected, self.actual];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"String should not match Regex: %@, but did (using ruby).String: '%@'", self.expected, self.actual];
	[self handleExpectation];
	
	return self.expected;
}
#endif

#pragma mark -

#pragma mark containObject:

- (id) containObject:(id)anExpected
{
	self.expected               = anExpected;
	self.matches                = [self.actual containsObject:self.expected];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"Array should contain '%@', but didn't (with containsObject:).", self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"Array should not contain '%@', but did (with containsObject:).", self.expected];	
	[self handleExpectation];
	
	return self.expected;
}

#pragma mark -


#pragma mark respondTo:

- (id) respondToSelector:(SEL)selector
{
	self.expected               = NSStringFromSelector(selector);
	self.matches                = [self.actual respondsToSelector:selector];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should respond to '%@', but did't.", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not respond to '%@', but did.", 
								   self.actual, self.expected];
	
	[self handleExpectation];
	
	return self.expected;
}

- (id) respondToSelector:(SEL)selector andReturn:(id)expectedValue
{
	self.expected = expectedValue;
	NSString * key = NSStringFromSelector(selector);
	if (![self.actual respondsToSelector:selector])
		@throw [OMException oMfailure:self.filename 
							   atLine:self.linenumber 
					  withDescription:[NSString stringWithFormat:@"'%@' won't respond to '%@' at all.",self.actual, key]];
	
	id actualValue = [self isWrapped] ? [[self.expected class] 
								          wrapperWithValue:[self.actual performSelector:selector]]
	                                  : [self.actual performSelector:selector];
	self.matches                = [self.expected isEqual:actualValue];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should respond to '%@' and return '%@', but was '%@' (with isEqualTo).", 
								   self.actual, key, self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not respond to '%@' and return '%@', but did (with isEqualTo).", 
								   self.actual, key, self.expected];
	[self handleExpectation];
	return self.expected;
}

- (id) respondToSelector:(SEL)selector withObject:(id)argument andReturn:(id)expectedValue
{
	
	self.expected               = expectedValue;
	
	NSString * key = NSStringFromSelector(selector);
	if (![self.actual respondsToSelector:selector])
		@throw [OMException oMfailure:self.filename 
							   atLine:self.linenumber 
					  withDescription:[NSString stringWithFormat:@"'%@' won't respond to '%@' at all.",self.actual, key]];
	
	id actualValue = [self isWrapped] ? [[ self.expected class] 
								         wrapperWithValue:[self.actual performSelector:selector withObject:argument]] 
	                                  : [self.actual performSelector:selector withObject:argument];

	self.matches                = [self.expected isEqual:actualValue];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should respond to '%@' with '%@' and return '%@', but was '%@' (with isEqual:).", 
								   self.actual, key, argument, self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not respond to '%@' with '%@' and return '%@', but did (with isEqual:).", 
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
	self.expected = value;
	id actualValue = [self isWrapped] ? [[self.expected class] wrapperWithValue:[self.actual valueForKey:aKey]] 
							          : [self.actual valueForKey:aKey];
	self.matches                = [self.expected isEqual:actualValue];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should have key '%@', with Value: '%@', but was '%@'.", 
								   self.actual, aKey ,self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not have key '%@', with Value: '%@'. But it has.", 
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
	
	// VARARGS HACK
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];

	OM_EXTRACT_DICT_FROM_VARARGS(dict, aMessage); // temporary Hack :)
	
	NSString * selectorString = [dict valueForKey:@"selectorString"];
	NSArray * arguments = [dict valueForKey:@"arguments"];
	
	return [self returnValue:expectedValue forMessage:selectorString withArguments:arguments];
}

- (id) returnValue:(id)expectedValue forMessage:(NSString *) aMessageString withArguments:(NSArray *) arguments
{
	self.expected = expectedValue;
	
	// Throw if wrapped
	if ([self isWrapped]) {
		self.positiveFailureMessage = @"returnValue:forMessage won't work with wrapped values. Sorry.";
		@throw [self positiveException];
	}
	
	//create selector
	SEL sel = NSSelectorFromString(aMessageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, aMessageString];
		@throw [self positiveException];
	}
	
	// create invocation
	NSInvocation * inv = [self.actual simpleInvocationFromSelector:sel withArguments:arguments];
	
	// invoke	
	[inv invoke];
	
	// Get return value
	id actualValue;
	[inv getReturnValue:&actualValue];
	
	self.matches                = [self.expected isEqual:actualValue];
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should return '%@', forMessage: '%@', but was '%@'.", 
								   self.actual, self.expected, aMessageString, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not return '%@', forMessage: '%@', but did.", 
								   self.actual, actualValue, aMessageString];
	
	
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
	
	return [self throw:expectedException forMessage:selectorString withArguments:arguments];
}

- (id) throw:(NSString *)expectedException forMessage:(NSString *) aMessageString withArguments:(NSArray *) arguments
{
	self.expected = expectedException;
		
	//create selector
	SEL sel = NSSelectorFromString(aMessageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, aMessageString];
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
	
	self.matches                = [self.expected isEqual:@""] ? !!exception : [[exception name] isEqual:self.expected];
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should throw '%@', for Message '%@', but was '%@'.", 
								   self.actual, self.expected, aMessageString, ((nil == exception) ? @"none" : [exception name])];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not throw '%@', for Message '%@', but did.", 
								   self.actual, self.expected, aMessageString];
	
	
	[self handleExpectation];
	return self.expected;
}

#pragma mark -

#pragma mark be:

- (id) be:(NSString *)omitIs
{
	self.expected = omitIs;
	
	NSMutableString * messageString = [NSMutableString stringWithFormat:@"is%@", omitIs];
	
	//create selector
	SEL sel = NSSelectorFromString(messageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, messageString];
		@throw [self positiveException];
	}
	
	// create invocation
	NSInvocation * inv = [self.actual simpleInvocationFromSelector:sel withArguments:nil];
	
	// invoke	
	[inv invoke];
	
	// Get return value
	BOOL * buffer = (BOOL *)malloc(1);
	[inv getReturnValue:buffer];
	
	self.matches                = *buffer;
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should return true for '%@' but didn't.", 
								   self.actual, messageString];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not return true for '%@' but did.", 
								   self.actual, messageString];
	
	
	[self handleExpectation];
	return self.expected;
}

- (id) be:(NSString *)omitIs with:(id)anObject
{
	self.expected = omitIs;
	// prepend is
	NSMutableString * messageString = [NSMutableString stringWithFormat:@"is%@", omitIs];
	
	//create selector
	SEL sel = NSSelectorFromString(messageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, messageString];
		@throw [self positiveException];
	}
	
	// create invocation
	NSInvocation * inv = [self.actual simpleInvocationFromSelector:sel withArguments:[NSArray arrayWithObject:anObject]];
	
	// invoke	
	[inv invoke];
	
	// Get BOOL return value
	BOOL * buffer = (BOOL *)malloc(1);
	[inv getReturnValue:buffer];
	
	self.matches                = *buffer;
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should return true for '%@' with '%@' but didn't.", 
								   self.actual, messageString, anObject];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not return true for '%@' with '%@' but did.", 
								   self.actual, messageString, anObject];
	
	
	[self handleExpectation];
	return self.expected;
}

#pragma mark -

#pragma mark changeValueForKey:forMessage


- (id) changeValueForKey:(NSString *)aKey forMessage:(id) aMessage, ...
{
	self.expected = aKey;
	
	// VARARGS HACK
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
	OM_EXTRACT_DICT_FROM_VARARGS(dict, aMessage); // temporary Hack :)
	NSString * selectorString = [dict valueForKey:@"selectorString"];
	NSArray  * arguments      = [dict valueForKey:@"arguments"];
	
	return [self changeValueForKey:aKey forMessage:selectorString withArguments:arguments];
}

- (id) changeValueForKey:(NSString *)aKey forMessage:(NSString *)messageString withArguments:(NSArray *)arguments
{
	self.expected = aKey;
	
	//create selector
	SEL sel = NSSelectorFromString(messageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, messageString];
		@throw [self positiveException];
	}
	
	id valueBeforeInvocation = [self.actual valueForKey:aKey];
	
	// invoke
	[self.actual simpleInvoke:sel withArguments:arguments];
	
	id valueAfterInvocation = [self.actual valueForKey:aKey];
	
	self.matches                = (nil != valueBeforeInvocation) ? ![valueBeforeInvocation isEqual:valueAfterInvocation]
																 : !(nil == valueAfterInvocation);
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should change value for key '%@', for Message '%@', but didn't; is '%@'.", 
								   self.actual, self.expected, messageString, valueAfterInvocation];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not change value for key '%@', for Message '%@', but did:Before: '%@', After '@%'.", 
								   self.actual, self.expected, messageString, valueBeforeInvocation,  valueAfterInvocation];
	
	
	[self handleExpectation];
	return self.expected;
}

- (id) changeValueForKey:(NSString *)aKey from:(id)fromValue to:(id)toValue forMessage:(NSString *)messageString withArguments:(NSArray *)arguments
{
	self.expected = aKey;
	
	//create selector
	SEL sel = NSSelectorFromString(messageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, messageString];
		@throw [self positiveException];
	}
	
	id valueBeforeInvocation = [self.actual valueForKey:aKey];
	
	// invoke
	[self.actual simpleInvoke:sel withArguments:arguments];
	
	id valueAfterInvocation = [self.actual valueForKey:aKey];
	
	BOOL didChange = (nil != valueBeforeInvocation) ? ![valueBeforeInvocation isEqual:valueAfterInvocation]
													: !(nil == valueAfterInvocation);
	
	BOOL fromCondition = (nil != valueBeforeInvocation) ? [valueBeforeInvocation isEqual:fromValue]
														: (nil ==  valueBeforeInvocation);
	
	BOOL toCondition = (nil != valueAfterInvocation) ? [valueAfterInvocation isEqual:toValue]
													  : (nil ==  valueAfterInvocation);
	
	self.matches = (fromValue == toValue) ? !didChange : fromCondition && toCondition && didChange;
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' expected change '%@', from '%@', to '%@', for '%@', but Before '%@', After '%@'.", 
								   self.actual, self.expected, fromValue, toValue, messageString, valueBeforeInvocation,  valueAfterInvocation];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' expected not change '%@', from '%@', to '%@', for '%@', but did.", 
								   self.actual, self.expected, fromValue, toValue, messageString];
	
	[self handleExpectation];
	return self.expected;
}

- (id) changeValueForKey:(NSString *)aKey ofObject:(id)anObject forMessage:(NSString *)messageString withArguments:(NSArray *)arguments
{
	self.expected = aKey;
	
	//create selector
	SEL sel = NSSelectorFromString(messageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, messageString];
		@throw [self positiveException];
	}
	
	id valueBeforeInvocation = [anObject valueForKey:aKey];
	
	// invoke
	[self.actual simpleInvoke:sel withArguments:arguments];
	
	id valueAfterInvocation = [anObject valueForKey:aKey];
	
	self.matches                = (nil != valueBeforeInvocation) ? ![valueBeforeInvocation isEqual:valueAfterInvocation]
																 : !(nil == valueAfterInvocation);
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should change value for key '%@', of object '%@',  for Message '%@', but didn't; is '%@'.", 
								   self.actual, self.expected, messageString, anObject, valueAfterInvocation];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not change value for key '%@', of object '%@', for Message '%@', but did Before '%@', After '@%'.", 
								   self.actual, self.expected, messageString, anObject,  valueBeforeInvocation,  valueAfterInvocation];
	
	
	[self handleExpectation];
	return self.expected;
}

- (id) changeValueForKey:(NSString *)aKey ofObject:(id)anObject from:(id)fromValue to:(id)toValue forMessage:(NSString *)messageString withArguments:(NSArray *)arguments
{
	self.expected = aKey;
	
	//create selector
	SEL sel = NSSelectorFromString(messageString);
	
	// throw if self.actual wont respond to selector
	if (! [self.actual respondsToSelector:sel] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:@"%@ won't respond to '%@'", self.actual, messageString];
		@throw [self positiveException];
	}
	
	id valueBeforeInvocation = [anObject valueForKey:aKey];
	
	// invoke
	[self.actual simpleInvoke:sel withArguments:arguments];
	
	id valueAfterInvocation = [anObject valueForKey:aKey];
	
	BOOL didChange = (nil != valueBeforeInvocation) ? ![valueBeforeInvocation isEqual:valueAfterInvocation]
	: !(nil == valueAfterInvocation);
	
	BOOL fromCondition = (nil != valueBeforeInvocation) ? [valueBeforeInvocation isEqual:fromValue]
	: (nil ==  valueBeforeInvocation);
	
	BOOL toCondition = (nil != valueAfterInvocation) ? [valueAfterInvocation isEqual:toValue]
	: (nil ==  valueAfterInvocation);
	
	self.matches = (fromValue == toValue) ? !didChange : fromCondition && toCondition && didChange;
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' expected change '%@', of '%@', from '%@', to '%@', for '%@', but Before '%@', After '%@'.", 
								   self.actual, self.expected, anObject,  fromValue, toValue, messageString, valueBeforeInvocation,  valueAfterInvocation];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' expected not change '%@', of '%@', from '%@', to '%@', for '%@', but did.", 
								   self.actual, self.expected, anObject, fromValue, toValue, messageString];
	
	[self handleExpectation];
	return self.expected;
}





@end
