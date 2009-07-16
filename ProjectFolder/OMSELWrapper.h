//
//  OMSELWrapper.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>
#import "OMWrapper.h"

@interface OMSELWrapper : OMWrapper
{
	SEL wrapperValue;
}
@property (readwrite) SEL wrapperValue;
+ (id) wrapperWithValue:(SEL)aSELValue;
- (BOOL) isEqualTo:(id)aValue;
- (NSString *) description;
@end
