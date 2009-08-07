//
//  OMSimpleInvocation-NSObject.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Foundation/Foundation.h>


@interface NSObject (OMSimpleInvocation)

- (NSInvocation *) simpleInvocationFromSelector:(SEL)aSelector withArguments:(NSArray *)arguments;
- (id) simpleInvoke:(SEL)aSelector withArguments:(NSArray *)arguments;
@end
