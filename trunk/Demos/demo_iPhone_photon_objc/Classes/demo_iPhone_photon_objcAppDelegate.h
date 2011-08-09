//
//  demo_iPhone_photon_objcAppDelegate.h
//  demo_iPhone_photon_objc
//
//  Created by Pedro Galystyan on 9/3/08.
//  Copyright home 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotonDemo.h"
#import "demo_iPhone_Photon_objC.h"
#import "iTestTextView.h"

@class demo_iPhone_photon_objcViewController;

@interface demo_iPhone_photon_objcAppDelegate : NSObject <UIApplicationDelegate>
{
	IBOutlet UIWindow* window;
	IBOutlet demo_iPhone_photon_objcViewController *viewController;
	CPhotonLib* m_PhotonLib;
	Listener* l;
	iTestTextView *textView;
	bool bRun;
	NSTimer* m_timer;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) demo_iPhone_photon_objcViewController *viewController;

@end