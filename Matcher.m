//
//  Matcher.m
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Matcher.h"
#import "Matcher-Eql.h"
#import "NSObject-Expectations.h"


@implementation Matcher

@synthesize actual, isPositive, matches, positiveFailureMessage, negativeFailureMessage;

- (id) initWithActual:(id)anActual 
		andIsPositive:(BOOL)aIsPositive
{
	self = [super init];
	if (self != nil) {
		self.actual = anActual;
		isPositive = aIsPositive;
		self.positiveFailureMessage = @"Positive Expectation not met.";
		self.negativeFailureMessage = @"Negative Expectation not met.";
	}
	return self;
}

- (BOOL) positiveFailure
{
	return (self.isPositive && !self.matches);
}

- (BOOL) negativeFailure
{
	return (!self.isPositive && self.matches);
}



@end
