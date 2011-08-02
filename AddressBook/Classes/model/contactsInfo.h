//
//  contactsInfo.h
//  AddressBook
//
//  Created by unidigital UNIDIGITAL on 11-8-2.
//  Copyright 2011 unidigital. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface contactsInfo : NSObject
{
	NSString  * m_strcontactsID;
	NSString  * m_strcontactsName;
	NSInteger   m_ncontactsSex;
	NSString  * m_strcontactsOrganization;
	NSString  * m_strcontactsHomeEmail;
	NSString  * m_strcontactsWorkEmail;
	NSString  * m_strcontactsHomeAddress;
	NSString  * m_strcontactsWorkAddress;
	NSString  * m_strcontactsMobilePhone;
	NSString  * m_strcontactsIphone;
	NSString  * m_strcontactsRecommendID;
	NSString  * m_strcontactsRecommendName;
	NSString  * m_strcontactsRelationID;
	NSString  * m_strcontactsRelationName;
}

@property (nonatomic, retain) NSString*	m_strcontactsID;
@property (nonatomic, retain) NSString*	m_strcontactsName;
@property (nonatomic, assign) NSInteger	m_ncontactsSex;
@property (nonatomic, retain) NSString*	m_strcontactsOrganization;
@property (nonatomic, retain) NSString*	m_strcontactsHomeEmail;
@property (nonatomic, retain) NSString*	m_strcontactsWorkEmail;
@property (nonatomic, retain) NSString*	m_strcontactsHomeAddress;
@property (nonatomic, retain) NSString*	m_strcontactsWorkAddress;
@property (nonatomic, retain) NSString*	m_strcontactsMobilePhone;
@property (nonatomic, retain) NSString*	m_strcontactsIphone;
@property (nonatomic, retain) NSString*	m_strcontactsRecommendID;
@property (nonatomic, retain) NSString*	m_strcontactsRecommendName;
@property (nonatomic, retain) NSString*	m_strcontactsRelationID;
@property (nonatomic, retain) NSString*	m_strcontactsRelationName;


@end
