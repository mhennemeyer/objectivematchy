//
//  XIBTest.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 28.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "XIBTest.h"

@implementation XIBTest

-(void) setUp
{
	errOpeningCocoaXib = nil;
	furlCocoa = [NSURL fileURLWithPath:@"CocoaXIB.xib"];
	xmlFromCocoaXib = [[NSXMLDocument alloc] initWithContentsOfURL:furlCocoa
															   options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA)
																 error:&errOpeningCocoaXib];
	errOpeningIPhoneXib = nil;
	furlIPhone = [NSURL fileURLWithPath:@"iPhoneXIB.xib"];
	xmlFromIPhoneXib = [[NSXMLDocument alloc] initWithContentsOfURL:furlIPhone
														   options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA)
															 error:&errOpeningIPhoneXib];
}

-(void) tearDown
{
	STAssertNil(errOpeningCocoaXib, @"err Error");
	STAssertNil(errOpeningIPhoneXib, @"err Error");
}

#pragma mark xmlDocument

- (void) testOMXIBCreatesXMLDocumentAndStoresItAsAPropertyCocoa
{
	OMXIB * xib = [OMXIB xibFromFile:@"CocoaXIB.xib"];
	[[xib should] returnValue:xmlFromCocoaXib forMessage:@"xmlDocument" withArguments:nil];
}

- (void) testOMXIBCreatesXMLDocumentAndStoresItAsAPropertyIPhone
{
	OMXIB * xib = [OMXIB xibFromFile:@"iPhoneXIB.xib"];
	[[xib should] returnValue:xmlFromIPhoneXib forMessage:@"xmlDocument" withArguments:nil];
}

#pragma mark -

#pragma mark hasSubview:


- (void) testOMXIBhasSubviewLabelCocoa
{
	OMXIB * xib = [OMXIB xibFromFile:@"CocoaXIB.xib"];
	//[[xib should] respondToSelector:@selector(hasSubview:) withObject:@"NSButton" andReturn:OM_YES];
}




@end
