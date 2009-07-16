//
//  OMSimpleInvocation-NSObject.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>


@interface NSObject (OMSimpleInvocation)

- (NSInvocation *) simpleInvocationFromArray:(NSArray *)anArray;
@end
