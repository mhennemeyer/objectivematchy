//
//  MatcherTest.h
//  ObjectiveMatchy
//
//  Created by muster muster on 30.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class Matcher;


@interface MatcherTest : SenTestCase {
	id actual;
	Matcher * positiveMatcherWithActual;
	Matcher * negativeMatcherWithActual;
	int linenumber;
	NSString * filename;
}

@end
