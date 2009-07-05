//
//  Matcher.h
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SenTestingKit/SenTestingKit.h>



@interface Matcher : NSObject {
	id   actual;
	id   expected;
	BOOL isPositive;
	BOOL matches;
	NSString * positiveFailureMessage;
	NSString * negativeFailureMessage;
	NSString * filename;
	int linenumber;
}

- (id) initWithActual:(id)anActual 
		andIsPositive:(BOOL)aIsPositive 
			 filename:(NSString *)file 
		   linenumber:(int)line;

- (BOOL) positiveFailure;
- (BOOL) negativeFailure;
- (NSException *) positiveException;
- (NSException *) negativeException;
- (void) handleExpectation;

@property (readwrite, retain) id         actual;
@property (readwrite, retain) id         expected;
@property (readonly)          BOOL       isPositive;
@property (readwrite)          int        linenumber;
@property (readwrite)         BOOL       matches;
@property (readwrite, copy)   NSString * positiveFailureMessage;
@property (readwrite, copy)   NSString * negativeFailureMessage;
@property (readwrite, copy)   NSString * filename;

@end
