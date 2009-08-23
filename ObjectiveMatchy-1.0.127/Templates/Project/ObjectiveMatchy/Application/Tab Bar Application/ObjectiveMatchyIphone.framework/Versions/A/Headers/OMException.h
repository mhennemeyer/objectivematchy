//
//  OMException.h
//  ObjectiveMatchyIphone
//
//  Created by Matthias Hennemeyer on 04.08.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMException : NSException {
}

+ (OMException *) oMfailure:(NSString *)filename 
					 atLine:(int)lineNumber 
			withDescription:(NSString *)failureMessage;
- (NSString *) filename;
- (NSNumber *) lineNumber;

@end

extern NSString * const OMFilenameKey;
extern NSString * const OMLineNumberKey;
extern NSString * const OMFailureMessageKey;
extern NSString * const OMFailure;
