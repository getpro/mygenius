//
//  CAttributeRelate.h
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAttribute.h"
#import "PublicData.h"
#import "TagCell.h"
#import "ABContact.h"

@interface CAttributeRelate : CAttribute 
{
	NSString* stringValue;
	
	UINavigationController * nvController;
	
	ABContact * m_pABContact;
	
	Tag_Type m_nType;
}

@property (nonatomic, retain) NSString* stringValue;
@property (nonatomic, retain) ABContact* m_pABContact;
@property (nonatomic, assign) UINavigationController* nvController;
@property (nonatomic, assign) Tag_Type m_nType;

@end
