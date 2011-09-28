//
//  DataStore.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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

+(void)insertContactsInfo:(contactsInfo *)pContactsInfo;

+(NSInteger)getContactsInfo:(NSMutableArray*)pArray;

@end
