//
//  DataStore.m
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataStore.h"
#import "DBConnection.h"


@implementation DataStore

//config

+(NSInteger)Get_Copy_Addressbook
{
	NSInteger pInt  = 1;
	Statement *stmt = nil;
	
    if (stmt == nil)
	{
        stmt = [DBConnection statementWithQuery:"SELECT config_copy_addressbook FROM config WHERE config_id = ? "];
        [stmt retain];
    }
    
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

+(void)insertContactsBaseInfo:(ABRecordRef)pABRecordRef
{
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
	
	[stmt bindString:[NSString stringWithFormat:@"%d",ABRecordGetRecordID(pABRecordRef)] forIndex:1];//1.contacts_id
	
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
		[stmt bindString:birthday	forIndex:18];//18.contacts_birthday
	}
	
	//读取note备忘录
	NSString *note = (NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
	if(note != nil)
	{
		[stmt bindString:note	forIndex:19];//19.contacts_note
	}
	
	//星座
	//[stmt bindString:note	forIndex:20];//20.contacts_constellation
	
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
	[stmt bindString:firstknow	forIndex:23];//23.contacts_creation
	
	//最后一次修改該条记录的时间
	NSDate *lastknow = (NSDate*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
	if(lastknow == nil)
	{
		lastknow = [NSDate date];
	}
	[stmt bindString:lastknow	forIndex:24];//24.contacts_modification
	
	
	/*
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
			
			
			
			 NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
			 if(country != nil)
			 {
			 //textView.text = [textView.text stringByAppendingFormat:@"国家：%@\n",country];
			 }
			 
			
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
	
    [stmt step];
    [stmt reset];
	[stmt release];
}

+(NSInteger)getContactsInfo:(NSMutableArray*)pArray
{
	if (pArray == nil) 
	{
		return 0;
	}
	
	Statement * stmt = nil;
	
	stmt = [DBConnection statementWithQuery:"select * from contacts_info"];
	
	NSInteger count = 0;
	
	while ([stmt step] == SQLITE_ROW)
	{
		NSString * pcontactsID           = [NSString stringWithFormat:@"%@", [stmt getString:0]];
		NSString * pcontactsName		 = [NSString stringWithFormat:@"%@", [stmt getString:1]];
		NSString * pcontactsOrganization = [NSString stringWithFormat:@"%@", [stmt getString:2]];
		NSInteger  pcontactsSex		     = [stmt getInt32:3];
		NSString * pcontactsHomeEmail    = [NSString stringWithFormat:@"%@", [stmt getString:4]];
		NSString * pcontactsWorkEmail    = [NSString stringWithFormat:@"%@", [stmt getString:5]];
		NSString * pcontactsHomeAddress  = [NSString stringWithFormat:@"%@", [stmt getString:6]];
		NSString * pcontactsWorkAddress  = [NSString stringWithFormat:@"%@", [stmt getString:7]];
		NSString * pcontactsMobilePhone  = [NSString stringWithFormat:@"%@", [stmt getString:8]];
		NSString * pcontactsIphone       = [NSString stringWithFormat:@"%@", [stmt getString:9]];
		NSString * pcontactsRecommendID  = [NSString stringWithFormat:@"%@", [stmt getString:10]];
		NSString * pcontactsRecommendName= [NSString stringWithFormat:@"%@", [stmt getString:11]];
		NSString * pcontactsRelationID   = [NSString stringWithFormat:@"%@", [stmt getString:12]];
		NSString * pcontactsRelationName = [NSString stringWithFormat:@"%@", [stmt getString:13]];
		
		contactsInfo * pContactsInfo = [[contactsInfo alloc]init];
		
		pContactsInfo.m_strcontactsID			 = pcontactsID;
		pContactsInfo.m_strcontactsName		     = pcontactsName;
		pContactsInfo.m_strcontactsOrganization  = pcontactsOrganization;
		pContactsInfo.m_ncontactsSex		     = pcontactsSex;
		pContactsInfo.m_strcontactsHomeEmail     = pcontactsHomeEmail;
		pContactsInfo.m_strcontactsWorkEmail	 = pcontactsWorkEmail;
		pContactsInfo.m_strcontactsHomeAddress   = pcontactsHomeAddress;
		pContactsInfo.m_strcontactsWorkAddress   = pcontactsWorkAddress;
		pContactsInfo.m_strcontactsMobilePhone	 = pcontactsMobilePhone;
		pContactsInfo.m_strcontactsIphone		 = pcontactsIphone;
		pContactsInfo.m_strcontactsRecommendID   = pcontactsRecommendID;
		pContactsInfo.m_strcontactsRecommendName = pcontactsRecommendName;
		pContactsInfo.m_strcontactsRelationID	 = pcontactsRelationID;
		pContactsInfo.m_strcontactsRelationName  = pcontactsRelationName;
		
		[pArray addObject:pContactsInfo];
		
		[pContactsInfo release];
		
		count++;
	}
	
	[stmt reset];
	
	return count;
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


@end
