//
//  Matcher.m
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Matcher.h"
#import "NSObject-Expectations.h"


@implementation Matcher

@synthesize actual, isPositive, matches, positiveFailureMessage, negativeFailureMessage, expected;
@synthesize linenumber, filename;

- (id) initWithActual:(id)anActual 
		andIsPositive:(BOOL)aIsPositive 
			 filename:(NSString *)file 
		   linenumber:(int)line
{
	self = [super init];
	if (self != nil) {
		self.linenumber = line;
		self.filename = file;
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

- (NSException *) positiveException
{
	return [NSException failureInFile:self.filename 
							   atLine:self.linenumber 
					  withDescription:self.positiveFailureMessage];
}

- (NSException *) negativeException
{
	return [NSException failureInFile:self.filename 
							   atLine:self.linenumber 
					  withDescription:self.negativeFailureMessage];
}


- (void) handleExpectation
{
	if ( [self positiveFailure] )
		@throw [self positiveException];
	
	if ( [self negativeFailure] )
		@throw [self negativeException];	
}

- (void) dealloc
{
	self.actual = nil;
	self.expected = nil;
	self.positiveFailureMessage = nil;
	self.negativeFailureMessage = nil;
	[super dealloc];
}



@end
