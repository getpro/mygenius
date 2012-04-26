//
//  YeungAppDelegate.h
//  Yeung
//
//  Created by Peteo on 12-4-26.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface YeungAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
