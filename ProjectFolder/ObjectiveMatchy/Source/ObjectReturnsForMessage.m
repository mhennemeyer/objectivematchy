//
//  ObjectReturnsForMessage.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 17.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectReturnsForMessage.h"


@implementation ObjectReturnsForMessage

- (NSString *) message
{
	return @"Hello";
}

- (id) message:(id) andArg
{
	return andArg;
}

- (id) message:(id) andArg andOtherArg:(id) otherArg
{
	return otherArg;
}

@end
