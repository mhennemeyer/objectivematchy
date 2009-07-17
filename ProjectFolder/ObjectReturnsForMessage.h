//
//  ObjectReturnsForMessage.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 17.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>


@interface ObjectReturnsForMessage : NSObject {

}

- (NSString *) message;
- (id) message:(id) andArg;
- (id) message:(id) andArg andOtherArg:(id) otherArg;

@end
