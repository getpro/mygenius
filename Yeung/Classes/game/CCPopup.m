//
//  CCPopup.m
//  DrawSomeThing
//
//  Created by Peteo on 12-4-3.
//  Copyright 2012 The9. All rights reserved.
//

#import "CCPopup.h"

@implementation CCPopup

@synthesize m_pCB;
@synthesize m_pTarget;

#define MENU_ITEM_OFFSET_Y (5.0f)

#define POPUP_TIME		   (0.2f)

- (void) dealloc
{
	
	[super dealloc];
}

-(id) init
{
	if( (self=[super init])) 
	{
        //CGSize size = [[CCDirector sharedDirector] winSize];
		
        //self.isTouchEnabled = YES;
		
		m_nIndex = 1;
		
		m_pMenu = [CCRadioMenu radioMenuWithItems:NULL];
		m_pMenu.position    = CGPointZero;
		m_pMenu.anchorPoint = CGPointZero;
		[self addChild:m_pMenu];
		
		float pOffSet_Y = (50.0f + MENU_ITEM_OFFSET_Y);
		
		for(int i = 1;i < 5;i ++)
		{
			NSString * pTemp    = [NSString stringWithFormat:@"drawing_brush%d.png"   ,i];
			NSString * pTempSel = [NSString stringWithFormat:@"drawing_brush%dSel.png",i];
			
			CCMenuItemSprite * menuItem = 
			
			[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:pTemp] selectedSprite:[CCSprite spriteWithSpriteFrameName:pTempSel] target:self selector:@selector(menuCallback:)];
			
			//menuItem.position   = ccp(menuItem.contentSize.width/2,pOffSet_Y);
			menuItem.position   = ccp(menuItem.contentSize.width/2,48);
			menuItem.tag        = i;
			
			m_pPosArr[i]        = ccp(menuItem.contentSize.width/2,pOffSet_Y);
			
			pOffSet_Y += (menuItem.contentSize.height + MENU_ITEM_OFFSET_Y);
			
			if(i == 1)
			{
				[m_pMenu setSelectedRadioItem:menuItem];
			}
			
			[menuItem setIsEnabled:NO];
			
			[m_pMenu addChild:menuItem];
		}
		
		m_bIsExpanded = false;
		
		self.visible = NO;
	}
	return self;
}

-(void) menuCallback:(id) pSender
{
	CCMenuItemImage * menuItem = (CCMenuItemImage*) pSender;
	if(menuItem)
	{
		m_nIndex = menuItem.tag;
	}
	
	//延时回调用
	[self schedule: @selector(menuDelayedCallback:) interval:0.05f];
}

-(void) menuDelayedCallback:(ccTime)dt
{
	[self unscheduleAllSelectors];
	
	[self ShrinkMenu];
	
	//通知上层Layer
	if(m_pCB && m_pTarget && [m_pTarget respondsToSelector:m_pCB])
	{
		[m_pTarget performSelector:m_pCB withObject:[NSNumber numberWithInt:m_nIndex]];
	}
}

-(void) ClickMainMenu
{
	/*
	if(m_bIsExpanded)
	{
		[self ShrinkMenu];
	}
	else
	{
		[self ExpandMenu];
	}
	*/
	
	[self ExpandMenu];
	
}

-(void) ExpandMenu
{
	if(m_bIsExpanded)
	{
		return;
	}
	
	m_bIsExpanded = true;
	
	self.visible = YES;
	
	CCMenuItem* item = nil;
	int pIndex = 0;
	CCARRAY_FOREACH(m_pMenu.children, item)
	{
		if(item) 
		{
			[item setIsEnabled:YES];
			
			if((m_nIndex-1) == pIndex)
			{
				[m_pMenu setSelectedRadioItem:item];
			}
			
			pIndex ++;
			
			CCMoveTo * MoveTo = [CCMoveTo actionWithDuration:POPUP_TIME position:m_pPosArr[item.tag]];
			CCFadeIn * FadeIn = [CCFadeIn actionWithDuration:POPUP_TIME];
			
			[item runAction:[CCSpawn actions:MoveTo,FadeIn,nil]];
		}
	}
}

-(void) ShrinkMenu
{
	if(!m_bIsExpanded)
	{
		return;
	}
	
	m_bIsExpanded = false;
	
	//self.visible = NO;
	
	CCMenuItem* item = nil;
	CCARRAY_FOREACH(m_pMenu.children, item)
	{
		if(item) 
		{
			[item setIsEnabled:NO];
			
			CCMoveTo  * MoveTo  = [CCMoveTo  actionWithDuration:POPUP_TIME position:ccp(m_pPosArr[item.tag].x,48)];
			CCFadeOut * FadeOut = [CCFadeOut actionWithDuration:POPUP_TIME];
			
			[item runAction:[CCSpawn actions:MoveTo,FadeOut,nil]];
		}
	}
}

@end
