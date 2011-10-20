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
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

#import "ABContactsHelper.h"
#import "LabelAndContent.h"

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


//运营商规则
+(NSArray*)getServicerRules;
+(void)removeServicerRules;
+(void)insertServicerRule:(NSString*)pLabel :(NSString*)pContent;

/* contacts_info */

//删除联系人
+(void)RemoveContact:(ABRecordRef)pABRecordRef;

//基本信息
+(void)insertContactsBaseInfo:(ABRecordRef)pABRecordRef;
+(void)updateContactsBaseInfo:(ABRecordRef)pABRecordRef;
+(void)removeContactsBaseInfo:(ABRecordRef)pABRecordRef;

//+(NSInteger)getContactsInfo:(NSMutableArray*)pArray;

//判断RecordID是否已在库中
+(BOOL)RecordIDIsExist:(ABRecordID)pRecordID;

//判断RecordID是否被修改
+(BOOL)RecordIDIsModify:(ABRecordRef)pABRecordRef;

//email多值
+(void)insertEmails:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;
+(void)removeEmails:(ABRecordID)pRecordID;


//地址多值
+(void)insertAddresses:(ABRecordID)pRecordID:(NSString*)pStreet:(NSString*)pZip
					  :(NSString*)pCity:(NSString*)pState:(NSString*)pCountry
				      :(NSString*)pLabel:(NSInteger)pIndex;
+(void)removeAddresses:(ABRecordID)pRecordID;


//dates多值
+(void)insertDates:(NSString*)pIdentifier:(ABRecordID)pRecordID:(NSInteger)pContent:(NSString*)pLabel:(NSInteger)pIndex:(NSInteger)pRemind:(NSInteger)pType;
+(void)removeDateEvent:(NSString*)pIdentifier;
+(void)upDateEvent:(NSString*)pIdentifier:(EKEvent*)pEvent;
+(void)removeDates:(ABRecordID)pRecordID;
//移除日历中的event
+(void)removeDatesEvents:(ABRecordID)pRecordID;
+(NSArray*)getDates:(ABRecordID)pRecordID:(NSInteger)pType;

//IM多值
+(void)insertInstantMessage:(ABRecordID)pRecordID:(NSString*)pUsername:(NSString*)pService:(NSString*)pLabel:(NSInteger)pIndex:(NSInteger)pType;
+(void)removeInstantMessage:(ABRecordID)pRecordID:(NSInteger)pType;
+(NSArray*)getInstantMessages:(ABRecordID)pRecordID:(NSInteger)pType;

//电话多值
+(void)insertPhones:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;
+(void)removePhones:(ABRecordID)pRecordID;

//URL多值
+(void)insertUrls:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;
+(void)removeUrls:(ABRecordID)pRecordID;


//分组
//添加新分组
+(void)insertGroup:(ABGroup *)pNew;

//修改联系人的分组信息
+(void)updateGroupID:(ABRecordID)pRecordID:(ABRecordID)pGroupID;

+(ABRecordID)GetGroupID:(NSString *)pName;

+(NSString*)GetGroupName:(ABRecordID)pGroupID;

+(ABRecordID)GetGroupID2:(ABRecordID)pRecordID;




//高级信息
+(void)updateGroup:(ABRecordID)pRecordID:(ABRecordID)pGroupID;

//血型
+(void)updateBlood:(ABRecordID)pRecordID:(NSString*)pStr;
+(NSString*)getBlood:(ABRecordID)pRecordID;

//星座
+(void)updateConstellation:(ABRecordID)pRecordID:(NSString*)pStr;
+(NSString*)getConstellation:(ABRecordID)pRecordID;

//推荐人
+(void)updateRecommend:(ABRecordID)pRecordID:(ABRecordID)pRecommendID;
+(ABRecordID)getRecommend:(ABRecordID)pRecordID;

//帐号
+(void)insertAccounts:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;
+(NSArray*)getAccounts:(ABRecordID)pRecordID;
+(void)removeAllAccounts:(ABRecordID)pRecordID;

//身份证
+(void)insertCertificate:(ABRecordID)pRecordID:(NSString*)pContent:(NSString*)pLabel:(NSInteger)pIndex;
+(NSArray*)getCertificate:(ABRecordID)pRecordID;
+(void)removeAllCertificate:(ABRecordID)pRecordID;

//相关联系人
+(void)insertRelate:(ABRecordID)pRecordID:(ABRecordID)pRelateID:(NSString*)pLabel:(NSInteger)pIndex;
+(NSArray*)getRelate:(ABRecordID)pRecordID;
+(void)removeAllRelate:(ABRecordID)pRecordID;

//标签
+(void)insertTag:(NSString*)pLabel;
+(void)removeTags;
+(NSArray*)getTags;

@end
