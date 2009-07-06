//
//  ObjectiveMatchyMacros.h
//  ObjectiveMatchy
//
//  Created by Matthias Hennemeyer on 05.07.09.
//  Copyright 2009 Matthias Hennemeyer. All rights reserved.
//

#pragma mark Expectations

#define should \
addPositiveExpectation:[NSString stringWithCString:__FILE__] line:__LINE__

#define shouldNot \
addNegativeExpectation:[NSString stringWithCString:__FILE__] line:__LINE__

#pragma mark -

#pragma mark Wrapper

#define OM_YES \
[OMWrapper wrapperWithBool:YES]

#define OM_NO \
[OMWrapper wrapperWithBool:NO]

