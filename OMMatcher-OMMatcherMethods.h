//
//  OMMatcher-OMMatcherMethods.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OMMatcher.h"

@interface OMMatcher (OMMatcherMethods)

- (id) eql:(id)anExpected;
- (id) respondToSelector:(SEL)selector;
- (id) respondToSelector:(SEL)selector andReturn:(id)expectedValue;
- (id) respondToSelector:(SEL)selector withObject:(id)argument andReturn:(id)expectedValue;
- (id) haveKey:(NSString *)aKey;
- (id) haveKey:(NSString *)aKey withValue:(id)value;

@end
