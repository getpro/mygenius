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
	
	NSMutableArray * m_arrContactsInfo; //通讯录数据
	NSMutableArray * m_arrMemoInfo;     //备忘录数据
	NSMutableArray * m_arrDateInfo;     //纪念日数据
	
	//FTP
	NSInteger               _networkingCount;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableArray * sceneID;

@property (nonatomic, retain) NSMutableArray * m_arrContactsInfo;
@property (nonatomic, retain) NSMutableArray * m_arrMemoInfo;
@property (nonatomic, retain) NSMutableArray * m_arrDateInfo;

@property (nonatomic, assign) NSInteger        networkingCount;

@property BOOL back;

/*
 *
 * Makes an intl.uploadNativeStrings request.
 * @param NSDictionary * params parameters for the API call
*/
+ (AddressBookAppDelegate * ) getAppDelegate;

- (void) backScene;

- (void) GetSysAddressBook;

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix;
- (NSURL *)smartURLForString:(NSString *)str;
- (void)didStartNetworking;
- (void)didStopNetworking;

@end

