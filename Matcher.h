//
//  Matcher.h
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>



@interface Matcher : NSObject {
	id   actual;
	BOOL isPositive;
	BOOL matches;
	NSString * positiveFailureMessage;
	NSString * negativeFailureMessage;
}

- (id) initWithActual:(id)anActual 
		andIsPositive:(BOOL)aIsPositive;

- (BOOL) positiveFailure;
- (BOOL) negativeFailure;

@property (readwrite, retain) id         actual;
@property (readonly)          BOOL       isPositive;
@property (readwrite)         BOOL       matches;
@property (readwrite, copy)   NSString * positiveFailureMessage;
@property (readwrite, copy)   NSString * negativeFailureMessage;

@end
