//
//  OMXIB.m
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 28.07.09.
//  Copyright 2009 ChocolateCode. All rights reserved.
//

#import "OMXIB.h"


@implementation OMXIB
@synthesize xmlDocument;

+ (OMXIB *) xibFromFile:(NSString *)fileName
{
	OMXIB   * xib  = [[OMXIB alloc] init];
	[xib autorelease];
	
	NSError * err  = nil;
	NSURL   * furl = [NSURL fileURLWithPath:fileName];
	
	NSXMLDocument * xml = [[NSXMLDocument alloc] initWithContentsOfURL:furl
															   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA)
																 error:&err];
	
	if (nil != err)
		[NSException raise:@"OMXMLError" format:@"There was an error while creating the xml document from xibFile: %@", furl];
	
	xib.xmlDocument = xml;
	
	return xib;
}

-(BOOL) hasSubview:(NSString *)className 
{
	NSError * err  = nil;
	//NSString * xpath = [NSString stringWithFormat:@".//object[key=\"NSSubviews\"]//object[class=\"%@\"]", className];
	NSString * xpath = @".//object[class='NSMutable']";
	NSArray * nodes = [[self.xmlDocument rootElement] nodesForXPath:xpath error:&err];
	if (nil != err)
		[NSException raise:@"OMXPATHError" format:@"There was an error while executing following XPATH query: %@", xpath];
	
	NSLog([[nodes objectAtIndex:0] description]);
	
	return ([nodes count] > 0);
}
@end
