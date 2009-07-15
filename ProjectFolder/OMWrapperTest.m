//
//  OMWrapperTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 06.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import "OMWrapperTest.h"


@implementation OMWrapperTest

- (void) setUp
{
	yesWrapper = [OMWrapper wrapperWithBool:YES];
	noWrapper  = [OMWrapper wrapperWithBool:NO];
}

#pragma mark yesWrapper

- (void) testOMWrapperYESMacroInstantiatesOMWrapper
{
	STAssertTrue([OM_YES isMemberOfClass:[OMWrapper class]], @"");
}

- (void) testOMWrapperWithBoolYESEqualsYES
{
	STAssertTrue([yesWrapper isEqualTo:YES], @"yesWrapper should equal YES (with isEqualTo:)");
}

#pragma mark -

#pragma mark noWrapper

- (void) testOMWrapperNOMacroInstantiatesOMWrapper
{
	STAssertTrue([OM_NO isMemberOfClass:[OMWrapper class]], @"");
}

- (void) testOMWrapperWithBoolNOEqualsYES
{
	STAssertTrue([noWrapper isEqualTo:NO], @"noWrapper should equal NO (with isEqualTo:)");
}

#pragma mark -

@end
