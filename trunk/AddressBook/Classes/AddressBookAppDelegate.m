//
//  AddressBookAppDelegate.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBookAppDelegate.h"

#import "ABContactsHelper.h"

@implementation AddressBookAppDelegate

@synthesize tbController;
@synthesize window;

@synthesize m_arrDateInfo;
@synthesize m_arrMemoInfo;
@synthesize m_arrGroup;
@synthesize m_arrCustomTag;
@synthesize m_pContactData;

@synthesize networkingCount = _networkingCount;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
    // Override point for customization after application launch.
	
	if(addressBook == nil)
		addressBook = ABAddressBookCreate();
	
	m_pContactData = [[ContactData alloc] init];
	
	[DBConnection getSharedDatabase];
	
	m_arrDateInfo       = [[NSMutableArray alloc] initWithCapacity:10];
	m_arrMemoInfo       = [[NSMutableArray alloc] initWithCapacity:10];
	m_arrGroup          = [[NSMutableArray alloc] initWithCapacity:10];
	m_arrCustomTag      = [[NSMutableArray alloc] initWithCapacity:10];
	
	//test
	[m_arrCustomTag addObject:@"自定义1"];
	[m_arrCustomTag addObject:@"自定义2"];
	[m_arrCustomTag addObject:@"自定义3"];

	//Group
	NSArray * groups = [ABContactsHelper groups];
	//NSLog(@"groups[%d]",[groups count]);
	
	for(ABGroup * pGroup in groups)
	{
		[m_arrGroup addObject:pGroup];
		NSLog(@"groups[%@]",pGroup.name);
	}
	
	//第一次运行程序
	if([DataStore Get_Copy_Addressbook] == 0)
	{
		NSLog(@"Copy_Addressbook==0");
		//修改Copy_Addressbook = 1
		[DataStore Set_Copy_Addressbook :1];
		
		[DataStore Set_First_Use];
	}
	
	//系统通讯录的数据入库
	[DBConnection beginTransaction];
	
	for(ABContact * pABContact in m_pContactData.contactsArray)
	{
		ABRecordRef pRecord    = pABContact.record;
		ABRecordID  pRecordID  = ABRecordGetRecordID(pRecord);
		
		//判断RecordID是否已在库中
		if([DataStore RecordIDIsExist:pRecordID])
		{
			//在库中
			//检测是否被修改
			NSLog(@"IN[%d]",pRecordID);
			if([DataStore RecordIDIsModify:pRecord])
			{
				//[DataStore insertContactsBaseInfo:pRecord];
			}
		}
		else
		{
			//不在库中,存入库中
			NSLog(@"OUT[%d]",pRecordID);
			
			[DataStore insertContactsBaseInfo:pRecord];
			
		}
		
	}
	
	[DBConnection commitTransaction];
	
	
	//通讯录
	m_pAddressBookVC = [[AddressBookVC alloc] init];
									  
	UIImage* AddressBookImage = [UIImage imageNamed:@"bottom_icon_contacts.png"];
	UITabBarItem * AddressBookItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:AddressBookImage tag:0];
	m_pAddressBookVC.tabBarItem = AddressBookItem;
	[AddressBookItem release];
	
	UINavigationController * AddressBookNavController = [[UINavigationController alloc] initWithRootViewController:m_pAddressBookVC];
	
	//同步备份
	m_psyncVC = [[syncVC alloc] init];
	
	UIImage* AccountsImage = [UIImage imageNamed:@"bottom_icon_sync.png"];
	UITabBarItem * AccountsItem = [[UITabBarItem alloc] initWithTitle:@"同步备份" image:AccountsImage tag:0];
	m_psyncVC.tabBarItem = AccountsItem;
	[AccountsItem release];
	
	UINavigationController * syncNavController = [[UINavigationController alloc] initWithRootViewController:m_psyncVC];
	
	//备忘录
	m_pMemoVC = [[memoVC alloc] init];
	
	UIImage* MemoImage = [UIImage imageNamed:@"bottom_icon_memo.png"];
	UITabBarItem * MemoItem = [[UITabBarItem alloc] initWithTitle:@"备忘录" image:MemoImage tag:0];
	m_pMemoVC.tabBarItem = MemoItem;
	m_pMemoVC.tabBarItem.badgeValue = @"2";
	[MemoItem release];
	
	UINavigationController * MemoNavController = [[UINavigationController alloc] initWithRootViewController:m_pMemoVC];
	
	//统计
	m_pstatisticsVC = [[statisticsVC alloc] init];
	
	UIImage* DateImage = [UIImage imageNamed:@"bottom_icon_statistics.png.png"];
	UITabBarItem * DateBookItem = [[UITabBarItem alloc] initWithTitle:@"日程统计" image:DateImage tag:0];
	m_pstatisticsVC.tabBarItem = DateBookItem;
	[DateBookItem release];
	
	UINavigationController * statisticsNavController = [[UINavigationController alloc] initWithRootViewController:m_pstatisticsVC];

	//更多
	m_pmoreVC = [[moreVC alloc] init];
	
	UIImage* SettingImage = [UIImage imageNamed:@"bottom_icon_more.png"];
	UITabBarItem * SettingItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:SettingImage tag:0];
	m_pmoreVC.tabBarItem = SettingItem;
	[SettingItem release];
	
	UINavigationController * moreNavController = [[UINavigationController alloc] initWithRootViewController:m_pmoreVC];
	
	tbController = [[UITabBarController alloc] init];
	tbController.viewControllers = [NSArray arrayWithObjects:AddressBookNavController,syncNavController,MemoNavController,statisticsNavController,moreNavController,nil];
	tbController.selectedIndex = TAB_ADDRESSBOOK;
	
	[AddressBookNavController release];
	[syncNavController		  release];
	[MemoNavController		  release];
	[statisticsNavController  release];
	[moreNavController        release];
	
	
	[self.window addSubview:tbController.view];
	
	//[self.window addSubview:switchViewController.view];
    
    [self.window makeKeyAndVisible];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
	[DBConnection closeDatabase];
	
	[m_pContactData       release];
	
	[m_pAddressBookVC	  release];
	[m_psyncVC			  release];
	[m_pMemoVC			  release];
	[m_pstatisticsVC	  release];
	[m_pmoreVC	    	  release];
	
	[m_arrDateInfo		  release];
	[m_arrMemoInfo		  release];
	[m_arrGroup           release];
	[m_arrCustomTag       release];
	
	[tbController	      release];
    [window				  release];
	
    [super dealloc];
}

+(AddressBookAppDelegate*)getAppDelegate
{
    return (AddressBookAppDelegate*)[UIApplication sharedApplication].delegate;
}

- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
	
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"ftp://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"ftp"  options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

- (void)didStartNetworking
{
    self.networkingCount += 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didStopNetworking
{
    assert(self.networkingCount > 0);
    self.networkingCount -= 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = (self.networkingCount != 0);
}

@end
