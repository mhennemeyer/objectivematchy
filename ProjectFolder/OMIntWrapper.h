//
//  OMIntWrapper.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>
#import "OMWrapper.h"

@interface OMIntWrapper : OMWrapper
{
	int wrapperValue;
}
@property (readwrite) int wrapperValue;

+ (id)wrapperWithValue:(int)anIntValue;
- (BOOL) isEqualTo:(id)aValue;

@end
