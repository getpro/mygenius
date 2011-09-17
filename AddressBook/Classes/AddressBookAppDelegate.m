//
//  AddressBookAppDelegate.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBookAppDelegate.h"

@implementation AddressBookAppDelegate

@synthesize tbController;
@synthesize window;
@synthesize back;
@synthesize sceneID;

@synthesize m_arrContactsInfo;
@synthesize m_arrDateInfo;
@synthesize m_arrMemoInfo;

@synthesize networkingCount = _networkingCount;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
    // Override point for customization after application launch.
	
	if(addressBook == nil)
		addressBook = ABAddressBookCreate();
	
	//[DBConnection getSharedDatabase];
	
	switchViewController = [[SwitchViewController alloc] init];
	
	sceneID				= [[NSMutableArray alloc] initWithCapacity:10];
	
	m_arrContactsInfo   = [[NSMutableArray alloc] initWithCapacity:10];
	m_arrDateInfo       = [[NSMutableArray alloc] initWithCapacity:10];
	m_arrMemoInfo       = [[NSMutableArray alloc] initWithCapacity:10];
	
	NSNumber * n = [NSNumber numberWithInt:0];
	
	[sceneID addObject:n];
	[sceneID addObject:n];
	[sceneID addObject:n];
	
	//
	/*
	if([DataStore Get_Copy_Addressbook] == 0)
	{
		//第一次运行程序
		NSLog(@"Copy_Addressbook==0");
		
		[self GetSysAddressBook];
		
		//系统通讯录的数据入库
		[DBConnection beginTransaction];
		
		for (int i = 0; i < [self.m_arrContactsInfo count]; i++)
		{
			contactsInfo * pcontactsInfo = (contactsInfo*)[self.m_arrContactsInfo objectAtIndex:i];
			
			if (pcontactsInfo)
			{
				//新闻条目入库
				[DataStore insertContactsInfo:pcontactsInfo];
			}
		}
		
		[DBConnection commitTransaction];
		
		//修改Copy_Addressbook = 1
		[DataStore Set_Copy_Addressbook :1];
		
		[DataStore Set_First_Use];
		
	}
	else 
	{
		//已经把系统通讯录的数据导入到了库里面
		NSLog(@"Copy_Addressbook==1");
		
		[DataStore getContactsInfo:self.m_arrContactsInfo];
		
		/*
		for (int i = 0; i < [self.m_arrContactsInfo count]; i++)
		{
			contactsInfo * pcontactsInfo = (contactsInfo*)[self.m_arrContactsInfo objectAtIndex:i];
			
			//新闻条目入库
			pcontactsInfo.m_ncontactsSex ++;
		}
		
		
		
	}
	*/
	
	//通讯录
	m_pAddressBookVC = [[AddressBookVC alloc] init];
									  
	UIImage* AddressBookImage = [UIImage imageNamed:@"bottom_icon_contacts.png"];
	UITabBarItem * AddressBookItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:AddressBookImage tag:0];
	m_pAddressBookVC.tabBarItem = AddressBookItem;
	[AddressBookItem release];
	
	UINavigationController * AddressBookNavController = [[UINavigationController alloc] initWithRootViewController:m_pAddressBookVC];
	
	//同步备份
	m_pAccountsVC = [[accountsVC alloc] init];
	
	UIImage* AccountsImage = [UIImage imageNamed:@"bottom_icon_sync.png"];
	UITabBarItem * AccountsItem = [[UITabBarItem alloc] initWithTitle:@"同步备份" image:AccountsImage tag:0];
	m_pAccountsVC.tabBarItem = AccountsItem;
	[AccountsItem release];
	
	
	//备忘录
	m_pMemoVC = [[memoVC alloc] init];
	
	UIImage* MemoImage = [UIImage imageNamed:@"bottom_icon_memo.png"];
	UITabBarItem * MemoItem = [[UITabBarItem alloc] initWithTitle:@"备忘录" image:MemoImage tag:0];
	m_pMemoVC.tabBarItem = MemoItem;
	m_pMemoVC.tabBarItem.badgeValue = @"2";
	[MemoItem release];
	
	//统计
	m_pDateVC = [[dateVC alloc] init];
	
	UIImage* DateImage = [UIImage imageNamed:@"bottom_icon_statistics.png.png"];
	UITabBarItem * DateBookItem = [[UITabBarItem alloc] initWithTitle:@"日程统计" image:DateImage tag:0];
	m_pDateVC.tabBarItem = DateBookItem;
	[DateBookItem release];
	
	//更多
	m_pSettingVC = [[settingVC alloc] init];
	
	UIImage* SettingImage = [UIImage imageNamed:@"bottom_icon_more.png"];
	UITabBarItem * SettingItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:SettingImage tag:0];
	m_pSettingVC.tabBarItem = SettingItem;
	[SettingItem release];
	
	
	tbController = [[UITabBarController alloc] init];
	tbController.viewControllers = [NSArray arrayWithObjects:AddressBookNavController,m_pAccountsVC,m_pMemoVC,m_pDateVC,m_pSettingVC,nil];
	tbController.selectedIndex = TAB_ADDRESSBOOK;
	
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
	
	[m_pAddressBookVC	  release];
	[m_pAccountsVC		  release];
	[m_pMemoVC			  release];
	[m_pDateVC			  release];
	[m_pSettingVC		  release];
	
	[tbController	      release];
	[switchViewController release];
    [window				  release];
	[sceneID			  release];
	
	[m_arrContactsInfo    release];
	[m_arrDateInfo		  release];
	[m_arrMemoInfo		  release];
	
    [super dealloc];
}

+(AddressBookAppDelegate*)getAppDelegate
{
    return (AddressBookAppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void) backScene
{
	rightOrLeft = NO;
	teXiao      = YES;
	back        = YES;
	
	NSNumber * n = [sceneID objectAtIndex:[sceneID count] - 2];
	[sceneID removeLastObject];
	backSceneID = [n intValue];
	
	NSString * ss = [NSString stringWithFormat:@"%d" , backSceneID];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
	
}

-(void) GetSysAddressBook
{
	//获得通讯录中联系人的所有属性
	ABAddressBookRef addressBook = ABAddressBookCreate();
	
	CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
	
	static int pCONTACTINFO_ID = CONTACTINFO_ID;
	
	for(int i = 0; i < CFArrayGetCount(results); i++)
	{
		
		contactsInfo * pcontactsInfo = [[contactsInfo alloc] init];
		
		pcontactsInfo.m_strcontactsID = [NSString stringWithFormat:@"%d",pCONTACTINFO_ID];
		
		pCONTACTINFO_ID ++ ;
		
		ABRecordRef person = CFArrayGetValueAtIndex(results, i);
		
		NSMutableString * pMutableNameString = [NSMutableString stringWithCapacity:10];
		
		//读取firstname
		NSString *personName = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		if(personName != nil)
		{
			//textView.text = [textView.text stringByAppendingFormat:@"\n姓名：%@\n",personName];
			[pMutableNameString appendString:personName];
		}
		
		//读取lastname
		NSString *lastname = (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
		if(lastname != nil)
		{
			//textView.text = [textView.text stringByAppendingFormat:@"%@\n",lastname];
			[pMutableNameString appendString:lastname];
		}
		
		pcontactsInfo.m_strcontactsName = pMutableNameString;
		
		/*
		 //读取middlename
		 NSString *middlename = (NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
		 if(middlename != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlename];
		 //读取prefix前缀
		 NSString *prefix = (NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
		 if(prefix != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",prefix];
		 //读取suffix后缀
		 NSString *suffix = (NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
		 if(suffix != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",suffix];
		 //读取nickname呢称
		 NSString *nickname = (NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
		 if(nickname != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",nickname];
		 //读取firstname拼音音标
		 NSString *firstnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
		 if(firstnamePhonetic != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",firstnamePhonetic];
		 //读取lastname拼音音标
		 NSString *lastnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
		 if(lastnamePhonetic != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",lastnamePhonetic];
		 //读取middlename拼音音标
		 NSString *middlenamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
		 if(middlenamePhonetic != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlenamePhonetic];
		 */
		
		
		//读取organization公司
		NSString *organization = (NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
		if(organization != nil)
		{
			//textView.text = [textView.text stringByAppendingFormat:@"%@\n",organization];
			pcontactsInfo.m_strcontactsOrganization = organization;
		}
		
		/*
		 //读取jobtitle工作
		 NSString *jobtitle = (NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
		 if(jobtitle != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",jobtitle];
		 
		 
		 //读取department部门
		 NSString *department = (NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
		 if(department != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",department];
		 
		 
		 //读取birthday生日
		 NSDate *birthday = (NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
		 if(birthday != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",birthday];
		 //读取note备忘录
		 NSString *note = (NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
		 if(note != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",note];
		 //第一次添加该条记录的时间
		 NSString *firstknow = (NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
		 NSLog(@"第一次添加该条记录的时间%@\n",firstknow);
		 //最后一次修改該条记录的时间
		 NSString *lastknow = (NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
		 NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
		 */
		
		
		
		//获取email多值
		ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
		int emailcount = ABMultiValueGetCount(email);    
		for (int x = 0; x < emailcount; x++)
		{
			//获取email Label
			NSString* emailLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
			//获取email值
			NSString* emailContent = (NSString*)ABMultiValueCopyValueAtIndex(email, x);
			//textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",emailLabel,emailContent];
			
			//住宅和工作
			if([emailLabel isEqual:@"住宅"])
			{
				pcontactsInfo.m_strcontactsHomeEmail = emailContent;
			}
			else if([emailLabel isEqual:@"工作"])
			{
				pcontactsInfo.m_strcontactsWorkEmail = emailContent;
			}
		}
		
		
		//读取地址多值
		ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
		int count = ABMultiValueGetCount(address);    
		
		for(int j = 0; j < count; j++)
		{
			//获取地址Label
			NSString* addressLabel = (NSString*)ABMultiValueCopyLabelAtIndex(address, j);
			
			//_$!<Work>!$_
			//_$!<Home>!$_
			
			//textView.text = [textView.text stringByAppendingFormat:@"%@\n",addressLabel];
			
			//获取該label下的地址6属性
			NSDictionary* personaddress =(NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
			
			NSMutableString * pMutableaddressString = [NSMutableString stringWithCapacity:24];
			
			{
				
				
				/*
				 NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
				 if(country != nil)
				 {
				 //textView.text = [textView.text stringByAppendingFormat:@"国家：%@\n",country];
				 }
				 */
				
				NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
				if(city != nil)
				{
					//textView.text = [textView.text stringByAppendingFormat:@"城市：%@\n",city];
					[pMutableaddressString appendString:city];
				}
				
				NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
				if(state != nil)
				{
					//textView.text = [textView.text stringByAppendingFormat:@"省：%@\n",state];
					[pMutableaddressString appendString:state];
				}
				
				NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
				if(street != nil)
				{
					//textView.text = [textView.text stringByAppendingFormat:@"街道：%@\n",street];
					[pMutableaddressString appendString:street];
				}
				
				
				
				/*
				 NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
				 if(zip != nil)
				 {
				 //textView.text = [textView.text stringByAppendingFormat:@"邮编：%@\n",zip];
				 }
				 
				 NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
				 if(coutntrycode != nil)
				 {
				 //textView.text = [textView.text stringByAppendingFormat:@"国家编号：%@\n",coutntrycode];    
				 }
				 */
			}
			
			if([addressLabel isEqual:@"_$!<Work>!$_"])
			{
				pcontactsInfo.m_strcontactsWorkAddress = pMutableaddressString;
			}
			else if([addressLabel isEqual:@"_$!<Home>!$_"])
			{
				pcontactsInfo.m_strcontactsHomeAddress = pMutableaddressString;
			}
			
			
		}
		
		/*
		 //获取dates多值
		 ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
		 int datescount = ABMultiValueGetCount(dates);    
		 for (int y = 0; y < datescount; y++)
		 {
		 //获取dates Label
		 NSString* datesLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
		 //获取dates值
		 NSString* datesContent = (NSString*)ABMultiValueCopyValueAtIndex(dates, y);
		 textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",datesLabel,datesContent];
		 }
		 //获取kind值
		 CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
		 if (recordType == kABPersonKindOrganization) {
		 // it's a company
		 NSLog(@"it's a company\n");
		 } else {
		 // it's a person, resource, or room
		 NSLog(@"it's a person, resource, or room\n");
		 }
		 
		 
		 //获取IM多值
		 ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
		 for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
		 {
		 //获取IM Label
		 NSString* instantMessageLabel = (NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
		 textView.text = [textView.text stringByAppendingFormat:@"%@\n",instantMessageLabel];
		 //获取該label下的2属性
		 NSDictionary* instantMessageContent =(NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);        
		 NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
		 if(username != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"username：%@\n",username];
		 
		 NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
		 if(service != nil)
		 textView.text = [textView.text stringByAppendingFormat:@"service：%@\n",service];            
		 }
		 */
		
		
		//读取电话多值
		ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
		for (int k = 0; k<ABMultiValueGetCount(phone); k++)
		{
			//获取电话Label
			NSString * personPhoneLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
			//获取該Label下的电话值
			NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
			
			//textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",personPhoneLabel,personPhone];
			
			//iPhone和移动电话
			
			if([personPhoneLabel isEqual:@"iPhone"])
			{
				pcontactsInfo.m_strcontactsIphone = personPhone;
			}
			else if([personPhoneLabel isEqual:@"移动电话"])
			{
				pcontactsInfo.m_strcontactsMobilePhone = personPhone;
			}
			
		}
		
		/*
		 //获取URL多值
		 ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
		 for (int m = 0; m < ABMultiValueGetCount(url); m++)
		 {
		 //获取电话Label
		 NSString * urlLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
		 //获取該Label下的电话值
		 NSString * urlContent = (NSString*)ABMultiValueCopyValueAtIndex(url,m);
		 
		 textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",urlLabel,urlContent];
		 }
		 */
		
		//读取照片
		NSData *image = (NSData*)ABPersonCopyImageData(person);
		
		if(image && [image length] > 0)
		{
			UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
			[myImage setImage:[UIImage imageWithData:image]];
			myImage.opaque = YES;
			//[textView addSubview:myImage];
		}
		
		[self.m_arrContactsInfo addObject:pcontactsInfo];
		
		[pcontactsInfo release];
	}
	
	CFRelease(results);
	CFRelease(addressBook);
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
