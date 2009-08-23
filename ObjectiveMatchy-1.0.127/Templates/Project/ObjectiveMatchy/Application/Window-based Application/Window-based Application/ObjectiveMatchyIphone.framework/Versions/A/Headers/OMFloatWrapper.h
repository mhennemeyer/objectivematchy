//
//  OMFloatWrapper.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 20.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Foundation/Foundation.h>

#import "OMWrapper.h"


@interface OMFloatWrapper : OMWrapper 
{
	float wrapperValue;
}
@property (readwrite) float wrapperValue;

+ (OMFloatWrapper *)wrapperWithValue:(float)aFloatValue;
- (BOOL) isEqual:(id)aValue;


@end
