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

- (void) raise;
- (void) raise:(NSString *) anException;

@end
