//
//  chatRoomAppDelegate.h
//  chatRoom
//
//  Created by Peteo on 11-8-5.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhotonDemo.h"
#import "PhotonListener.h"

@interface chatRoomAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow   * window;
	
	CPhotonLib * m_PhotonLib;
	Listener   * l;
	NSTimer    * m_timer;
	
	bool bRun;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

