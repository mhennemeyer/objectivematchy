//
//  OMFeature.h
//  ObjectiveMatchyIphone
//
//  Created by Matthias Hennemeyer on 11.08.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.


#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "ObjectiveMatchy.h"

@interface OMFeature : SenTestCase {
}

-(void) Given_i_just_opened_the_app;

-(void) When_i_push_the____Button:(NSString *)button;

-(void) Then_the____Label_should_show___:(NSString *)labelName arg:(NSString *)labelValue;

-(void) Then_everything_should_be_fine;

@end
