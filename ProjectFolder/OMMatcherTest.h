//
//  OMMatcherTest.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 30.06.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@class OMMatcher;

@interface OMMatcherTest : SenTestCase {
	id actual;
	OMMatcher * positiveMatcherWithActual;
	OMMatcher * negativeMatcherWithActual;
	int linenumber;
	NSString * filename;
}

@end
