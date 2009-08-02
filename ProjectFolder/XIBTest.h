//
//  XIBTest.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 28.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "ObjectiveMatchy.h"
#import <SenTestingKit/SenTestingKit.h>


@interface XIBTest : SenTestCase {
	NSError * errOpeningCocoaXib;
	NSURL * furlCocoa;
	NSXMLDocument * xmlFromCocoaXib;
	NSError * errOpeningIPhoneXib;
	NSURL * furlIPhone;
	NSXMLDocument * xmlFromIPhoneXib;
}

@end
