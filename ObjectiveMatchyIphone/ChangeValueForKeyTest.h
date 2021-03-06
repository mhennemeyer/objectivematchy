//
//  ChangeValueForKeyTest.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 20.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@class ObjectWithKey;

@interface ChangeValueForKeyTest : SenTestCase {
	ObjectWithKey * obj;
	ObjectWithKey * otherObj;
}

@end
