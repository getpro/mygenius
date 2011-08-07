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

#import "chat.h"

@interface chatRoomAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow   * window;
	
	chat       * m_pchat;
	
	CPhotonLib * m_PhotonLib;
	Listener   * l;
	NSTimer    * m_timer;
	
	bool bRun;
}

@property (nonatomic, retain) chat  * m_pchat;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) CPhotonLib * m_PhotonLib;

@property (nonatomic, retain) Listener   * l;

+ (chatRoomAppDelegate * ) getAppDelegate;

@end

