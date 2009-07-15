//
//  ObjectiveMatchyMacros.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#pragma mark Expectations

#define should \
addPositiveExpectation:[NSString stringWithCString:__FILE__] line:__LINE__

#define shouldNot \
addNegativeExpectation:[NSString stringWithCString:__FILE__] line:__LINE__

#pragma mark -

#pragma mark Wrapper

#define OM_YES \
[OMWrapper wrapperWithBool:YES]

#define OM_NO \
[OMWrapper wrapperWithBool:NO]

#pragma mark Macros for testCase

#define testCase(TESTCASENAME,DECLARE, IMPL) \
@interface      TESTCASENAME ## Test : SenTestCase { DECLARE ; } @end \
@implementation TESTCASENAME ## Test                 IMPL      @end 

#define test(TESTNAME, IMPL) - (void) test ## TESTNAME { IMPL ; }
#define setUp(IMPL)          - (void) setUp    { IMPL ; }
#define tearDown(IMPL)       - (void) tearDown { IMPL ; }
#define OMDeclarations

#pragma mark -

//#pragma mark  Macros for BDD
//
//// todo LINK ObjectiveMatchy Framework
////todo gensym test case names
//#define SUTtestCase(SUT, BEFORE, AFTER, IMPL) \
//@interface      MYTest : SenTestCase { id sut; } @end \
//@implementation MYTest \
//- (void) setUp { sut = SUT; BEFORE } \
//- (void) tearDown { AFTER } \
//IMPL @end 
//
////todo gensym test names
//#define itShould(MATCHER, BEFORE)    - (void) test_ __LINE__ { BEFORE [[sut should]    MATCHER]; }
//#define itShouldNot(MATCHER, BEFORE) - (void) testTWO { BEFORE [[sut shouldNot] MATCHER]; }
//
//
//#define OMAfter
//#define OMBefore
//
//#pragma mark -



