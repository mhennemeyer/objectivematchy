//
//  OMExpectations-NSObject.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>
#import "ObjectiveMatchyMacros.h"
#import "OMWrapper.h"
/*!
 Create a Matcher Object from any NSObject.
 */
@interface NSObject (OMExpectations)

- (id) addPositiveExpectation:(NSString *)file line:(int) line;
- (id) addNegativeExpectation:(NSString *)file line:(int) line;

@end
