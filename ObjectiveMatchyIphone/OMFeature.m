//
//  OMFeature.m
//  ObjectiveMatchyIphone
//
//  Created by Matthias Hennemeyer on 11.08.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//

#import "OMFeature.h"


@implementation OMFeature

-(void) setUp
{
	
}




-(void) Given_i_just_opened_the_app
{
	NSLog(@"\nHello!!!");
}

-(void) When_i_push_the____Button:(NSString *)button
{
	NSLog(button);
}

-(void) Then_the____Label_should_show___:(NSString *)labelName arg:(NSString *)labelValue
{
	NSLog(labelName);
}

@end
