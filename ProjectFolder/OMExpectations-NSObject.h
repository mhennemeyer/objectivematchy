//
//  OMExpectations-NSObject.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Foundation/Foundation.h>

@class OMMatcher;
@interface NSObject (OMExpectations)

- (OMMatcher *) addPositiveExpectation:(NSString *)file line:(int) line;
- (OMMatcher *) addNegativeExpectation:(NSString *)file line:(int) line;

@end
