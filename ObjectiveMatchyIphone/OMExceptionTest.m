//
//  OMExceptionTest.m
//  ObjectiveMatchyIphone
//
//  Created by Matthias Hennemeyer on 04.08.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//
#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>

@interface OMExceptionTest : SenTestCase {
	OMException * omException;
}

@end


@implementation OMExceptionTest

- (void) setUp
{
	omException = [OMException oMfailure:@"OMExceptionTest.m" atLine:20 withDescription:@"description"];
}


- (void) testOMExceptionKnowsLineNumber
{
	[[omException should] returnValue:[NSNumber numberWithInt:20] 
						   forMessage:@"lineNumber" 
						withArguments:nil];
}

- (void) testOMExceptionKnowsFilename
{
	[[omException should] returnValue:@"OMExceptionTest.m" 
						   forMessage:@"filename" 
						withArguments:nil];
}



@end
