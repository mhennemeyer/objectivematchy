//
//  Matcher-MatcherMethods.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "Matcher-MatcherMethods.h"

@implementation Matcher (MatcherMethods)

- (BOOL) eql:(id)anExpected
{
	self.expected               = anExpected;
	self.matches                = (self.actual == self.expected);
	self.positiveFailureMessage = [NSString stringWithFormat:
								   @"%@ should have been equal to: %d, but wasn't (using ==).", 
								   self.actual, self.expected];
	self.negativeFailureMessage = [NSString stringWithFormat:
								   @"%@ should not be equal to: %@, but was (using ==).", 
								   self.actual, self.expected];
	
	[self handleExpectation];
	
	return YES;
}

@end
