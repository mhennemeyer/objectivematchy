//
//  BadObject.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 19.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "BadObject.h"


@implementation BadObject

- (void) raise
{
	[NSException raise:@"BadThing" format:@""];
}

- (void) raise:(NSString *) anException
{
	[NSException raise:anException format:@""];
}
@end
