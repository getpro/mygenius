//
//  GuessData.m
//  DrawSomeThing
//
//  Created by Peteo on 12-4-9.
//  Copyright 2012 The9. All rights reserved.
//

#import "GuessData.h"

@implementation OC_Guess_Event

@synthesize m_nType;
@synthesize m_nIndex;
@synthesize m_nChange;
@synthesize m_fTime;

- (void) dealloc
{    
	[super dealloc];
}

- (id)init
{
	if ((self = [super init]))
    {    
		m_nType	    = 0;
		m_nIndex	= 0;
		m_nChange	= 0;
		m_fTime	    = 0.0f;
    }
    return self;
}

+(id) GuessEventWithItems:(_UINT8)pType :(_UINT8)pIndex :(_UINT8)pChange :(_FLOAT)pTime
{
	return [[[self alloc] InitGuessEvent:pType :pIndex :pChange :pTime] autorelease];
}

-(id) InitGuessEvent:	  (_UINT8)pType :(_UINT8)pIndex :(_UINT8)pChange :(_FLOAT)pTime
{
	m_nType	    = pType;
	m_nIndex	= pIndex;
	m_nChange	= pChange;
	m_fTime	    = pTime;
	
	return self;
}

@end
