//
//  ObjectWithKey.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//  Released under the terms of the MIT Licence.

#import <Foundation/Foundation.h>


@interface ObjectWithKey : NSObject {
	id aKey;
	int aKeyWithIntValue;
}

+ (ObjectWithKey *) object;

- (int) integerValueOne;

- (void) setValue:(id)aValue forKey:(NSString *)key ofObject:(id)anObject;

@end
