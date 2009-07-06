//
//  ObjectiveMatchyMacros.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//

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
@interface      TESTCASENAME ## Test : SenTestCase { DECLARE } @end \
@implementation TESTCASENAME ## Test                 IMPL      @end 

#define test(TESTNAME, IMPL) - (void) test ## TESTNAME { IMPL }
#define setUp(IMPL)         - (void) setUp    { IMPL }
#define tearDown(IMPL)          - (void) tearDown { IMPL }
#define DECLARATIONS

#pragma mark -

#pragma mark  Macros for BDD

// todo LINK ObjectiveMatchy Framework
//todo gensym test case names
#define describe(SUT, BEFORE, AFTER, IMPL) \
@interface      MYTest : SenTestCase { id sut; } @end \
@implementation MYTest \
- (void) setUp { sut = SUT; BEFORE } \
- (void) tearDown { AFTER } \
IMPL @end 

//todo gensym test names
#define itShould(MATCHER)    - (void) testONE { [[sut should]    MATCHER]; }
#define itShouldNot(MATCHER) - (void) testTWO { [[sut shouldNot] MATCHER]; }


#define AFTER
#define BEFORE

#pragma mark -



