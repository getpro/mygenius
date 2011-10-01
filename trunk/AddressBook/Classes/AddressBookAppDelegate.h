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

#import "PublicData.h"
#import "ContactData.h"

#import "AddressBookVC.h"
#import "syncVC.h"
#import "memoVC.h"
#import "statisticsVC.h"
#import "moreVC.h"

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
	
	UITabBarController	 *tbController; //底部的5个TabBar
	
	AddressBookVC * m_pAddressBookVC;
	syncVC        * m_psyncVC;
	memoVC        * m_pMemoVC;
	statisticsVC  * m_pstatisticsVC;
	moreVC        * m_pmoreVC;
	
	NSMutableArray * m_arrMemoInfo;     //备忘录数据
	NSMutableArray * m_arrDateInfo;     //纪念日数据
	
	NSMutableArray * m_arrCustomTag;    //自定义标签
	
	//FTP
	NSInteger        _networkingCount;
	
	//系统通讯录类
	NSMutableArray * m_arrContactData;  //分组联系人 0:全部 1:m_arrGroup（0）...
	//ContactData    * m_pContactData;
	
	NSMutableArray * m_arrGroup;        //系统分组
}

@property (nonatomic, retain) IBOutlet UIWindow  *window;
@property (nonatomic, retain) UITabBarController *tbController;

@property (nonatomic, retain) NSMutableArray * m_arrMemoInfo;
@property (nonatomic, retain) NSMutableArray * m_arrDateInfo;
@property (nonatomic, retain) NSMutableArray * m_arrGroup;
@property (nonatomic, retain) NSMutableArray * m_arrCustomTag;
@property (nonatomic, retain) NSMutableArray * m_arrContactData;

//@property (nonatomic, retain) ContactData    * m_pContactData;

@property (nonatomic, assign) NSInteger        networkingCount;


/*
 *
 * Makes an intl.uploadNativeStrings request.
 * @param NSDictionary * params parameters for the API call
*/
+ (AddressBookAppDelegate * ) getAppDelegate;

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix;
- (NSURL *)smartURLForString:(NSString *)str;
- (void)didStartNetworking;
- (void)didStopNetworking;

@end

