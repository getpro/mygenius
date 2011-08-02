//
//  contactsInfo.m
//  AddressBook
//
//  Created by unidigital UNIDIGITAL on 11-8-2.
//  Copyright 2011 unidigital. All rights reserved.
//

#import "contactsInfo.h"


@implementation contactsInfo

@synthesize m_strcontactsID;
@synthesize m_strcontactsName;
@synthesize m_ncontactsSex;
@synthesize m_strcontactsOrganization;
@synthesize m_strcontactsHomeEmail;
@synthesize m_strcontactsWorkEmail;
@synthesize m_strcontactsHomeAddress;
@synthesize m_strcontactsWorkAddress;
@synthesize m_strcontactsMobilePhone;
@synthesize m_strcontactsIphone;
@synthesize m_strcontactsRecommendID;
@synthesize m_strcontactsRecommendName;
@synthesize m_strcontactsRelationID;
@synthesize m_strcontactsRelationName;

- (id)init
{
    if ((self = [super init]))
	{
		m_strcontactsID				= nil;
		m_strcontactsName			= nil;
		m_strcontactsOrganization   = nil;
		m_strcontactsHomeEmail      = nil;
		m_strcontactsWorkEmail      = nil;
		m_strcontactsHomeAddress    = nil;
		m_strcontactsWorkAddress    = nil;
		m_strcontactsMobilePhone    = nil;
		m_strcontactsIphone         = nil;
		m_strcontactsRecommendID    = nil;
		m_strcontactsRecommendName	= nil;
		m_strcontactsRelationID     = nil;
		m_strcontactsRelationName   = nil;
		
		m_ncontactsSex	   = 0;
	}
	return self;
}

- (void)dealloc
{
	[m_strcontactsID			release];
	[m_strcontactsName			release];
	[m_strcontactsOrganization	release];
	[m_strcontactsHomeEmail		release];
	[m_strcontactsWorkEmail		release];
	[m_strcontactsHomeAddress	release];
	[m_strcontactsWorkAddress	release];
	[m_strcontactsMobilePhone	release];
	[m_strcontactsIphone		release];
	[m_strcontactsRecommendID	release];
	[m_strcontactsRecommendName release];
	[m_strcontactsRelationID	release];
	[m_strcontactsRelationName  release];
	
    [super dealloc];
}

@end
