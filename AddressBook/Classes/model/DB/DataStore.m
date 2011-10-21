//
//  DataStore.m
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataStore.h"
#import "DBConnection.h"
#import "AddressBookAppDelegate.h"

@implementation DataStore

//config

+(NSInteger)Get_Copy_Addressbook
{
	NSInteger pInt  = 1;
	Statement *stmt = nil;
	
    
	stmt = [DBConnection statementWithQuery:"SELECT config_copy_addressbook FROM config WHERE config_id = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:CONFIG_ID forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pInt = [stmt getInt32:0];
    }
	
    [stmt reset];
    [stmt release];
	return pInt;
}

+(void)Set_Copy_Addressbook :(NSInteger)pInt;
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE config SET config_copy_addressbook = ? WHERE config_id = ?"];
	
    [stmt bindInt32 :pInt        forIndex:1];
    [stmt bindString:CONFIG_ID   forIndex:2];
	
    [stmt step]; // ignore error
}

+(void)Set_First_Use
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE config SET config_first_use = DATETIME('now') WHERE config_id = ?"];
	
    [stmt bindString:CONFIG_ID   forIndex:1];
	
    [stmt step]; // ignore error
}

+(void)removeServicerRules
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM servicer_rule"];
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertServicerRule:(NSString*)pLabel :(NSString*)pContent
{
	if(!pLabel ||!pContent || [pLabel isEqual:@""] || [pContent isEqual:@""] )
	{
		return;
	}
	
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO servicer_rule VALUES(?,?)"];
	
	[stmt bindString:pLabel		forIndex:1];//1.label
	[stmt bindString:pContent	forIndex:2];//2.content
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(NSArray*)getServicerRules
{
	NSMutableArray *retArray = [[[NSMutableArray alloc] init] autorelease];
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT * FROM servicer_rule"];
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pLabel            = [stmt getString:0];//Label
		NSString * pContent          = [stmt getString:1];//Content
		
		LabelAndContent * pLabelAndContent = [[LabelAndContent alloc]init];
		
		pLabelAndContent.m_strLabel		         = pLabel;
		pLabelAndContent.m_strContent            = pContent;
		
		[retArray addObject:pLabelAndContent];
		
		[pLabelAndContent release];
		
		count++;
	}
	
	[stmt reset];
	
	return retArray;
}

/* contacts_info */

/*
+(void)insertContactsInfo:(contactsInfo *)pContactsInfo
{
	if (pContactsInfo == nil)
	{
		return;
	}
	Statement* stmt = nil;
    if (stmt == nil)
	{
		stmt = [DBConnection statementWithQuery:"REPLACE INTO contacts_info VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
        [stmt retain];
    }
	
    [stmt bindString:pContactsInfo.m_strcontactsID			  forIndex:1];//contacts_id
    [stmt bindString:pContactsInfo.m_strcontactsName		  forIndex:2];//contacts_name
	[stmt bindString:pContactsInfo.m_strcontactsOrganization  forIndex:3];//organization
	[stmt bindInt32: pContactsInfo.m_ncontactsSex		      forIndex:4];//sex
	[stmt bindString:pContactsInfo.m_strcontactsHomeEmail     forIndex:5];//homeemail
	[stmt bindString:pContactsInfo.m_strcontactsWorkEmail	  forIndex:6];//workemail
	[stmt bindString:pContactsInfo.m_strcontactsHomeAddress   forIndex:7];//home_address
	[stmt bindString:pContactsInfo.m_strcontactsWorkAddress   forIndex:8];//work_address
    [stmt bindString:pContactsInfo.m_strcontactsMobilePhone	  forIndex:9];//mobilephone
	[stmt bindString:pContactsInfo.m_strcontactsIphone		  forIndex:10];//iphone
	[stmt bindString:pContactsInfo.m_strcontactsRecommendID   forIndex:11];//recommend_id
	[stmt bindString:pContactsInfo.m_strcontactsRecommendName forIndex:12];//recommend_name
	[stmt bindString:pContactsInfo.m_strcontactsRelationID	  forIndex:13];//relation_id
	[stmt bindString:pContactsInfo.m_strcontactsRelationName  forIndex:14];//relation_name
    
    // Ignore error
    [stmt step];
    [stmt reset];
	[stmt release];
}
*/

+(void)RemoveContact:(ABRecordRef)pABRecordRef
{
	if (pABRecordRef == nil)
	{
		return;
	}
	//if()
	{
		ABRecordID  pRecordID  = ABRecordGetRecordID(pABRecordRef);
		//移除基本信息
		[self removeContactsBaseInfo:pABRecordRef];
		
		[self removePhones:pRecordID];
		[self removeUrls:pRecordID];
		[self removeEmails:pRecordID];
		[self removeAddresses:pRecordID];
		[self removeInstantMessage:pRecordID:0];
		[self removeDates:pRecordID];
		[self removeAllAccounts:pRecordID];
		[self removeAllRelate:pRecordID];
		
		[self removeAllCertificate:pRecordID];
	}
}

+(void)removeContactsBaseInfo:(ABRecordRef)pABRecordRef
{
	if (pABRecordRef == nil)
	{
		return;
	}
	ABRecordID  pRecordID  = ABRecordGetRecordID(pABRecordRef);
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM contacts_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)updateContactsBaseInfo:(ABRecordRef)pABRecordRef
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	if (pABRecordRef == nil)
	{
		return;
	}
	Statement* stmt = nil;
    if (stmt == nil)
	{
		stmt = [DBConnection statementWithQuery:"UPDATE contacts_info SET contacts_lastname = ?,contacts_firstname = ?,contacts_prefix = ?,contacts_firstnamephonetic = ?,contacts_lastnamephonetic = ?,contacts_middlename = ?,contacts_suffix = ?,contacts_nickname = ?,contacts_organization = ?,contacts_jobtitle = ?,contacts_department = ?,contacts_headImage = ?,contacts_birthday = ?,contacts_note = ?,contacts_constellation = ?,contacts_creation = ?,contacts_modification = ? WHERE contacts_id = ?"];
        [stmt retain];
    }
	
	ABRecordRef person = pABRecordRef;
	ABRecordID  pRecordID  = ABRecordGetRecordID(person);
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:18];
	
	//读取lastname
	NSString *lastname = (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
	if(lastname != nil)
	{
		[stmt bindString:lastname	forIndex:1];//contacts_lastname
	}
	
	//读取firstname
	NSString *firstname = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	if(firstname != nil)
	{
		[stmt bindString:firstname	forIndex:2];//contacts_firstname
	}
	
	//读取prefix前缀
	NSString *prefix = (NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
	if(prefix != nil)
	{
		[stmt bindString:prefix	forIndex:3];//contacts_prefix
	}
	
	//读取firstname拼音音标
	NSString *firstnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
	if(firstnamePhonetic != nil)
	{
		[stmt bindString:firstnamePhonetic	forIndex:4];//contacts_firstnamephonetic
	}
	
	//读取lastname拼音音标
	NSString *lastnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
	if(lastnamePhonetic != nil)
	{
		[stmt bindString:lastnamePhonetic	forIndex:5];//contacts_lastnamephonetic
	}
	
	//读取middlename
	NSString *middlename = (NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
	if(middlename != nil)
	{
		[stmt bindString:middlename	forIndex:6];//contacts_middlename
	}
	
	//读取suffix后缀
	NSString *suffix = (NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
	if(suffix != nil)
	{
		[stmt bindString:suffix	forIndex:7];//contacts_suffix
	}
	
	//读取nickname呢称
	NSString *nickname = (NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
	if(nickname != nil)
	{
		[stmt bindString:nickname	forIndex:8];//contacts_nickname
	}

	//读取organization公司
	NSString *organization = (NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
	if(organization != nil)
	{
		[stmt bindString:organization	forIndex:9];//contacts_organization
	}
	
	//读取jobtitle工作
	NSString *jobtitle = (NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
	if(jobtitle != nil)
	{
		[stmt bindString:jobtitle	forIndex:10];//contacts_jobtitle
	}
	
	//读取department部门
	NSString *department = (NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
	if(department != nil)
	{
		[stmt bindString:department	forIndex:11];//contacts_department
	}
	
	//读取照片
	NSData *image = (NSData*)ABPersonCopyImageData(person);
	if(image && [image length] > 0)
	{
		[stmt bindData:image	forIndex:12];//contacts_headImage
	}
	
	//读取birthday生日
	NSDate *birthday = (NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
	if(birthday != nil)
	{
		[stmt bindInt32:[birthday timeIntervalSince1970] forIndex:13];//contacts_birthday
	}
	
	//读取note备忘录
	NSString *note = (NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
	if(note != nil)
	{
		[stmt bindString:note	forIndex:14];//contacts_note
	}
	
	//星座
	if(birthday != nil)
	{
		NSDateFormatter *formattermonth = [[[NSDateFormatter alloc] init] autorelease];
		NSDateFormatter *formatterday   = [[[NSDateFormatter alloc] init] autorelease];
		
		[formattermonth setDateFormat:@"MM"];
		[formatterday   setDateFormat:@"dd"];
		
		NSString *monthStr = [formattermonth stringFromDate:birthday];
		NSString *dayStr   = [formatterday   stringFromDate:birthday];
		
		//NSLog(@"[%@]",monthStr);
		//NSLog(@"[%@]",dayStr);
		
		int month = [monthStr intValue];
		int day   = [dayStr   intValue];
		
		/*
		 水平座 《1/21～2/18》 狮子座 《 7/23～ 8/23》
		 双鱼座 《2/19～3/20》 处女座 《 8/24～ 9/22》
		 牡羊座 《3/21～4/20》 天秤座 《 9/23～10/23》
		 金牛座 《4/21～5/21》 天蝎座 《10/24～11/22》
		 双子座 《5/22～6/21》 射手座 《11/23～12/21》
		 巨蟹座 《6/22～7/22》 摩羯座 《12/22～ 1/20》
		 */
		
		NSString * pConstellation = nil;
		
		switch (month) 
		{
			case 1:
			{
				if(day <= 20)
				{
					pConstellation = @"摩羯座";
				}
				else
				{
					pConstellation = @"水平座";
				}
			}
				break;
			case 2:
			{
				if(day <= 18)
				{
					pConstellation = @"水平座";
				}
				else
				{
					pConstellation = @"双鱼座";
				}
			}
				break;
			case 3:
			{
				if(day <= 20)
				{
					pConstellation = @"双鱼座";
				}
				else
				{
					pConstellation = @"牡羊座";
				}
			}
				break;
			case 4:
			{
				if(day <= 20)
				{
					pConstellation = @"牡羊座";
				}
				else
				{
					pConstellation = @"金牛座";
				}
			}
				break;
			case 5:
			{
				if(day <= 21)
				{
					pConstellation = @"金牛座";
				}
				else
				{
					pConstellation = @"双子座";
				}
			}
				break;
			case 6:
			{
				if(day <= 21)
				{
					pConstellation = @"双子座";
				}
				else
				{
					pConstellation = @"巨蟹座";
				}
			}
				break;
			case 7:
			{
				if(day <= 22)
				{
					pConstellation = @"巨蟹座";
				}
				else
				{
					pConstellation = @"狮子座";
				}
			}
				break;
			case 8:
			{
				if(day <= 23)
				{
					pConstellation = @"狮子座";
				}
				else
				{
					pConstellation = @"处女座";
				}
			}
				break;
			case 9:
			{
				if(day <= 22)
				{
					pConstellation = @"处女座";
				}
				else
				{
					pConstellation = @"天秤座";
				}
			}
				break;
			case 10:
			{
				if(day <= 23)
				{
					pConstellation = @"天秤座";
				}
				else
				{
					pConstellation = @"天蝎座";
				}
			}
				break;
			case 11:
			{
				if(day <= 22)
				{
					pConstellation = @"天蝎座";
				}
				else
				{
					pConstellation = @"射手座";
				}
			}
				break;
			case 12:
			{
				if(day <= 21)
				{
					pConstellation = @"射手座";
				}
				else
				{
					pConstellation = @"摩羯座";
				}
			}
				break;
			default:
				break;
		}
		
		[stmt bindString:pConstellation	forIndex:15];//contacts_constellation
	}
	
	//第一次添加该条记录的时间
	NSDate *firstknow = (NSDate*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
	if(firstknow == nil)
	{
		firstknow = [NSDate date];
	}
	[stmt bindInt32:[firstknow timeIntervalSince1970] forIndex:16];//contacts_creation
	
	//最后一次修改該条记录的时间
	NSDate *lastknow = (NSDate*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
	if(lastknow == nil)
	{
		lastknow = [NSDate date];
	}
	[stmt bindInt32:[lastknow timeIntervalSince1970] forIndex:17];//contacts_modification
	
	//获取email多值
	
	[self removeEmails:pRecordID];
	
	ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
	int emailcount = ABMultiValueGetCount(email);    
	for (int x = 0; x < emailcount; x++)
	{
		//获取email Label
		NSString* emailLabel   = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
		//获取email值
		NSString* emailContent = (NSString*)ABMultiValueCopyValueAtIndex(email, x);
		
		[self insertEmails:pRecordID:emailContent:emailLabel:x];
	}
	
	
	//读取地址多值
	
	[self removeAddresses:pRecordID];
	
	ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
	int count = ABMultiValueGetCount(address);    
	
	for(int j = 0; j < count; j++)
	{
		//获取地址Label
		NSString* addressLabel = (NSString*)ABMultiValueCopyLabelAtIndex(address, j);
		//_$!<Work>!$_
		//_$!<Home>!$_
		//获取該label下的地址6属性
		NSDictionary* personaddress =(NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
		
		NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
		
		NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
		
		NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
		
	    NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
		
		NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
		
		//NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
		
		[self insertAddresses:pRecordID:street
							 :zip:city:state
							 :country:addressLabel:j];
		
	}
	
	//获取dates多值
	//移除之前日历项目
	
	[self removeDates:pRecordID];
	
	ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
	int datescount = ABMultiValueGetCount(dates);    
	for (int y = 0; y < datescount; y++)
	{
		//获取dates Label
		NSString* datesLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
		//获取dates值
		NSDate* datesContent = (NSDate*)ABMultiValueCopyValueAtIndex(dates, y);
		
		//创建Event
		NSError * error     = nil;
		
		EKEvent * thisEvent = [EKEvent eventWithEventStore:app.eventStore];
		
		thisEvent.calendar  = app.defaultCalendar;
		
		ABContact * pABContact = [ABContact contactWithRecord:person];
		
		thisEvent.title     = [NSString stringWithFormat:@"%@%@",pABContact.contactName,datesLabel];
		
		thisEvent.startDate = datesContent;
		
		thisEvent.endDate   = datesContent;
		
		BOOL pResult = [app.eventStore saveEvent:thisEvent span:EKSpanThisEvent error:&error];
		
		//这里有问题
		if(pResult)
		{
			[self insertDates:thisEvent.eventIdentifier:pRecordID:[datesContent timeIntervalSince1970]:datesLabel:y:0:0];
		}
	}
	
	//获取IM多值
	
	[self removeInstantMessage:pRecordID:0];
	
	ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
	for (int l = 0; l < ABMultiValueGetCount(instantMessage); l++)
	{
		//获取IM Label
		NSString* instantMessageLabel = (NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
		
		//获取該label下的2属性
		NSDictionary* instantMessageContent =(NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
		NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
		NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
		
		[self insertInstantMessage:pRecordID:username:service:instantMessageLabel:l:0];
	}
	
	//读取电话多值
	
	[self removePhones:pRecordID];
	
	ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
	for (int k = 0; k<ABMultiValueGetCount(phone); k++)
	{
		//获取电话Label
		NSString * personPhoneLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
		//获取該Label下的电话值
		NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
		
		[self insertPhones:pRecordID:personPhone:personPhoneLabel:k];
	}
	
	//获取URL多值
	
	[self removeUrls:pRecordID];
	
	ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
	for (int m = 0; m < ABMultiValueGetCount(url); m++)
	{
		//获取电话Label
		NSString * urlLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
		//获取該Label下的电话值
		NSString * urlContent = (NSString*)ABMultiValueCopyValueAtIndex(url,m);
		
		[self insertUrls:pRecordID:urlContent:urlLabel:m];
	}

	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertContactsBaseInfo:(ABRecordRef)pABRecordRef
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	if (pABRecordRef == nil)
	{
		return;
	}
	Statement* stmt = nil;
    if (stmt == nil)
	{
		stmt = [DBConnection statementWithQuery:"REPLACE INTO contacts_info VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
        [stmt retain];
    }
	
	ABRecordRef person = pABRecordRef;
	ABRecordID  pRecordID  = ABRecordGetRecordID(person);
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID] forIndex:1];//1.contacts_id
	
	//读取lastname
	NSString *lastname = (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
	if(lastname != nil)
	{
		[stmt bindString:lastname	forIndex:2];//2.contacts_lastname
	}
	
	//读取firstname
	NSString *firstname = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	if(firstname != nil)
	{
		[stmt bindString:firstname	forIndex:3];//3.contacts_firstname
	}
	
	//读取prefix前缀
	NSString *prefix = (NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
	if(prefix != nil)
	{
		[stmt bindString:prefix	forIndex:4];//4.contacts_prefix
	}
	
	//读取firstname拼音音标
	NSString *firstnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
	if(firstnamePhonetic != nil)
	{
		[stmt bindString:firstnamePhonetic	forIndex:5];//5.contacts_firstnamephonetic
	}
	
	//读取lastname拼音音标
	NSString *lastnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
	if(lastnamePhonetic != nil)
	{
		[stmt bindString:lastnamePhonetic	forIndex:6];//6.contacts_lastnamephonetic
	}
	
	//读取middlename
	NSString *middlename = (NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
	if(middlename != nil)
	{
		[stmt bindString:middlename	forIndex:7];//7.contacts_middlename
	}
	
	//读取suffix后缀
	NSString *suffix = (NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
	if(suffix != nil)
	{
		[stmt bindString:suffix	forIndex:8];//8.contacts_suffix
	}
	
	//读取nickname呢称
	NSString *nickname = (NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
	if(nickname != nil)
	{
		[stmt bindString:nickname	forIndex:9];//9.contacts_nickname
	}
	
	//读取middlename拼音音标
	//NSString *middlenamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
	//if(middlenamePhonetic != nil)
	//textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlenamePhonetic];
	
	//读取organization公司
	NSString *organization = (NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
	if(organization != nil)
	{
		[stmt bindString:organization	forIndex:10];//10.contacts_organization
	}
	
	//读取jobtitle工作
	NSString *jobtitle = (NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
	if(jobtitle != nil)
	{
		[stmt bindString:jobtitle	forIndex:11];//11.contacts_jobtitle
	}
	
	//读取department部门
	NSString *department = (NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
	if(department != nil)
	{
		[stmt bindString:department	forIndex:12];//12.contacts_department
	}
	
	//读取照片
	NSData *image = (NSData*)ABPersonCopyImageData(person);
	if(image && [image length] > 0)
	{
		//UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
		//[myImage setImage:[UIImage imageWithData:image]];
		//myImage.opaque = YES;
		
		[stmt bindData:image	forIndex:13];//13.contacts_headImage
	}
	
	//性别
	//[stmt bindString:image	forIndex:14];//14.contacts_sex
	
	//铃声
	//[stmt bindString:image	forIndex:15];//15.contacts_ring
	
	//推荐人
	//[stmt bindString:image	forIndex:16];//16.contacts_recommend_id
	
	//分组
	//[stmt bindString:image	forIndex:17];//17.contacts_group_id
	
	//读取birthday生日
	NSDate *birthday = (NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
	if(birthday != nil)
	{
		[stmt bindInt32:[birthday timeIntervalSince1970] forIndex:18];//18.contacts_birthday
	}
	
	//读取note备忘录
	NSString *note = (NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
	if(note != nil)
	{
		[stmt bindString:note	forIndex:19];//19.contacts_note
	}
	
	//星座
	if(birthday != nil)
	{
		NSDateFormatter *formattermonth = [[[NSDateFormatter alloc] init] autorelease];
		NSDateFormatter *formatterday   = [[[NSDateFormatter alloc] init] autorelease];
		
		[formattermonth setDateFormat:@"MM"];
		[formatterday   setDateFormat:@"dd"];
		
		NSString *monthStr = [formattermonth stringFromDate:birthday];
		NSString *dayStr   = [formatterday   stringFromDate:birthday];
		
		//NSLog(@"[%@]",monthStr);
		//NSLog(@"[%@]",dayStr);
		
		int month = [monthStr intValue];
		int day   = [dayStr   intValue];
		
		/*
		 水平座 《1/21～2/18》 狮子座 《 7/23～ 8/23》
		 双鱼座 《2/19～3/20》 处女座 《 8/24～ 9/22》
		 牡羊座 《3/21～4/20》 天秤座 《 9/23～10/23》
		 金牛座 《4/21～5/21》 天蝎座 《10/24～11/22》
		 双子座 《5/22～6/21》 射手座 《11/23～12/21》
		 巨蟹座 《6/22～7/22》 摩羯座 《12/22～ 1/20》
		 */
		
		NSString * pConstellation = nil;
		
		switch (month) 
		{
			case 1:
			{
				if(day <= 20)
				{
					pConstellation = @"摩羯座";
				}
				else
				{
					pConstellation = @"水平座";
				}
			}
				break;
			case 2:
			{
				if(day <= 18)
				{
					pConstellation = @"水平座";
				}
				else
				{
					pConstellation = @"双鱼座";
				}
			}
				break;
			case 3:
			{
				if(day <= 20)
				{
					pConstellation = @"双鱼座";
				}
				else
				{
					pConstellation = @"牡羊座";
				}
			}
				break;
			case 4:
			{
				if(day <= 20)
				{
					pConstellation = @"牡羊座";
				}
				else
				{
					pConstellation = @"金牛座";
				}
			}
				break;
			case 5:
			{
				if(day <= 21)
				{
					pConstellation = @"金牛座";
				}
				else
				{
					pConstellation = @"双子座";
				}
			}
				break;
			case 6:
			{
				if(day <= 21)
				{
					pConstellation = @"双子座";
				}
				else
				{
					pConstellation = @"巨蟹座";
				}
			}
				break;
			case 7:
			{
				if(day <= 22)
				{
					pConstellation = @"巨蟹座";
				}
				else
				{
					pConstellation = @"狮子座";
				}
			}
				break;
			case 8:
			{
				if(day <= 23)
				{
					pConstellation = @"狮子座";
				}
				else
				{
					pConstellation = @"处女座";
				}
			}
				break;
			case 9:
			{
				if(day <= 22)
				{
					pConstellation = @"处女座";
				}
				else
				{
					pConstellation = @"天秤座";
				}
			}
				break;
			case 10:
			{
				if(day <= 23)
				{
					pConstellation = @"天秤座";
				}
				else
				{
					pConstellation = @"天蝎座";
				}
			}
				break;
			case 11:
			{
				if(day <= 22)
				{
					pConstellation = @"天蝎座";
				}
				else
				{
					pConstellation = @"射手座";
				}
			}
				break;
			case 12:
			{
				if(day <= 21)
				{
					pConstellation = @"射手座";
				}
				else
				{
					pConstellation = @"摩羯座";
				}
			}
				break;
			default:
				break;
		}
		
		[stmt bindString:pConstellation	forIndex:20];//20.contacts_constellation
	}
	
	//血型
	//[stmt bindString:note	forIndex:21];//21.contacts_blood
	
	//添加类型
	[stmt bindString:@"1"	forIndex:22];//22.contacts_add_type
	
	//第一次添加该条记录的时间
	NSDate *firstknow = (NSDate*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
	if(firstknow == nil)
	{
		firstknow = [NSDate date];
	}
	[stmt bindInt32:[firstknow timeIntervalSince1970] forIndex:23];//23.contacts_creation
	
	//最后一次修改該条记录的时间
	NSDate *lastknow = (NSDate*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
	if(lastknow == nil)
	{
		lastknow = [NSDate date];
	}
	[stmt bindInt32:[lastknow timeIntervalSince1970] forIndex:24];//24.contacts_modification
	
	//获取email多值
	ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
	int emailcount = ABMultiValueGetCount(email);    
	for (int x = 0; x < emailcount; x++)
	{
		//获取email Label
		NSString* emailLabel   = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
		//获取email值
		NSString* emailContent = (NSString*)ABMultiValueCopyValueAtIndex(email, x);
		
		[self insertEmails:pRecordID:emailContent:emailLabel:x];
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
		//获取該label下的地址6属性
		NSDictionary* personaddress =(NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
		
		NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
		
		NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
			
		NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
			
	    NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
			
		NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
		
		//NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
		
		[self insertAddresses:pRecordID:street
							 :zip:city:state
							 :country:addressLabel:j];
			 
	}
	
	//获取dates多值
	//移除之前日历项目
	
	[self removeDates:pRecordID];
	
	ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
	int datescount = ABMultiValueGetCount(dates);    
	for (int y = 0; y < datescount; y++)
	{
		//获取dates Label
		NSString* datesLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
		//获取dates值
		NSDate* datesContent = (NSDate*)ABMultiValueCopyValueAtIndex(dates, y);
		
		//创建Event
		NSError * error     = nil;
		
		EKEvent * thisEvent = [EKEvent eventWithEventStore:app.eventStore];
		
		thisEvent.calendar  = app.defaultCalendar;
		
		ABContact * pABContact = [ABContact contactWithRecord:person];
		
		thisEvent.title     = [NSString stringWithFormat:@"%@%@",pABContact.contactName,datesLabel];
		
		thisEvent.startDate = datesContent;
		
		thisEvent.endDate   = datesContent;
		
		BOOL pResult = [app.eventStore saveEvent:thisEvent span:EKSpanThisEvent error:&error];
		
		//这里有问题
		if(pResult)
		{
			[self insertDates:thisEvent.eventIdentifier:pRecordID:[datesContent timeIntervalSince1970]:datesLabel:y:0:0];
		}
	}
	
	//获取kind值
	//CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
	//if (recordType == kABPersonKindOrganization) 
	//{
	//	 // it's a company
	//	 NSLog(@"it's a company\n");
	//} 
	//else 
	//{
		// it's a person, resource, or room
		//NSLog(@"it's a person, resource, or room\n");
	//}
	
	//获取IM多值
	ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
	for (int l = 0; l < ABMultiValueGetCount(instantMessage); l++)
	{
		//获取IM Label
		NSString* instantMessageLabel = (NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
		
		//获取該label下的2属性
		NSDictionary* instantMessageContent =(NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
		NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
		NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
		
		[self insertInstantMessage:pRecordID:username:service:instantMessageLabel:l:0];
	}
	
	//读取电话多值
	ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
	for (int k = 0; k<ABMultiValueGetCount(phone); k++)
	{
		//获取电话Label
		NSString * personPhoneLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
		//获取該Label下的电话值
		NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
		
		[self insertPhones:pRecordID:personPhone:personPhoneLabel:k];
	}
	
	//获取URL多值
	ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
	for (int m = 0; m < ABMultiValueGetCount(url); m++)
	{
		//获取电话Label
		NSString * urlLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
		//获取該Label下的电话值
		NSString * urlContent = (NSString*)ABMultiValueCopyValueAtIndex(url,m);
		
		[self insertUrls:pRecordID:urlContent:urlLabel:m];
	}
	
    [stmt step];
    [stmt reset];
	[stmt release];
}



+(BOOL)RecordIDIsExist:(ABRecordID)pRecordID
{
	Statement * stmt = nil;
	BOOL pRet = NO;
	
	stmt = [DBConnection statementWithQuery:"select * from contacts_info WHERE contacts_id = ?"];
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID] forIndex:1];
	
	while ([stmt step] == SQLITE_ROW)
	{
		pRet = YES;
		break;
	}
	
	[stmt reset];
	
	return pRet;
}

+(BOOL)RecordIDIsModify:(ABRecordRef)pABRecordRef
{
	Statement * stmt = nil;
	BOOL pRet = YES;
	NSTimeInterval pInt;
	
	ABRecordID  pRecordID  = ABRecordGetRecordID(pABRecordRef);
	
	NSDate *lastknow = (NSDate*)ABRecordCopyValue(pABRecordRef, kABPersonModificationDateProperty);
	
	stmt = [DBConnection statementWithQuery:"SELECT contacts_modification FROM contacts_info WHERE contacts_id = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:[NSString stringWithFormat:@"%d",pRecordID] forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pInt = [stmt getInt32:0];
		
		NSDate *pInDBTime = [NSDate dateWithTimeIntervalSince1970:pInt];
		
		if([pInDBTime isEqualToDate:lastknow])
		{
			pRet = NO;
		}
    }
	
    [stmt reset];
    [stmt release];
	
	return pRet;
}

+(void)insertEmails:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO email_info VALUES(?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:pContent						                forIndex:2];//2.content
	[stmt bindString:pLabel									        forIndex:3];//3.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:4];//4.index
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:5];//5.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:6];//6.modification
	
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)removeEmails:(ABRecordID)pRecordID
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM email_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertAddresses:(ABRecordID)pRecordID:(NSString*)pStreet:(NSString*)pZip
					  :(NSString*)pCity:(NSString*)pState:(NSString*)pCountry
				      :(NSString*)pLabel:(NSInteger)pIndex
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO address_info VALUES(?,?,?,?,?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:pStreet						                forIndex:2];//2.street
	[stmt bindString:pZip									        forIndex:3];//3.zip
	[stmt bindString:pCity											forIndex:4];//4.city
	[stmt bindString:pState									        forIndex:5];//5.state
	[stmt bindString:pCountry						                forIndex:6];//6.country
	[stmt bindString:pLabel									        forIndex:7];//7.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:8];//8.index
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:9];//9.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:10];//10.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)removeAddresses:(ABRecordID)pRecordID
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM address_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)upDateEvent:(NSString*)pIdentifier :(EKEvent*)pEvent
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE date_info SET date_time = ?,date_label = ?,date_remind = ?,date_modification = ? WHERE date_identifier = ?"];
	
    [stmt bindInt32 :[[pEvent startDate] timeIntervalSince1970]	   forIndex:1];
	[stmt bindString:[pEvent title]                                forIndex:2];
	//[stmt bindString:pEvent									   forIndex:3];
	[stmt bindInt32 :[[NSDate date] timeIntervalSince1970]		   forIndex:4];
	[stmt bindString:pIdentifier								   forIndex:5];
	
    [stmt step];
}

+(void)removeDateEvent:(NSString*)pIdentifier
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM date_info WHERE date_identifier = ?"];
	
	[stmt bindString:pIdentifier	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertDates:(NSString*)pIdentifier:(ABRecordID)pRecordID:(NSInteger)pContent:(NSString*)pLabel:(NSInteger)pIndex:(NSInteger)pRemind:(NSInteger)pType
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO date_info VALUES(?,?,?,?,?,?,?,?,?)"];
	
	[stmt bindString:pIdentifier	                                forIndex:1];//1.Identifier
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:2];//2.id
	[stmt bindInt32: pContent						                forIndex:3];//3.time
	[stmt bindString:pLabel									        forIndex:4];//4.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pRemind]	    forIndex:5];//5.remind
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:6];//6.index
	[stmt bindString:[NSString stringWithFormat:@"%d",pType]	    forIndex:7];//7.type
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:8];//8.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:9];//9.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)removeDatesEvents:(ABRecordID)pRecordID
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	Statement * stmt  = nil;
	NSError   * error = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT date_identifier FROM date_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pIdentifier  = [stmt getString:0];//date_identifier
		
		if(pIdentifier)
		{
			EKEvent * pEvent = [app.eventStore eventWithIdentifier:pIdentifier];
			
			if(pEvent)
				[app.eventStore removeEvent:pEvent span:EKSpanThisEvent error:&error];
			
		}
		
		count++;
	}
	
	[stmt reset];
}

+(void)removeDates:(ABRecordID)pRecordID
{
	[self removeDatesEvents:pRecordID];
	
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM date_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(NSArray*)getDates:(ABRecordID)pRecordID:(NSInteger)pType
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	NSMutableArray *retArray = [[[NSMutableArray alloc] init] autorelease];
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT date_time,date_label,date_remind,date_identifier FROM date_info WHERE contacts_id = ? AND date_type = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:[NSString stringWithFormat:@"%d",pType]	    forIndex:2];//2.type
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSInteger  pDate		    = [stmt getInt32: 0];//date_time
		NSString * pLabel           = [stmt getString:1];//date_label
		NSString * pRemind          = [stmt getString:2];//date_remind
		NSString * pIdentifier      = [stmt getString:3];//date_identifier
		
		EKEvent * pEvent = [app.eventStore eventWithIdentifier:pIdentifier];
		
		if(pEvent)
		{
			//[self upDateEvent:pIdentifier:pEvent];
			date_info * pDate_info = [[date_info alloc]init];
			
			/*
			pDate_info.m_nDate		    	 = [[pEvent startDate] timeIntervalSince1970];
			pDate_info.m_pLabel		         = [pEvent title];
			pDate_info.m_nRemind             = [pRemind intValue];
			pDate_info.m_pIdentifier         = pIdentifier;
			*/
			
			pDate_info.m_nDate		    	 = pDate;
			pDate_info.m_pLabel		         = pLabel;
			pDate_info.m_nRemind             = [pRemind intValue];
			pDate_info.m_pIdentifier         = pIdentifier;
			
			
			[retArray addObject:pDate_info];
			
			[pDate_info release];
		}
		else
		{
			//已删除
			[self removeDateEvent:pIdentifier];
		}
		
		count++;
	}
	
	[stmt reset];
	
	return retArray;
}

+(void)insertInstantMessage:(ABRecordID)pRecordID:(NSString*)pUsername:(NSString*)pService:(NSString*)pLabel:(NSInteger)pIndex:(NSInteger)pType
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO instantMessage_info VALUES(?,?,?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:pUsername						                forIndex:2];//2.username
	if(pService)
	{
		[stmt bindString:pService									forIndex:3];//3.service
	}
	[stmt bindString:pLabel										    forIndex:4];//4.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:5];//5.index
	[stmt bindString:[NSString stringWithFormat:@"%d",pType]	    forIndex:6];//6.type
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:7];//7.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:8];//8.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)removeInstantMessage:(ABRecordID)pRecordID:(NSInteger)pType
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM instantMessage_info WHERE contacts_id = ? AND instantMessage_type = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:[NSString stringWithFormat:@"%d",pType]	    forIndex:2];//2.type
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(NSArray*)getInstantMessages:(ABRecordID)pRecordID:(NSInteger)pType
{
	NSMutableArray *retArray = [[[NSMutableArray alloc] init] autorelease];
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT instantMessage_username,instantMessage_label FROM instantMessage_info WHERE contacts_id = ? AND instantMessage_type = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:[NSString stringWithFormat:@"%d",pType]	    forIndex:2];//2.type
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pContent		    = [NSString stringWithFormat:@"%@", [stmt getString:0]];//username
		NSString * pLabel           = [NSString stringWithFormat:@"%@", [stmt getString:1]];
		
		LabelAndContent * pLabelAndContent = [[LabelAndContent alloc]init];
		
		pLabelAndContent.m_strLabel		    	 = pLabel;
		pLabelAndContent.m_strContent		     = pContent;
		
		[retArray addObject:pLabelAndContent];
		
		[pLabelAndContent release];
		
		count++;
	}
	
	[stmt reset];
	
	return retArray;
}

+(void)insertPhones:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO tel_info VALUES(?,?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:pContent						                forIndex:2];//2.num
	[stmt bindString:pLabel									        forIndex:3];//3.label
	[stmt bindString:@"0"									        forIndex:4];//4.servicer
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:5];//5.index
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:6];//6.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:7];//7.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)removePhones:(ABRecordID)pRecordID
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM tel_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertUrls:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO url_info VALUES(?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:pContent						                forIndex:2];//2.num
	[stmt bindString:pLabel									        forIndex:3];//3.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:4];//4.index
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:5];//5.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:6];//6.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)removeUrls:(ABRecordID)pRecordID
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM url_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertGroup:(ABGroup *) pNew
{
	if (pNew == nil)
	{
		return;
	}
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"REPLACE INTO group_info VALUES(?,?,?,?)"];
	[stmt retain];
    
	ABRecordID  pGroupID  = ABRecordGetRecordID(pNew.record);
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pGroupID] forIndex:1];//1.group_id
	[stmt bindString:pNew.name									forIndex:2];//2.group_name
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]		forIndex:3];//3.group_creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]		forIndex:4];//4.group_modification
	
	[stmt step];
    [stmt reset];
	[stmt release];
	
}

+(void)updateGroupID:(ABRecordID)pRecordID:(ABRecordID)pGroupID
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE contacts_info SET contacts_group_id = ? WHERE contacts_id = ?"];
	
    [stmt bindString:[NSString stringWithFormat:@"%d",pGroupID]    forIndex:1];
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]   forIndex:2];
	
    [stmt step];
}

+(ABRecordID)GetGroupID:(NSString *)pName
{
	ABRecordID  pID = 0;
	Statement *stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT group_id FROM group_info WHERE group_name = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:pName forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pID = [[stmt getString:0] intValue];
    }
	
    [stmt reset];
    [stmt release];
	return pID;
}

+(NSString*)GetGroupName:(ABRecordID)pGroupID
{
	NSString*  pName = nil;
	Statement *stmt  = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT group_name FROM group_info WHERE group_id = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:[NSString stringWithFormat:@"%d",pGroupID] forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pName = [stmt getString:0];
    }
	
    [stmt reset];
    [stmt release];
	return pName;
}

+(ABRecordID)GetGroupID2:(ABRecordID)pRecordID
{
	ABRecordID  pID = 0;
	Statement *stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT contacts_group_id FROM contacts_info WHERE contacts_id = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:[NSString stringWithFormat:@"%d",pRecordID] forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pID = [[stmt getString:0] intValue];
    }
	
    [stmt reset];
    [stmt release];
	return pID;
}



+(void)updateGroup:(ABRecordID)pRecordID:(ABRecordID)pGroupID
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE contacts_info SET contacts_group_id = ? WHERE contacts_id = ?"];
	
    [stmt bindString:[NSString stringWithFormat:@"%d",pGroupID]    forIndex:1];
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]   forIndex:2];
	
    [stmt step];
}

+(void)updateBlood:(ABRecordID)pRecordID:(NSString*)pStr
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE contacts_info SET contacts_blood = ? WHERE contacts_id = ?"];
	
    [stmt bindString:pStr									       forIndex:1];
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]   forIndex:2];
	
    [stmt step];
}

+(NSString*)getBlood:(ABRecordID)pRecordID
{
	NSString*  pName = nil;
	Statement *stmt  = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT contacts_blood FROM contacts_info WHERE contacts_id = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:[NSString stringWithFormat:@"%d",pRecordID] forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pName = [stmt getString:0];
    }
	
    [stmt reset];
    [stmt release];
	return pName;
}

+(void)updateConstellation:(ABRecordID)pRecordID:(NSString*)pStr;
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE contacts_info SET contacts_constellation = ? WHERE contacts_id = ?"];
	
    [stmt bindString:pStr									       forIndex:1];
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]   forIndex:2];
	
    [stmt step];
}

+(NSString*)getConstellation:(ABRecordID)pRecordID;
{
	NSString*  pName = nil;
	Statement *stmt  = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT contacts_constellation FROM contacts_info WHERE contacts_id = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:[NSString stringWithFormat:@"%d",pRecordID] forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pName = [stmt getString:0];
    }
	
    [stmt reset];
    [stmt release];
	return pName;
}

+(void)updateRecommend:(ABRecordID)pRecordID:(ABRecordID)pRecommendID;
{
	Statement *stmt = [DBConnection statementWithQuery:"UPDATE contacts_info SET contacts_recommend_id = ? WHERE contacts_id = ?"];
	
    [stmt bindString:[NSString stringWithFormat:@"%d",pRecommendID]   forIndex:1];
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]      forIndex:2];
	
    [stmt step];
}

+(ABRecordID)getRecommend:(ABRecordID)pRecordID
{
	NSString*  pName = nil;
	Statement *stmt  = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT contacts_recommend_id FROM contacts_info WHERE contacts_id = ? "];
	[stmt retain];
    
    // Note that the parameters are numbered from 1, not from 0.
    [stmt bindString:[NSString stringWithFormat:@"%d",pRecordID] forIndex:1];
    if ([stmt step] == SQLITE_ROW)
	{
        // Restore image from Database
        pName = [stmt getString:0];
    }
	
    [stmt reset];
    [stmt release];
	return [pName intValue];
}

+(void)insertAccounts:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO account_info VALUES(?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:pContent						                forIndex:2];//2.content
	[stmt bindString:pLabel									        forIndex:3];//3.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:4];//4.index
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:5];//5.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:6];//6.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(NSArray*)getAccounts:(ABRecordID)pRecordID
{
	NSMutableArray *retArray = [[[NSMutableArray alloc] init] autorelease];
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT * FROM account_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pContent		    = [NSString stringWithFormat:@"%@", [stmt getString:1]];
		NSString * pLabel           = [NSString stringWithFormat:@"%@", [stmt getString:2]];
		
		LabelAndContent * pLabelAndContent = [[LabelAndContent alloc]init];
		
		pLabelAndContent.m_strLabel		    	 = pLabel;
		pLabelAndContent.m_strContent		     = pContent;
		
		[retArray addObject:pLabelAndContent];
		
		[pLabelAndContent release];
		
		count++;
	}
	
	[stmt reset];
	
	return retArray;
}

+(void)removeAllAccounts:(ABRecordID)pRecordID
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM account_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id

	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertCertificate:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO certificate_info VALUES(?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:pContent						                forIndex:2];//2.content
	[stmt bindString:pLabel									        forIndex:3];//3.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:4];//4.index
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:5];//5.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:6];//6.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(NSArray*)getCertificate:(ABRecordID)pRecordID
{
	NSMutableArray *retArray = [[[NSMutableArray alloc] init] autorelease];
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT * FROM certificate_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pContent		    = [NSString stringWithFormat:@"%@", [stmt getString:1]];
		NSString * pLabel           = [NSString stringWithFormat:@"%@", [stmt getString:2]];
		
		LabelAndContent * pLabelAndContent = [[LabelAndContent alloc]init];
		
		pLabelAndContent.m_strLabel		    	 = pLabel;
		pLabelAndContent.m_strContent		     = pContent;
		
		[retArray addObject:pLabelAndContent];
		
		[pLabelAndContent release];
		
		count++;
	}
	
	[stmt reset];
	
	return retArray;
}

+(void)removeAllCertificate:(ABRecordID)pRecordID
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM certificate_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)removeAllRelate:(ABRecordID)pRecordID
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM relate_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(void)insertRelate:(ABRecordID)pRecordID:(ABRecordID)pRelateID:(NSString*)pLabel:(NSInteger)pIndex
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO relate_info VALUES(?,?,?,?,?,?)"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	[stmt bindString:[NSString stringWithFormat:@"%d",pRelateID]	forIndex:2];//2.relate_id
	[stmt bindString:pLabel									        forIndex:3];//3.label
	[stmt bindString:[NSString stringWithFormat:@"%d",pIndex]	    forIndex:4];//4.index
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:5];//5.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:6];//6.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(NSArray*)getRelate:(ABRecordID)pRecordID
{
	NSMutableArray *retArray = [[[NSMutableArray alloc] init] autorelease];
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT * FROM relate_info WHERE contacts_id = ?"];
	
	[stmt bindString:[NSString stringWithFormat:@"%d",pRecordID]	forIndex:1];//1.id
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pContent		    = [NSString stringWithFormat:@"%@", [stmt getString:1]];
		NSString * pLabel           = [NSString stringWithFormat:@"%@", [stmt getString:2]];
		
		LabelAndContent * pLabelAndContent = [[LabelAndContent alloc]init];
		
		pLabelAndContent.m_strLabel		    	 = pLabel;
		pLabelAndContent.m_strContent		     = pContent;
		
		[retArray addObject:pLabelAndContent];
		
		[pLabelAndContent release];
		
		count++;
	}
	
	[stmt reset];
	
	return retArray;
}

+(void)insertTag:(NSString*)pLabel
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"INSERT INTO tag_info VALUES(?,?,?,?)"];
	
	[stmt bindString:pLabel  								        forIndex:1];//1.name
	[stmt bindString:[NSString stringWithFormat:@"%d",0]	        forIndex:2];//2.type
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:3];//3.creation
	[stmt bindInt32:[[NSDate date] timeIntervalSince1970]			forIndex:4];//4.modification
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

+(NSArray*)getTags
{
	NSMutableArray *retArray = [[[NSMutableArray alloc] init] autorelease];
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"SELECT tag_name FROM tag_info"];
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pLabel           = [NSString stringWithFormat:@"%@", [stmt getString:0]];
		
		[retArray addObject:pLabel];
		
		count++;
	}
	
	[stmt reset];
	
	return retArray;
}

+(void)removeTags
{
	Statement* stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"DELETE FROM tag_info"];
	
	[stmt retain];
	[stmt step];
    [stmt reset];
	[stmt release];
}

@end
