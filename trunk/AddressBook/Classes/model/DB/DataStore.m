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


@end
