//
//  returnValueForMessageTest.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 16.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@class ObjectReturnsForMessage;


@interface ReturnValueForMessageTest : SenTestCase {
	ObjectReturnsForMessage * objThatReturnsHelloForMessage;
}

@end
