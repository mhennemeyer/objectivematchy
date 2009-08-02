//
//  OMXIB.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 28.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OMXIB : NSObject {
	NSXMLDocument * xmlDocument;
}

@property (retain) NSXMLDocument * xmlDocument;

+ (OMXIB *) xibFromFile:(NSString *)name;

-(BOOL) hasSubview:(NSString *)className;

@end
