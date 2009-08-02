//
//  BadObject.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 19.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "BadObject.h"


@implementation BadObject


+ (BadObject *) badObject
{
	BadObject * badObject = [[BadObject alloc] init];
	[badObject autorelease];
	// Comment
	return badObject;
}

- (void) raise
{
	[NSException raise:@"BadThing" format:@""];
}

- (void) dontRaise
{
}

- (void) raise:(NSString *) anException
{
	[NSException raise:anException format:@""];
}

- (BOOL) isBad
{
	return YES;
}

- (BOOL) isGood
{
	return NO;
}
@end
