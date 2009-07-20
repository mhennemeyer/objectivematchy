//
//  OM-NSException.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 13.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Cocoa/Cocoa.h>


@interface NSException (OM)

+ (NSException *) oMfailure:(NSString *)filename 
                         atLine:(int)lineNumber 
                withDescription:(NSString *)failureMessage;
- (NSString *) filename;
- (NSNumber *) lineNumber;

@end

extern NSString * const OMFilenameKey;
extern NSString * const OMLineNumberKey;
extern NSString * const OMFailureMessageKey;
extern NSString * const OMFailure;