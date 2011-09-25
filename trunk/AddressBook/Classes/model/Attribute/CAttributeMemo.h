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

@interface CAttributeMemo : CAttribute 
{
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;

@end
