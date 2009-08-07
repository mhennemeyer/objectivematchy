//
//  Matcher.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMMatcher.h"
#import "OMException.h"


@implementation OMMatcher

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
	return [OMException oMfailure:self.filename 
						   atLine:self.linenumber 
				  withDescription:self.positiveFailureMessage];
}

- (NSException *) negativeException
{
	return [OMException oMfailure:self.filename 
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

- (BOOL) isWrapped
{
	return [self.expected respondsToSelector:@selector(isAOMWrapper)];
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

