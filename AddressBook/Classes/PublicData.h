//
//  PublicData.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBConnection.h"
#import "DataStore.h"

#import "contactsInfo.h"

#define SCREEN_W 320.0f
#define SCREEN_H 480.0f

#define ROW_OFFSET_Y 15
#define ROW_WIDTH	 302
#define ROW_HEIGHT   52

#define FONT_NAME @"Arial"

//Address Book contact
#define KPHONELABELDICDEFINE	@"KPhoneLabelDicDefine"
#define KPHONENUMBERDICDEFINE	@"KPhoneNumberDicDefine"
#define KPHONENAMEDICDEFINE		@"KPhoneNameDicDefine"

typedef enum 
{
	Tag_Type_None,
    Tag_Type_Memo,           //纪念日
	Tag_Type_Account,	     //帐号
	Tag_Type_Certificate,    //证件
	Tag_Type_Relate,         //相关联系人
	Tag_Type_InstantMessage, //IM帐号
	Tag_Type_Count
}Tag_Type;

typedef enum
{
	ChangeAddress_Type_Account,	      //帐号
	ChangeAddress_Type_Certificate,   //证件
	ChangeAddress_Type_Count
}ChangeAddress_Type;

/*
 
 界面的索引
 
 0 m_pAddressBookVC 通讯录
 1 m_paccountsVC    帐号管理
 2 m_pdateVC;       日期提醒
 3 m_pmemoVC;       备忘录
 4 m_psettingVC;    设置
 5 m_pAddressInfoVC 通讯录介绍
 6 m_pAddressEditVC 通讯录编辑
 7 m_pAddressAddMoreVC 通讯录添加 
*/
typedef enum 
{
    EViewAddressBook = 0,
	EViewAccounts,
	EViewDate,
	EViewMemo,
	EViewSetting,
	EViewAddressInfo,
	EViewAddressEdit,
	EViewAddressAddMore,
	EViewmemoInfoVC
}EViewIndex;


//界面切换方向

BOOL rightOrLeft;
//界面切换特效
BOOL teXiao;

//返回界面的id号
int backSceneID;

@interface PublicData : NSObject 
{

}

@end
