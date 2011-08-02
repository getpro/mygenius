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
