//
//  Matcher-MatcherMethods.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Matcher.h"

@interface Matcher (MatcherMethods)

- (id) eql:(id)anExpected;
- (id) respondTo:(SEL)selector;
- (id) haveKey:(NSString *)aKey;
- (id) haveKey:(NSString *)aKey withValue:(id)value;

@end
