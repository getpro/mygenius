//
//  CAttributeConstellation.h
//  AddressBook
//
//  Created by Peteo on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  星座

#import <Foundation/Foundation.h>

#import "CAttribute.h"

@interface CAttributeConstellation : CAttribute 
{
	NSArray * m_pDateArry;
	
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;

@end
