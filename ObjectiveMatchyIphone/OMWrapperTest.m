//
//  OMWrapperTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 06.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.


#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>


@interface OMWrapperTest : SenTestCase {
}

@end


@implementation OMWrapperTest

- (void) setUp
{
}

#pragma mark OM_YES

- (void) testOM_YES_MacroInstantiatesOMBoolWrapper
{
	STAssertTrue([OM_YES isMemberOfClass:[OMBoolWrapper class]], @"");
}

- (void) testOM_YESEqualsOM_YES
{
	STAssertTrue([OM_YES isEqual:OM_YES], @"OM_YES should equal OM_YES (with isEqual:)");
}

- (void) testOM_YESNotEqualsOM_NO
{
	STAssertFalse([OM_YES isEqual:OM_NO], @"");
}

- (void) testOM_YESDescribesItselfAsStringYES{
	STAssertEqualObjects([OM_YES description], @"YES", @"");
}

#pragma mark -

#pragma mark OM_NO

- (void) testOM_NO_MacroInstantiatesOMBoolWrapper
{
	STAssertTrue([OM_NO isMemberOfClass:[OMBoolWrapper class]], @"");
}

- (void) testOM_NOEqualsOM_no
{
	STAssertTrue([OM_NO isEqual:OM_NO], @"OM_NO should equal OM_NO (with isEqual:)");
}

- (void) testOM_NODescribesItselfAsStringNO{
	STAssertEqualObjects([OM_NO description], @"NO", @"");
}

#pragma mark -

#pragma mark intWrapper

- (void) testOM_INT_MacroInstantiatesOMIntWrapper
{
	[[OM_INT(1) should] be:@"MemberOfClass:" with:[OMIntWrapper class]];
}

- (void) testOM_INTEqualsOM_INT_IfSameValues
{
	[[OM_INT(1) should] be:@"Equal:"  with:OM_INT(1)];
}

- (void) testOM_INTNotEqualsOM_INT_IfDifferentValues
{
	[[OM_INT(1) shouldNot] be:@"Equal:" with:OM_INT(2)];
}

- (void) testOM_INTOneDescribesItselfAsString1{
	[[[OM_INT(1) description] should]  eql:@"1"];
}

- (void) testOM_INT132DescribesItselfAsString123{
	[[[OM_INT(123) description] should]  eql:@"123"];
}
#pragma mark -

#pragma mark floatWrapper

- (void) testOM_FLOAT_MacroInstantiatesOMFloatWrapper
{
	[[OM_FLOAT(1.5) should] be:@"MemberOfClass:" with:[OMFloatWrapper class]];
}

- (void) testOM_FLOATEqualsOM_FLOAT_IfSameValues
{
	[[OM_FLOAT(1.5) should] be:@"Equal:" with:OM_FLOAT(1.5)];
}

- (void) testOM_FLOATDontEqualsOM_FLOAT_IfDifferentValues
{
	[[OM_FLOAT(1.5) shouldNot] be:@"Equal:" with:OM_FLOAT(1.6)];
}
- (void) testOM_FLOATOnePointFiveDescribesItselfAsString1DotFive{
	[[[OM_FLOAT(1.5) description] should]  eql:@"1.500000"];
}

- (void) testOM_FLOAT1Point234567DescribesItselfAsString1dot234567{
	[[[OM_FLOAT(1.234567) description] should]  eql:@"1.234567"];
}
#pragma mark -

#pragma mark selWrapper

- (void) testOM_SEL_MacroInstantiatesOMSELWrapper
{
	
	STAssertTrue([OM_SEL(@selector(isEqualTo:)) isMemberOfClass:[OMSELWrapper class]], @"");
}

- (void) testOM_SEL_EqualsOM_SEL_IfSameValues
{
	STAssertTrue([OM_SEL(@selector(isEqual:)) isEqual:OM_SEL(@selector(isEqual:))], @"");
}

- (void) testOM_SELNotEqualsOM_SEL_IfDifferentValues
{
	STAssertFalse([OM_SEL(@selector(isEqual:)) isEqual:OM_SEL(@selector(copy))], @"");
}

- (void) testOM_SEL_For_isEqualTo_OneDescribesItselfAsStringisEqualTo{
	[[[OM_SEL(@selector(isEqual:)) description] should]  eql:@"isEqual:"];
}

- (void) testOM_SEL_For_isEqualTo_andBlah_OneDescribesItselfAsStringisEqualTo_andBlah{
	[[[OM_SEL(@selector(isEqualTo:andBlah:)) description] should]  eql:@"isEqualTo:andBlah:"];
}

#pragma mark -

@end
