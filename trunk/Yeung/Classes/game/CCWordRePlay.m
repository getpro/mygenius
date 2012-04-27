//
//  CCWordRePlay.m
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//

#import "CCWordRePlay.h"
#import "CCWordPlay.h"
#import "CCScrollLayer.h"
#import "CCPaint.h"
#import "CCMACRO.h"

@implementation CCWordRePlay

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCWordRePlay *layer = [CCWordRePlay node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) 
	{
		m_bIsReplay = YES;
		
		[self LoadWordPlay];
		
		[self InitWordRePlay];
		
		[self InitWordArea];
		
		[self InitAnswerArea];
		
		CGSize size = [CCDirector sharedDirector].winSize;
		
		//背景
		CCSprite * game_bg = [CCSprite spriteWithFile:@"game_bg.png"];
		game_bg.position = ccp(size.width/2,size.height/2);
		[self addChild:game_bg];
		
		CCSprite * paint_top_bg = [CCSprite spriteWithSpriteFrameName:@"paint_top_bg.png"];
		paint_top_bg.position = ccp(size.width/2,size.height - paint_top_bg.contentSize.height/2);
		[self addChild:paint_top_bg];
		
		//笔
		CCSprite * game_pencil = [CCSprite spriteWithSpriteFrameName:@"game_pencil.png"];
		game_pencil.position = ccp(78,456);
		[self addChild:game_pencil];
		
		
		//添加画板
		CCPaint * pPaintView = [CCPaint nodeWithFlag:YES];
		pPaintView.position    = ccp(0,0);
		pPaintView.anchorPoint = CGPointZero;
		
		
		// Create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages).
		CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [NSArray arrayWithObjects:pPaintView,nil] widthOffset: 0.0f * size.width horizontal:NO];
		scroller.marginOffset = 0.3f * size.width;
		scroller.position     = ccp(0.0f,92.0f);
		scroller.oriPos       = ccp(0.0f,92.0f);
		[scroller setClippingRegion:CGRectMake(0.0f,92.0f + 43.0f,PAINT_SIZE_W,PAINT_SIZE_H - 43.0f)];
		[self addChild:scroller z:0];
		
		[pPaintView replay:YES];
		
		//炸弹
		/*
		CCMenuItemSprite * menuItemzhadan = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"word_zhadan.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"word_zhadanSel.png"] target:self selector:@selector(menuZhaDanCallback:)];
		menuItemzhadan.position = ccp(290,WORD_POS.y + menuItemzhadan.contentSize.height/2 - 12);
		*/
		m_pWord_Zhadan = [CCSprite spriteWithSpriteFrameName:@"word_zhadan.png"];
		m_pWord_Zhadan.position = ccp(290,WORD_POS.y + m_pWord_Zhadan.contentSize.height/2 - 12);
		[self addChild:m_pWord_Zhadan];
		
		//删除答案
		/*
		CCMenuItemSprite * menuItemDelAnswer = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"word_delall.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"word_delallSel.png"] target:self selector:@selector(menuDelAnswerCallback:)];
		menuItemDelAnswer.position = ccp(size.width - menuItemDelAnswer.contentSize.width/2 - 5,ANSWER_POS.y);
		*/
		CCSprite * word_delall = [CCSprite spriteWithSpriteFrameName:@"word_delall.png"];
		word_delall.position = ccp(size.width - word_delall.contentSize.width/2 - 5,ANSWER_POS.y);
		[self addChild:word_delall z:2];
		
		//部首切换
		//m_pWord_Mode = [CCSprite spriteWithSpriteFrameName:@"change_bushou.png"];
		m_pWord_Mode = [CCSprite spriteWithSpriteFrameName:@"change_pinyin.png"];
		m_pWord_Mode.position = ccp(m_pWord_Mode.contentSize.width/2 + 5,ANSWER_POS.y);
		[self addChild:m_pWord_Mode z:2];
		
		//跳过
		CCMenuItemSprite * menuItemSkip = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"word_skip.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"word_skipSel.png"] target:self selector:@selector(menuSkipCallback:)];
		menuItemSkip.position = ccp(size.width - menuItemSkip.contentSize.width/2 - 5,size.height - 55 - menuItemSkip.contentSize.height/2);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemSkip,nil];
		pMenu.position	  = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu z:2];
		
		if([m_pReplayListArr count] > 0)
		{
			OC_Guess_Event * pEvent = (OC_Guess_Event*)[m_pReplayListArr objectAtIndex:0];
			if(pEvent)
			{
				//启动一个Timer
				if(pEvent.m_fTime > MAX_WORD_INTERVAL)
				{
					[self schedule:@selector(gameLoop:) interval:MAX_WORD_INTERVAL];
				}
				else
				{
					[self schedule:@selector(gameLoop:) interval:pEvent.m_fTime];
				}
			}
		}
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

/*
-(void) DelaySuccess
{
	[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:YES:GUESS_GUID]];
}

-(void) DelayPass
{
	[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:NO:GUESS_GUID]];
}
*/

-(void) NotifiyChangeMode
{
	if(m_pWord_Mode)
	{
		[self removeChild:m_pWord_Mode cleanup:YES];
	}
	
	if(m_bIsPingYin)
	{
		m_pWord_Mode = [CCSprite spriteWithSpriteFrameName:@"change_bushou.png"];
		m_pWord_Mode.position = ccp(m_pWord_Mode.contentSize.width/2 + 5,ANSWER_POS.y);
		[self addChild:m_pWord_Mode z:2];
	}
	else
	{
		m_pWord_Mode = [CCSprite spriteWithSpriteFrameName:@"change_pinyin.png"];
		m_pWord_Mode.position = ccp(m_pWord_Mode.contentSize.width/2 + 5,ANSWER_POS.y);
		[self addChild:m_pWord_Mode z:2];
	}
}

-(void) NotifiySuccess
{
	//[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:YES:GUESS_GUID]];	
}

-(void) NotifiyPass
{
	//[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:NO:GUESS_GUID]];
}

-(void) NotifiyBomb
{
	if(m_pWord_Zhadan)
	{
		[self removeChild:m_pWord_Zhadan cleanup:YES];
		
		m_pWord_Zhadan = [CCSprite spriteWithSpriteFrameName:@"word_zhadanSel.png"];
		m_pWord_Zhadan.position = ccp(290,WORD_POS.y + m_pWord_Zhadan.contentSize.height/2 - 12);
		[self addChild:m_pWord_Zhadan];
		
		//[SoundHelp playEffect:BOMB_EFFECT];
	}
}

-(void) menuZhaDanCallback:(id) pSender
{
	
}

-(void) menuDelAnswerCallback:(id) pSender
{
	
}

-(void) menuSkipCallback:(id) pSender
{
	//应该显示结果
	//再跳到结果界面
	
	if(m_bImmediateShow)
		return;
	
	m_bImmediateShow = YES;
	
	//[self schedule: @selector(gameImmediateLoop:) interval:0.0f];
	
	[self gameImmediateLoop];
	
	//[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:YES:GUESS_GUID]];
}

-(void) menuCallback:(id) pSender
{	
	
}

-(void) gameImmediateLoop
{
	OC_Guess_Event * pEvent = (OC_Guess_Event*)[m_pReplayListArr lastObject];
	if(pEvent)
	{
		if(pEvent.m_nType == Guess_Event_Type_Success)
		{
			//[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:YES:GUESS_GUID]];
		}
		else if(pEvent.m_nType == Guess_Event_Type_Pass)
		{
			//[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:NO:GUESS_GUID]];
		}
		else
		{
			//[GameEngine CCSceneToCCScene:[CCWinOrLoseLayer sceneWithIsWinFlag:NO:GUESS_GUID]];
		}
	}
}

-(void) gameLoop:(ccTime) dt
{
	[self unschedule:@selector(gameLoop:)];
	
	if(m_bImmediateShow)
		return;
	
	if([m_pReplayListArr count] == 0)
	{
		return;
	}
	
	OC_Guess_Event * pEvent = (OC_Guess_Event*)[m_pReplayListArr objectAtIndex:0];
	if(pEvent)
	{
		[self DoReplayEvent:pEvent];
		[m_pReplayListArr removeObjectAtIndex:0];
	}
	
	while([m_pReplayListArr count] > 0)
	{       
		OC_Guess_Event * pNextEvent = (OC_Guess_Event*)[m_pReplayListArr objectAtIndex:0];
		
		if(pNextEvent.m_fTime > 0.000001f)
		{
            if(pNextEvent.m_fTime > MAX_WORD_INTERVAL)
			{
				[self schedule: @selector(gameLoop:) interval:MAX_WORD_INTERVAL];
			}
			else
			{
				[self schedule: @selector(gameLoop:) interval:pNextEvent.m_fTime];
			}
			
			//[m_pReplayListArr removeObjectAtIndex:0];
			
            break;
		}
		else
		{
            [self DoReplayEvent:pNextEvent];
			[m_pReplayListArr removeObjectAtIndex:0];
		}
	}
	
	/*
	else if([m_pReplayListArr count] == 1)
	{
		OC_Guess_Event * pEvent = (OC_Guess_Event*)[m_pReplayListArr objectAtIndex:0];
		
		[self DoReplayEvent:pEvent];
		
		[m_pReplayListArr removeObjectAtIndex:0];
		
		return;
	}
	else
	{
		while ([m_pReplayListArr count] > 1) 
		{
			OC_Guess_Event * pEvent     = (OC_Guess_Event*)[m_pReplayListArr objectAtIndex:0];
			OC_Guess_Event * pNextEvent = (OC_Guess_Event*)[m_pReplayListArr objectAtIndex:1];
			
			if((pEvent == nil) || (pNextEvent == nil))
			{
				break;
			}
			
			[self DoReplayEvent:pEvent];
			
			if(pNextEvent.m_fTime != 0.0f)
			{
				if(pNextEvent.m_fTime > MAX_WORD_INTERVAL)
				{
					[self schedule: @selector(gameLoop:) interval:MAX_WORD_INTERVAL];
				}
				else
				{
					[self schedule: @selector(gameLoop:) interval:pNextEvent.m_fTime];
				}
				
				[m_pReplayListArr removeObjectAtIndex:0];
				
				break;
			}
			else
			{
				[self DoReplayEvent:pNextEvent];
				
				[m_pReplayListArr removeObjectAtIndex:0];
				[m_pReplayListArr removeObjectAtIndex:0];
			}
		}
	}
	*/
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	
}

@end
