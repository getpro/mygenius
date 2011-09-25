//
//  CAttributeBlood.h
//  AddressBook
//
//  Created by Peteo on 11-9-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// 血型

#import <Foundation/Foundation.h>

#import "CAttribute.h"

@interface CAttributeBlood : CAttribute 
{
	NSArray * m_pDateArry;
	
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;

@end
