//
//  OMMatcher-OMMatcherMethods.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>
#import "OMMatcher.h"

@interface OMMatcher (OMMatcherMethods)

/*!
    @method     eql:
    @abstract   Tests for equality.
    @discussion Tests for equality by sending 'isEqualTo:' to the Object under test with the parameter applied to eql: as the parameter.
    @param      anExpected The Object that The Object Under Test should be equal to.
    @result     anExpected 
*/
- (id) eql:(id)anExpected;
- (id) match:(NSString *)aRegEx;
- (id) containObject:(id)anExpected;
- (id) respondToSelector:(SEL)selector;
- (id) respondToSelector:(SEL)selector andReturn:(id)expectedValue;
- (id) respondToSelector:(SEL)selector withObject:(id)argument andReturn:(id)expectedValue;
- (id) haveKey:(NSString *)aKey;
- (id) haveKey:(NSString *)aKey withValue:(id)value;
- (id) returnValue:(id)expectedValue forMessage:(id) aMessage, ...;
- (id) returnValue:(id)expectedValue forMessage:(NSString *) aMessageString withArguments:(NSArray *) arguments;
- (id) throw:(NSString *)expectedException forMessage:(id) aMessage, ...;
- (id) throw:(NSString *)expectedException forMessage:(NSString *) aMessageString withArguments:(NSArray *) arguments;
- (id) be:(NSString *)omitIs;
- (id) be:(NSString *)omitIs with:(id)anObject;
- (id) changeValueForKey:(NSString *)aKey forMessage:(id) aMessage, ...;
- (id) changeValueForKey:(NSString *)aKey forMessage:(NSString *)messageString withArguments:(NSArray *)arguments;
- (id) changeValueForKey:(NSString *)aKey from:(id)fromValue to:(id)toValue forMessage:(NSString *)messageString withArguments:(NSArray *)arguments;
- (id) changeValueForKey:(NSString *)aKey ofObject:(id)anObject forMessage:(NSString *)messageString withArguments:(NSArray *)arguments;
- (id) changeValueForKey:(NSString *)aKey ofObject:(id)anObject from:(id)fromValue to:(id)toValue forMessage:(NSString *)messageString withArguments:(NSArray *)arguments;


@end
