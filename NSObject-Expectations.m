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


// Todo autorelease
- (id) should
{
	return [[[Matcher alloc] initWithActual:self andIsPositive:YES] autorelease];
}

- (id) shouldNot
{
	return [[[Matcher alloc] initWithActual:self andIsPositive:NO] autorelease];
}

@end
