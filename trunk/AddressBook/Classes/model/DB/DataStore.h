//
//  DataStore.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "contactsInfo.h"

#define CONFIG_ID @"1001"

#define GROUP_ID  @"1101"

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
