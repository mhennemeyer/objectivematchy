//
//  OMWrapper.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 06.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>


@interface OMWrapper : NSObject
{
	BOOL boolValue;
}

@property (readwrite) BOOL boolValue;

+ (id)wrapperWithBool:(BOOL)aBoolValue;

- (BOOL)isEqualTo:(BOOL)aBoolValue;
- (BOOL)isAOMWrapper;
@end
