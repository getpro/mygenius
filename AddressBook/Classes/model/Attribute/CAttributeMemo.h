//
//  CAttributeMemo.h
//  AddressBook
//
//  Created by Peteo on 11-9-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  纪念日

#import <Foundation/Foundation.h>
#import "CAttribute.h"
#import "PublicData.h"
#import "EditableCell.h"

@interface CAttributeMemo : CAttribute 
{
	NSString* stringValue;
	
	UINavigationController * nvController;
	
	//EditableCell* m_pCell;
	
	Tag_Type m_nType;
}

@property (nonatomic, retain) NSString* stringValue;
@property (nonatomic, assign) UINavigationController* nvController;
@property (nonatomic, assign) Tag_Type m_nType;

@end
