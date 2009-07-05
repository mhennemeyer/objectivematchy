//
//  NSObject-Expectations.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ObjectiveMatchyMacros.h"

/*!
 Create a Matcher Object from any NSObject.
 */
@interface NSObject (Expectations)

- (id) addPositiveExpectation:(NSString *)file line:(int) line;
- (id) addNegativeExpectation:(NSString *)file line:(int) line;

@end
