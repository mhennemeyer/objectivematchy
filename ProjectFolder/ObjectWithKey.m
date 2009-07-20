//
//  ObjectWithKey.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectWithKey.h"


@implementation ObjectWithKey

+ (ObjectWithKey *) object
{
	ObjectWithKey * obj = [[ObjectWithKey alloc] init];
	[obj autorelease];
	return obj;
}

- (int) integerValueOne
{
	return 1;
}

- (void) setValue:(id)aValue forKey:(NSString *)key ofObject:(id)anObject
{
	[anObject setValue:aValue forKey:key];
}

@end
