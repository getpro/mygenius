//
//  DrawData.m
//  DrawSomeThing
//
//  Created by Peteo on 12-4-9.
//  Copyright 2012 The9. All rights reserved.
//

#import "DrawData.h"

////////////////////////////////////////
@implementation OC_Draw_Data

@synthesize m_fX;
@synthesize m_fY;
@synthesize m_fTime;
@synthesize m_bHaveAction;

- (void) dealloc
{    
	[super dealloc];
}

- (id)init
{
	if ((self = [super init]))
    {    
		m_fX	= 0.0f;
		m_fY	= 0.0f;
		m_fTime	= 0.0f;
		
		m_bHaveAction = NO;
    }
    return self;
}

+(id) DrawDataWithItems:(_FLOAT)pX :(_FLOAT)pY :(_FLOAT)pTime
{
	return [[[self alloc] InitDrawData:pX :pY :pTime] autorelease];
}

-(id) InitDrawData:		(_FLOAT)pX :(_FLOAT)pY :(_FLOAT)pTime
{
	m_fX	= pX;
	m_fY	= pY;
	m_fTime	= pTime;
	
	return self;
}
@end
////////////////////////////////////////
@implementation OC_Draw_Event

@synthesize m_nSize;
@synthesize m_nColor;
@synthesize m_nTool;
@synthesize m_nIndex;

- (void) dealloc
{    
	[super dealloc];
}

- (id)init
{
	if ((self = [super init]))
    {    
		m_nSize  = 0;
		m_nColor = MAKE_RGB(0,0,0);
		m_nTool  = 0;
		m_nIndex = 0;
    }
    return self;
}

+(id) DrawEventWithItems:(_UINT8)pSize :(_UINT32)pColor :(_UINT8)pTool :(_UINT)pIndex
{
	return [[[self alloc] InitDrawEvent:pSize :pColor :pTool :pIndex] autorelease];
}

-(id) InitDrawEvent:	 (_UINT8)pSize :(_UINT32)pColor :(_UINT8)pTool :(_UINT)pIndex
{
	m_nSize  = pSize;
	m_nColor = pColor;
	m_nTool  = pTool;
	m_nIndex = pIndex;
	
	return self;
}
@end
////////////////////////////////////////
