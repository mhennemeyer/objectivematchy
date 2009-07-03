//
//  Matcher-Eql.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 02.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Matcher.h"

@interface Matcher (Eql)

- (BOOL) eql:(id)expected;

@end
