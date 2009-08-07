//
//  TestCaseMacroTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 13.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "ObjectiveMatchy.h"
#import "ObjectWithKey.h"
#import <SenTestingKit/SenTestingKit.h>

testCase(HaveKeyWithMacro, ObjectWithKey * sut ,
		 setUp(sut = [[ObjectWithKey alloc] init])
		 tearDown([sut release]) 
		 test(HasKey,
			  [sut setValue:@"someValue"  forKey:@"aKey"];
			  [[sut should] haveKey:@"aKey" withValue:@"someValue"]))


testCase(HaveKeyWithMacro2, ObjectWithKey * sut ,
		 setUp(sut = [[ObjectWithKey alloc] init])
		 tearDown([sut release]) 
		 test(HasKey,
			  [sut setValue:@"someValue"  forKey:@"aKey"];
			  [[sut should] haveKey:@"aKey" withValue:@"someValue"]))