//
//  OMExpectations-NSObject.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMExpectations-NSObject.h"
#import "OMMatcher.h"


@implementation NSObject (OMExpectations)

- (OMMatcher *) addPositiveExpectation:(NSString *)file line:(int)line
{
	return [[[OMMatcher alloc] initWithActual:self 
							    andIsPositive:YES 
								     filename:file 
								   linenumber:line] autorelease];
}

- (OMMatcher *) addNegativeExpectation:(NSString *)file line:(int)line
{
	return [[[OMMatcher alloc] initWithActual:self 
							    andIsPositive:NO 
								     filename:file 
								   linenumber:line] autorelease];
}


@end
