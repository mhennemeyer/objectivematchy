//
//  Matcher-MatcherMethods.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "Matcher-MatcherMethods.h"

@implementation Matcher (MatcherMethods)

- (id) eql:(id)anExpected
{
	self.expected               = anExpected;
	self.matches                = (self.actual == self.expected);
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should be equal to: '%@', but is't (using ==).", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not be equal to: '%@', but is (using ==).", 
								   self.actual, self.expected];
	
	[self handleExpectation];
	
	return self.expected;
}

- (id) respondTo:(SEL)selector
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
	self.matches                = (self.expected == actualValue);
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"'%@' should have key: '%@', with Value: '%@', but was '%@'.", 
								   self.actual, aKey ,self.expected, actualValue];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"'%@' should not have key: '%@', with Value: '%@'. But it has.", 
								   self.actual, aKey, self.expected];
	[self handleExpectation];
	
	return self.expected;
}

@end
