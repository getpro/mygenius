//
//  LabelAndContent.h
//  AddressBook
//
//  Created by Peteo on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelAndContent : NSObject 
{
	NSString  * m_strLabel;
	NSString  * m_strContent;
}

@property (nonatomic, retain) NSString*	m_strLabel;
@property (nonatomic, retain) NSString*	m_strContent;

@end

@interface date_info : NSObject
{
	NSInteger  m_nDate;
	NSString * m_pLabel;
	NSInteger  m_nRemind;
}

@property (nonatomic, retain) NSString*	m_pLabel;
@property (nonatomic, assign) NSInteger	m_nRemind;
@property (nonatomic, assign) NSInteger m_nDate;

@end