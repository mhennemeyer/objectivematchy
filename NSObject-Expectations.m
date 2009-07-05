//
//  NSObject-Expectations.m
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSObject-Expectations.h"
#import "Matcher.h"

@implementation NSObject (Expectations)

- (id) addPositiveExpectation:(NSString *)file line:(int)line
{
	return [[[Matcher alloc] initWithActual:self 
							  andIsPositive:YES 
								   filename:file 
								 linenumber:line] autorelease];
}

- (id) addNegativeExpectation:(NSString *)file line:(int)line
{
	return [[[Matcher alloc] initWithActual:self 
							  andIsPositive:NO 
								   filename:file 
								 linenumber:line] autorelease];
}


@end
