//
//  CAttributeRecommend.h
//  AddressBook
//
//  Created by Peteo on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  推荐人

#import <Foundation/Foundation.h>

#import "CAttribute.h"
#import "ABContact.h"

@interface CAttributeRecommend : CAttribute 
{
	NSString* stringValue;
	
	UINavigationController * nvController;
	
	ABContact * m_pABContact;
}

@property (nonatomic, retain) NSString* stringValue;
@property (nonatomic, retain) ABContact* m_pABContact;
@property (nonatomic, assign) UINavigationController* nvController;

@end
