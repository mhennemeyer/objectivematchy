//
//  ___PROJECTNAMEASIDENTIFIER___AppDelegate.h
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ___PROJECTNAMEASIDENTIFIER___ViewController;

@interface ___PROJECTNAMEASIDENTIFIER___AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ___PROJECTNAMEASIDENTIFIER___ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ___PROJECTNAMEASIDENTIFIER___ViewController *viewController;

@end

