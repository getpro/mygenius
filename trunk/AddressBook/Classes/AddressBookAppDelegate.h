//
//  AddressBookAppDelegate.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchViewController.h"

@interface AddressBookAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow * window;
	
	SwitchViewController *switchViewController;
	
	//返回
	NSMutableArray * sceneID;
	BOOL back;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property BOOL back;

@property (nonatomic, retain) NSMutableArray * sceneID;




+ (AddressBookAppDelegate * ) getAppDelegate;

- (void) backScene;

- (void) GetSysAddressBook;

@end

