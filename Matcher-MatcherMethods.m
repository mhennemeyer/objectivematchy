//
//  Matcher-MatcherMethods.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "Matcher-MatcherMethods.h"

@implementation Matcher (MatcherMethods)

#pragma mark eql:

- (id) eql:(id)anExpected
{
	self.expected               = anExpected;
	self.matches                = [self.actual isEqualTo:self.expected];
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should be equal to: '%@', but isn't (with isEqualTo).", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not be equal to: '%@', but is (with isEqualTo).", 
								   self.actual, self.expected];
	
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
	self.expected               = expectedValue;
	id actualValue              = (id) [self.actual performSelector:selector];
	NSString *              key = [NSString stringWithCString:(char *)selector];
	self.matches                = [self.expected isEqualTo:actualValue];
	if ( [self.expected respondsToSelector:@selector(isAOMWrapper)] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:
									   @"'%@' should respond to: '%@' and return '%@', but was some scalar value (with isEqualTo).", 
									   self.actual, key, self.expected];
		self.negativeFailureMessage = [NSString stringWithFormat:
									   @"'%@' should not respond to: '%@' and return '%@', but did (with isEqualTo).", 
									   self.actual, key, self.expected];
	} else {
		self.positiveFailureMessage = [NSString stringWithFormat:
									   @"'%@' should respond to: '%@' and return '%@', but was '%@' (with isEqualTo).", 
									   self.actual, key, self.expected, actualValue];
		self.negativeFailureMessage = [NSString stringWithFormat:
									   @"'%@' should not respond to: '%@' and return '%@', but did (with isEqualTo).", 
									   self.actual, key, self.expected];
	}

	
	[self handleExpectation];
	return actualValue;
}

- (id) respondToSelector:(SEL)selector withObject:(id)argument andReturn:(id)expectedValue
{
	self.expected               = expectedValue;
	id actualValue              = [self.actual performSelector:selector withObject:argument];
	NSString *              key = [NSString stringWithCString:(char *)selector];
	self.matches                = [self.expected isEqualTo:actualValue];
	if ( [self.expected respondsToSelector:@selector(isAOMWrapper)] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:
									   @"'%@' should respond to: '%@' with '%@' and return '%@', but was some scalar value. (with isEqualTo).", 
									   self.actual, key, argument, self.expected];
		self.negativeFailureMessage = [NSString stringWithFormat:
									   @"'%@' should not respond to: '%@' with '%@' and return '%@', but did (with isEqualTo).", 
									   self.actual, key, argument, self.expected];
	} else {
		self.positiveFailureMessage = [NSString stringWithFormat:
									   @"'%@' should respond to: '%@' with '%@' and return '%@', but was '%@' (with isEqualTo).", 
									   self.actual, key, argument, self.expected, YES];
		self.negativeFailureMessage = [NSString stringWithFormat:
									   @"'%@' should not respond to: '%@' with '%@' and return '%@', but did (with isEqualTo).", 
									   self.actual, key, argument, self.expected];
	}
	
	[self handleExpectation];
	return actualValue;
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
	id actualValue = [self.actual valueForKey:aKey];
	self.matches                = [self.expected isEqualTo:actualValue];
	if ( [self.expected respondsToSelector:@selector(isAOMWrapper)] ) {
		self.positiveFailureMessage = [NSString stringWithFormat:
									   @"'%@' should have key: '%@', with Value: '%@', but was some scalar.", 
									   self.actual, aKey ,self.expected];
		self.negativeFailureMessage = [NSString stringWithFormat:
									   @"'%@' should not have key: '%@', with Value: '%@'. But it has.", 
									   self.actual, aKey, self.expected];
	} else {
		self.positiveFailureMessage = [NSString stringWithFormat:
									   @"'%@' should have key: '%@', with Value: '%@', but was '%@'.", 
									   self.actual, aKey ,self.expected, actualValue];
		self.negativeFailureMessage = [NSString stringWithFormat:
									   @"'%@' should not have key: '%@', with Value: '%@'. But it has.", 
									   self.actual, aKey, self.expected];
	}
	
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should have key: '%@', with Value: '%@', but was '%@'.", 
								   self.actual, aKey ,self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not have key: '%@', with Value: '%@'. But it has.", 
								   self.actual, aKey, self.expected];
	[self handleExpectation];
	
	return actualValue;
}

#pragma mark -

@end
