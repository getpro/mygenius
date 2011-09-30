//
//  DataStore.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "contactsInfo.h"


//系统设置
#define CONFIG_ID @"1001"

//分组
#define GROUP_ID  @"1101"

//自定义标签
#define TAG_ID    @"1201"

//备忘录
#define MEMO_ID   @"1501"

//联系人
#define CONTACTINFO_ID 2001

typedef enum 
{
    MultiValue_Type_Email,
    MultiValue_Type_Address,
    MultiValue_Type_Url,
	MultiValue_Type_InstantMessage,
	MultiValue_Type_Date,
	MultiValue_Type_Count
}MultiValue_Type;

@interface DataStore : NSObject 
{

}

/* config */

//0:第一次 启动程序  需要载入系统的通讯录
//1:不是第一次

+(NSInteger)Get_Copy_Addressbook;

+(void)Set_Copy_Addressbook :(NSInteger)pInt;

+(void)Set_First_Use;


/* contacts_info */

//基本信息
+(void)insertContactsBaseInfo:(ABRecordRef)pABRecordRef;

//+(NSInteger)getContactsInfo:(NSMutableArray*)pArray;

//判断RecordID是否已在库中
+(BOOL)RecordIDIsExist:(ABRecordID)pRecordID;

//判断RecordID是否被修改
+(BOOL)RecordIDIsModify:(ABRecordRef)pABRecordRef;

//email多值
+(void)insertEmails:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;

//地址多值
+(void)insertAddresses:(ABRecordID)pRecordID:(NSString*)pStreet:(NSString*)pZip
					  :(NSString*)pCity:(NSString*)pState:(NSString*)pCountry
				      :(NSString*)pLabel:(NSInteger)pIndex;

//dates多值
+(void)insertDates:(ABRecordID)pRecordID:(NSInteger)pContent:(NSString*)pLabel:(NSInteger)pIndex;

//IM多值
+(void)insertInstantMessage:(ABRecordID)pRecordID:(NSString*)pUsername:(NSString*)pService:(NSString*)pLabel:(NSInteger)pIndex;

//电话多值
+(void)insertPhones:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;

//URL多值
+(void)insertUrls:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;

@end
