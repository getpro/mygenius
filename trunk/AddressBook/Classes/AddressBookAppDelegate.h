//
//  AddressBookAppDelegate.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <QuartzCore/QuartzCore.h>

#import "SwitchViewController.h"
#import "PublicData.h"
#import "ContactData.h"


typedef enum 
{
    TAB_ADDRESSBOOK,
    TAB_SYNC,
    TAB_MEMO,
    TAB_STATISTICS,
    TAB_MORE,
	TAB_Count
}TAB_ITEM;

ABAddressBookRef addressBook;

@interface AddressBookAppDelegate : NSObject <UIApplicationDelegate> 
{
    IBOutlet UIWindow * window;
	
	SwitchViewController *switchViewController;
	
	UITabBarController	 *tbController; //底部的5个TabBar
	
	AddressBookVC * m_pAddressBookVC;
	accountsVC    * m_pAccountsVC;
	memoVC        * m_pMemoVC;
	dateVC        * m_pDateVC;
	settingVC     * m_pSettingVC;
	
	//返回
	NSMutableArray * sceneID;
	BOOL back;
	
	NSMutableArray * m_arrContactsInfo; //通讯录数据
	NSMutableArray * m_arrMemoInfo;     //备忘录数据
	NSMutableArray * m_arrDateInfo;     //纪念日数据
	
	//FTP
	NSInteger               _networkingCount;
	
	//系统通讯录类
	ContactData    * m_pContactData;
	
	NSMutableArray * m_arrGroup;        //系统分组
}

@property (nonatomic, retain) IBOutlet UIWindow  *window;
@property (nonatomic, retain) UITabBarController *tbController;
@property (nonatomic, retain) NSMutableArray * sceneID;

@property (nonatomic, retain) NSMutableArray * m_arrContactsInfo;
@property (nonatomic, retain) NSMutableArray * m_arrMemoInfo;
@property (nonatomic, retain) NSMutableArray * m_arrDateInfo;
@property (nonatomic, retain) NSMutableArray * m_arrGroup;


@property (nonatomic, retain) ContactData    * m_pContactData;

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

