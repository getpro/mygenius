//
//  memoInfo.m
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "memoInfo.h"


@implementation memoInfo

@synthesize m_strmemoID;
@synthesize m_strmemoSubject;
@synthesize m_strmemoDes;
@synthesize m_strmemoDate;
@synthesize m_nmemoRemind;

- (id)init
{
    if ((self = [super init]))
	{
		m_strmemoID				= nil;
		m_strmemoSubject		= nil;
		m_strmemoDes			= nil;
		m_strmemoDate           = nil;

		m_nmemoRemind	   = 0;
	}
	return self;
}

- (void)dealloc
{
	[m_strmemoID		release];
	[m_strmemoSubject	release];
	[m_strmemoDes		release];
	[m_strmemoDate      release];

    [super dealloc];
}

@end
