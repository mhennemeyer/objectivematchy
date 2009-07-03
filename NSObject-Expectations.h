//
//  NSObject-Expectations.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 Create a Matcher Object from any NSObject by 
 sending it a should (positive Expectation) or
 shouldNot (negative Expectation) Message.
 */
@interface NSObject (Expectations)

- (id) should;
- (id) shouldNot;

@end
