//
//  Matcher-Eql.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "Matcher-Eql.h"



@implementation Matcher (Eql)

- (BOOL) eql:(id)expected
{
	self.matches                = [self.actual isEqualTo:expected];
	self.positiveFailureMessage = @"Hello";
	self.negativeFailureMessage = @"Hello";
	
	if ( [self positiveFailure] )
		[NSException raise:@"ExpectationNotMet" format:self.positiveFailureMessage];
	
	if ( [self negativeFailure] )
		[NSException raise:@"ExpectationNotMet" format:self.negativeFailureMessage];
	
	return YES;
}

@end
