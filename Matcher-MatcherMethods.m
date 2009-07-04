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
	self.positiveFailureMessage = @"Hello";
	self.negativeFailureMessage = @"Hello";
	
	[self handleExpectation];
	
	return YES;
}

@end
