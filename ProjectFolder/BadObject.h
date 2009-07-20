//
//  BadObject.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 19.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>


@interface BadObject : NSObject {

}
+ (BadObject *) badObject;
- (void) raise;
- (void) raise:(NSString *) anException;
- (void) dontRaise;
- (BOOL) isBad;
- (BOOL) isGood;

@end
