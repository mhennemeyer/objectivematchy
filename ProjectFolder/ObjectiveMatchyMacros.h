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
[OMBoolWrapper wrapperWithValue:YES]

#define OM_NO \
[OMBoolWrapper wrapperWithValue:NO]

#define OM_INT(value) \
[OMIntWrapper wrapperWithValue:value]

#define OM_SEL(sel) \
[OMSELWrapper wrapperWithValue:sel]

#pragma mark -

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

#pragma mark OM_EXTRACT_DICT_FROM_VARARGS

#define OM_EXTRACT_DICT_FROM_VARARGS(aDict, first) \
NSMutableArray * om_arr = [NSMutableArray arrayWithObject:first]; \
id om_arg; \
va_list om_argumentList; \
va_start(om_argumentList, first); \
while (om_arg = va_arg(om_argumentList, id)) { \
	[om_arr addObject: om_arg]; \
	va_end(om_argumentList); \
} \
NSMutableString * om_selectorString = [NSMutableString string]; \
NSMutableArray * om_arguments = [NSMutableArray array]; \
for (int i = 0; i < [om_arr count]; i++) { \
	if ((i % 2) == 0) { \
		[om_selectorString appendString:[om_arr objectAtIndex:i]]; \
	} \
	else { \
		[om_arguments addObject:[om_arr objectAtIndex:i]]; \
	} \
} \
[aDict setValue:om_selectorString forKey:@"selectorString"]; \
[aDict setValue:om_arguments forKey:@"arguments"]; 





