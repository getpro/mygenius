//
//  DataStore.m
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataStore.h"
#import "DBConnection.h"


#define CONFIG_ID @"1001"


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
	
}

@end
