//
//  OMIntWrapper.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Foundation/Foundation.h>
#import "OMWrapper.h"

@interface OMIntWrapper : OMWrapper
{
	int wrapperValue;
}
@property (readwrite) int wrapperValue;

+ (OMIntWrapper *)wrapperWithValue:(int)anIntValue;
- (BOOL) isEqual:(id)aValue;

@end
