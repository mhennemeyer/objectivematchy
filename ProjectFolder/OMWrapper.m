//
//  OMWrapper.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 06.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMWrapper.h"

@implementation OMWrapper

+ (id) wrapperWithValue:(id)aValue
{
	return @"Make Compiler Happy";
}

- (BOOL)isAOMWrapper
{
	return YES;
}

@end
