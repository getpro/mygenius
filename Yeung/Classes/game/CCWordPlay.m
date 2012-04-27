//
//  CCWordPlay.m
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//

#import "CCWordPlay.h"
#import "CCPaint.h"
#import "CCWordRePlay.h"
#import "CCMACRO.h"
#import "CCScrollLayer.h"

@interface CCWordPlay (Private)
- (void)registerAllNotifications;
- (void)removeAllNotifications;

- (void)WordPass;
- (void)checkBombsCount;
@end

@implementation CCWordPlay

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCWordPlay *layer = [CCWordPlay node];
	
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
		[self registerAllNotifications];
		
		m_bIsReplay = NO;
		
		[self InitWordPlay];
		
		[self InitWordArea];
		
		[self InitAnswerArea];
		
		m_bIsWaiting = NO;
		
		isWin		 = NO;
		
		CGSize size = [CCDirector sharedDirector].winSize;
		
		//背景
		CCSprite * game_bg = [CCSprite spriteWithFile:@"game_bg.png"];
		game_bg.position = ccp(size.width/2,size.height/2);
		[self addChild:game_bg];
		
		CCSprite * paint_top_bg = [CCSprite spriteWithSpriteFrameName:@"paint_top_bg.png"];
		paint_top_bg.position = ccp(size.width/2,size.height - paint_top_bg.contentSize.height/2);
		[self addChild:paint_top_bg];
		
		//笔
		/*
		CCSprite * game_pencil = [CCSprite spriteWithSpriteFrameName:@"game_pencil.png"];
		game_pencil.position = ccp(78,456);
		[self addChild:game_pencil];
		*/
		
		//添加画板
		CCPaint * pPaintView = [CCPaint nodeWithFlag:YES];
		pPaintView.position    = ccp(0.0f,0.0f);
		pPaintView.anchorPoint = CGPointZero;
		
		// Create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages).
		CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [NSArray arrayWithObjects:pPaintView,nil] widthOffset: 0.5f * size.width horizontal:NO];
		scroller.marginOffset = 0.5f * size.width;
		scroller.position     = ccp(0.0f,92.0f);
		scroller.oriPos       = ccp(0.0f,92.0f);
		[scroller setClippingRegion:CGRectMake(0.0f,92.0f + 43.0f,PAINT_SIZE_W,PAINT_SIZE_H - 43.0f)];
		[self addChild:scroller z:0];
		
		[pPaintView replay:NO];
		
		//炸弹
		CCMenuItemSprite * menuItemzhadan = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"word_zhadan.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"word_zhadanSel.png"] target:self selector:@selector(menuZhaDanCallback:)];
		menuItemzhadan.position = ccp(size.width - menuItemzhadan.contentSize.width/2,WORD_POS.y + menuItemzhadan.contentSize.height/2 - 12);
		
		
		//删除答案
		CCMenuItemSprite * menuItemDelAnswer = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"word_delall.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"word_delallSel.png"] target:self selector:@selector(menuDelAnswerCallback:)];
		menuItemDelAnswer.position = ccp(size.width - menuItemDelAnswer.contentSize.width/2 - 5,ANSWER_POS.y);
		
		//模式切换
		CCMenuItemSprite * menuItemChange = 
		//[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"change_bushou.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"change_bushouSel.png"] target:self selector:@selector(menuChangeCallback:)];
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"change_pinyin.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"change_pinyinSel.png"] target:self selector:@selector(menuChangeCallback:)];
		menuItemChange.position = ccp(menuItemChange.contentSize.width/2 + 5,ANSWER_POS.y);
		
		//重播
		CCMenuItemSprite * menuItemReplay = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"word_replay.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"word_replaySel.png"] target:self selector:@selector(menuReplayCallback:)];
		menuItemReplay.position = ccp(menuItemReplay.contentSize.width/2 + 5,size.height - 55 - menuItemReplay.contentSize.height/2);
		
		//放弃
		CCMenuItemSprite * menuItemSkip = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"word_giveup.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"word_giveupSel.png"] target:self selector:@selector(menuPassCallback:)];
		menuItemSkip.position = ccp(size.width - menuItemSkip.contentSize.width/2 - 5,size.height - paint_top_bg.contentSize.height - menuItemSkip.contentSize.height/2);
		
		CCMenu * pMenu = [CCMenu menuWithItems:/*menuItemReplay,*/menuItemSkip,menuItemzhadan,menuItemDelAnswer/*,menuItemChange*/,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu z:2];
	}
	return self;
}

-(void) NotifiyPass
{
	
}

-(void) NotifiySuccess
{
	[self Success];
	
	isWin = YES;
	
	m_bIsWaiting = YES;
}

- (void) dealloc
{
	[self removeAllNotifications];
	
	[super dealloc];
}

-(void) menuReplayCallback:(id) pSender
{
	
}

-(void) menuReOrderCallback:(id) pSender
{
	//重排
	[self ReOrderChoice];
}

-(void) menuZhaDanCallback:(id) pSender
{
	CCMenuItemSprite * pZhaDan = (CCMenuItemSprite*)pSender;
	
	[self UseBomb];
	
	[self checkBombsCount];
	
	pZhaDan.normalImage = [CCSprite spriteWithSpriteFrameName:@"word_zhadanSel.png"];
	[pZhaDan setIsEnabled:NO];
}

-(void) menuDelAnswerCallback:(id) pSender
{
	//放回所有
	[self RemoveAnswer];
}

-(void) menuChangeCallback:(id) pSender
{
	CCMenuItemSprite * menuItemChange = (CCMenuItemSprite*)pSender;
	
	[self ChangeMode];
	
	if(m_bIsPingYin)
	{
		[menuItemChange setNormalImage:[CCSprite spriteWithSpriteFrameName:@"change_bushou.png"]];
		[menuItemChange setSelectedImage:[CCSprite spriteWithSpriteFrameName:@"change_bushouSel.png"]];
	}
	else
	{
		[menuItemChange setNormalImage:[CCSprite spriteWithSpriteFrameName:@"change_pinyin.png"]];
		[menuItemChange setSelectedImage:[CCSprite spriteWithSpriteFrameName:@"change_pinyinSel.png"]];
	}
}

-(void) menuPassCallback:(id) pSender
{
	//跳过，也要发送自己猜的数据
	
	//[WordPassAlertView show];
}

- (void)checkBombsCount {
    if (bombsCountLabel.contentSize.width > BADGE_RATE) {
        bombBGSprite.scaleX = bombsCountLabel.contentSize.width / BADGE_RATE;
    }
}

- (void)WordPass
{
	[self Pass];
	
	isWin = NO;
	
	/*
	
	CMsgGuessPostData * pMsg = [[[CMsgGuessPostData alloc] init] autorelease];
	
	pMsg.pReplayListArr		  = m_pReplayListArr;
	pMsg.pPinYinChoiceArr     = m_pChoiceArr1;
	pMsg.pBuShouChoiceArr     = m_pChoiceArr2;
	
	pMsg.m_strUserA		= [Account getMail];
	pMsg.m_strUserB		= [GameEngine GetInstance].m_pCurGameInfo.partnerNames;
	pMsg.m_nWordID		= [GameEngine GetInstance].m_pCurWord.word_id;
	pMsg.m_nWordLevel   = [GameEngine GetInstance].m_pCurWord.word_level - 1;
	pMsg.m_nResult      = 0;
	
	[[SockEngine GetSockEngine] AppendRequest:pMsg];
	[[SockEngine GetSockEngine] setDelegate:self];
	
	m_bIsWaiting = YES;
	
	[[GameEngine GetInstance] ShowLoading:[[CCDirector sharedDirector] openGLView]];
	*/
}

- (void)registerAllNotifications;
{
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WordPass) name:WordPassNotification object:nil];
}

- (void)removeAllNotifications
{
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:WordPassNotification   object:nil];
}

@end
