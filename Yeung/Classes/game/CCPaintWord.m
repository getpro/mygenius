//
//  CCPaintWord.m
//  DrawSomeThing
//
//  Created by Peteo on 12-3-31.
//  Copyright 2012 The9. All rights reserved.
//

#import "CCPaintWord.h"
#import "CCPaint.h"
#import "CCPopup.h"
#import "CCMACRO.h"
#import "Common.h"
#import "Packet.h"
#import "DrawData.h"

@interface CCPaintWord (Private)
- (void)registerAllNotifications;
- (void)removeAllNotifications;

- (void)PaintDone;
- (void)PaintReDraw;
@end

@implementation CCPaintWord

typedef enum PaintWord_Tag
{
	PaintWord_Paint_tag = 10,			//画板
	PaintWord_Pen_tag,
	PaintWord_Eraser_tag,
	
	PaintWord_Tag_Count
}PaintWord_Tag;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCPaintWord *layer = [CCPaintWord node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) colorButtonCallback:(id)pSender
{
	//[SoundHelp playEffect:TOUCH_EFFECT];
	
	NSNumber * pValue = (NSNumber*) pSender;
	CCLOG(@"colorButtonCallback[%d]",[pValue intValue]);

	ColorButton  * pColorButton = 
	[[m_pColorScrollView subviews] objectAtIndex:[pValue intValue]];
	
	if(LastColorButton)
	{
		if(pColorButton != LastColorButton)
		{
			LastColorButton.transform = CGAffineTransformMakeScale(1.0f,1.0f);
		}
	}
	
	pColorButton.transform = CGAffineTransformMakeScale(1.3f,1.3f);
	
	//Account * pAccount = [Account sharedInstance];
	
	NSNumber * pColorValue = (NSNumber*)[colorArr objectAtIndex:[pValue intValue]];
	if(pColorValue)
	{
		m_nPenColor = [pColorValue unsignedIntegerValue];
		
		CCPaint * pPaintView = (CCPaint*)[self getChildByTag:PaintWord_Paint_tag];
		if(pPaintView)
		{
			[pPaintView setPenColor:m_nPenColor];
			
			[pPaintView AddPaintAction:PaintTool_Type_Pen :m_nPenColor :m_nPenSize];
		}
	}
	
	LastColorButton = pColorButton;
}

-(void) LoadColor
{
	//系统控件
	
	m_pColorScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, COLOR_SCROLL_WIDTH, COLOR_SCROLL_HEIGTH)] autorelease];
	//[m_pColorScrollView setBackgroundColor:[UIColor greenColor]];
	
	//Account * pAccount = [Account sharedInstance];
	
	colorArr = [[NSMutableArray alloc] initWithCapacity:10];
	
	//默认的免费颜色
	/*
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(  0,  0,  0)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(255,  0,  0)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(255,255,  0)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(  0,136,255)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB( 18,224,101)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(  7,  7,252)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(150,150,150)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB( 30,225,255)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(255,162,  0)]];
	*/
	
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(  9,  9,  9)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB( 90, 90, 90)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(200,200,200)]];
	[colorArr addObject:[NSNumber numberWithUnsignedInteger:MAKE_RGB(244,200,204)]];
	
	CGFloat pWidth = 0.0f;
	
	for(int i = 0;i < [colorArr count];i++)
	{
		NSNumber * pValue = (NSNumber*)[colorArr objectAtIndex:i];
		if(pValue)
		{
			_UINT32 pColorValue = [pValue unsignedIntegerValue];
			
			UIColor * pColor = 
			[UIColor colorWithRed:GET_RED(pColorValue)/  255.0f
							green:GET_GREEN(pColorValue)/255.0f 
							 blue:GET_BLUE(pColorValue)/ 255.0f 
							alpha:1.0f];
			
			ColorButton  * pColorButton = [[[ColorButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) 
																		Color:pColor] autorelease];
			
			
			[pColorButton setFrame:CGRectMake(pWidth, (m_pColorScrollView.frame.size.height - pColorButton.frame.size.height)/2 , pColorButton.frame.size.width, pColorButton.frame.size.height)];
			[pColorButton setTag:i];
			
			pColorButton.m_pCB		 = @selector(colorButtonCallback:);
			pColorButton.m_pTarget   = self;
			
			[m_pColorScrollView addSubview:pColorButton];
			
			pWidth += pColorButton.frame.size.width;
			
			[m_pColorScrollView setContentSize:CGSizeMake(pWidth, COLOR_SCROLL_HEIGTH)];
		}
	}
	
	[[[CCDirector sharedDirector] openGLView] addSubview:m_pColorScrollView];
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) 
	{
		[self registerAllNotifications];
		
		m_bIsWaiting = NO;
		
		LastColorButton = nil;
		
		CGSize size = [CCDirector sharedDirector].winSize;
		
		//默认黑色
		m_nPenColor = MAKE_RGB(0,0,0);
		m_nPenSize  = 1;
		
		//背景
		CCSprite * game_bg = [CCSprite spriteWithFile:@"game_bg.png"];
		game_bg.position = ccp(size.width/2,size.height/2);
		[self addChild:game_bg];
		
		//Top
		CCSprite * paint_top_bg = [CCSprite spriteWithSpriteFrameName:@"paint_top_bg.png"];
		paint_top_bg.position = ccp(size.width/2,size.height - paint_top_bg.contentSize.height/2);
		[self addChild:paint_top_bg];
		
		//Bottom
		CCSprite * paint_bottom_bg = [CCSprite spriteWithSpriteFrameName:@"paint_bottom_bg.png"];
		paint_bottom_bg.position = ccp(size.width/2,paint_bottom_bg.contentSize.height/2);
		[self addChild:paint_bottom_bg];
		
		//笔
		CCSprite * game_pencil = [CCSprite spriteWithSpriteFrameName:@"game_pencil.png"];
		game_pencil.position = ccp(58,size.height - paint_top_bg.contentSize.height/2 - 8);
		[self addChild:game_pencil];
		
		///////
		/*
		int pColor_Bg_H = size.height - paint_top_bg.contentSize.height;
		
		CCMenuItemSprite * menuItemMoreColor = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_more_color.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_more_colorSel.png"] target:self selector:@selector(menuMoreColorCallback:)];
		menuItemMoreColor.position    = ccp(size.width  - menuItemMoreColor.contentSize.width/2  -5,
											pColor_Bg_H - menuItemMoreColor.contentSize.height/2 -5);
		
		*/
		[self LoadColor];
		
		//添加画板
		CCPaint * pPaintView   = [CCPaint nodeWithFlag:NO];
		
		pPaintView.position    = ccp((size.width - PAINT_SIZE_W)/2,122.0f);
		pPaintView.anchorPoint = CGPointZero;
		pPaintView.tag         = PaintWord_Paint_tag;
		
		//pPaintView.scale = 2.0f;
		
		[self addChild:pPaintView];
        
        //
        CCSprite * pDamon  = [CCSprite spriteWithFile:@"damon.png"];
        pDamon.position    = ccp(size.width/2,560.0f);
        pDamon.opacity     = 100;
        [self addChild:pDamon];
		
		CCMenuItemSprite * menuItemRecycle = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_recycle.png"] selectedSprite:nil target:self selector:@selector(menuRecycleCallback:)];
		menuItemRecycle.position = ccp(343,35);
		
		CCMenuItemSprite * menuItemDone = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_done.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_doneSel.png"] target:self selector:@selector(menuDoneCallback:)];
		menuItemDone.position    = ccp(530,35);
		
		CCMenuItemSprite * menuItemPen = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_pen.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_penSel.png"] target:self selector:@selector(menuPenCallback:)];
		menuItemPen.position    = ccp(52,35);
		
		CCMenuItemSprite * menuItemEraser = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_eraser.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"drawing_eraserSel.png"] target:self selector:@selector(menuEraserCallback:)];
		menuItemEraser.position = ccp(128,35);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemRecycle,menuItemDone,menuItemPen,menuItemEraser,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
		
		///
		
		CCPopup * PenPopup   = [CCPopup node];
		PenPopup.m_pCB		 = @selector(menuPenPopUpCallback:);
		PenPopup.m_pTarget   = self;
		PenPopup.position    = ccp(10,32);
		PenPopup.tag         = PaintWord_Pen_tag;
		PenPopup.anchorPoint = CGPointZero;
		[self addChild:PenPopup];
		
		CCPopup * EraserPopup   = [CCPopup node];
		EraserPopup.m_pCB		= @selector(menuEraserPopUpCallback:);
		EraserPopup.m_pTarget   = self;
		EraserPopup.position    = ccp(80,32);
		EraserPopup.tag			= PaintWord_Eraser_tag;
		EraserPopup.anchorPoint = CGPointZero;
		[self addChild:EraserPopup];
		
		self.isTouchEnabled = YES;
	}
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
	CCPopup * PenPopup   = (CCPopup*)[self getChildByTag:PaintWord_Pen_tag];
	if(PenPopup)
	{
		[PenPopup ShrinkMenu];
	}

	CCPopup * EraserPopup   = (CCPopup*)[self getChildByTag:PaintWord_Eraser_tag];
	if(EraserPopup)
	{
		[EraserPopup ShrinkMenu];
	}
	
    return NO;
}

-(void) menuPenPopUpCallback:(id)	 pSender
{	
	NSNumber * pValue = (NSNumber*) pSender;
	CCLOG(@"PenPopUp[%d]",[pValue intValue]);
	
	CCPaint * pPaintView = (CCPaint*)[self getChildByTag:PaintWord_Paint_tag];
	
	m_nPenSize = [pValue intValue];
	
	[pPaintView setPenSize:m_nPenSize];
	
	[pPaintView setPenColor:m_nPenColor];
	
	[pPaintView AddPaintAction:PaintTool_Type_Pen :m_nPenColor :m_nPenSize];
}

-(void) menuEraserPopUpCallback:(id) pSender
{
	NSNumber * pValue = (NSNumber*) pSender;
	CCLOG(@"EraserPopUp[%d]",[pValue intValue]);
	
	CCPaint * pPaintView = (CCPaint*)[self getChildByTag:PaintWord_Paint_tag];
	
	if(pPaintView)
	{
		[pPaintView setPenColor:MAKE_RGB(255,255,255)];
		
		m_nPenSize = [pValue intValue];
		
		[pPaintView setPenSize:m_nPenSize];
		
		[pPaintView AddPaintAction:PaintTool_Type_Eraser :MAKE_RGB(255,255,255) :m_nPenSize];
	}
}

-(void) menuDoneCallback:(id) pSender
{
	/*
	if([GameEngine GetInstance].m_bIsLoading || m_bIsWaiting)
	{
		return;
	}
	
	[PaintDoneAlertView show];
	*/
	
	//test
	BOOL success = NO;
	//NSError * error;
	//NSFileManager *fm = [NSFileManager defaultManager];
	
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"Draw.dat"];
	//NSString *pathAction = [documentsDirectory stringByAppendingPathComponent:@"Action.dat"];
	
	CCPaint * pPaintView = (CCPaint*)[self getChildByTag:PaintWord_Paint_tag];
	
	//success = [pPaintView.m_pDrawTrackArr  writeToFile:pathTrack  atomically:YES];
	
	//success = [pPaintView.m_pDrawActionArr writeToFile:pathAction atomically:YES];
	
	/////
	
	const int Draw_Data_Count  = [pPaintView.m_pDrawTrackArr  count];
	const int Draw_Event_Count = [pPaintView.m_pDrawActionArr count];
	
	int NEED_MALLOC_SIZE = (Draw_Data_Count  * sizeof(Draw_Data)  +
						    Draw_Event_Count * sizeof(Draw_Event) + sizeof(_UINT32) * 3);
	
	char * pDrawDataBuf = (char*)malloc(NEED_MALLOC_SIZE);
	ZEROMEMORY(pDrawDataBuf,NEED_MALLOC_SIZE);
	
	EncodePacket* packet = [[[EncodePacket alloc] initWithBuffer:pDrawDataBuf] autorelease];
	
	[packet putUInt32:NEED_MALLOC_SIZE];
	
	//画的内容
	//数据
	
	Draw_Data * pDrawData = (Draw_Data*)malloc(Draw_Data_Count * sizeof(Draw_Data));
	
	for(int i = 0;i < Draw_Data_Count;i++)
	{
		OC_Draw_Data * pOC_Draw_Data = (OC_Draw_Data*)[pPaintView.m_pDrawTrackArr objectAtIndex:i];
		if(pOC_Draw_Data)
		{
			pDrawData[i].m_fX    = pOC_Draw_Data.m_fX;
			pDrawData[i].m_fY    = pOC_Draw_Data.m_fY;
			pDrawData[i].m_fTime = pOC_Draw_Data.m_fTime;
		}
	}
	
	//长度
	[packet putUInt32:(sizeof(_UINT32) + Draw_Data_Count * sizeof(Draw_Data))];
	//数据
	[packet putData:pDrawData :Draw_Data_Count * sizeof(Draw_Data)];
	
	SAFE_FREE(pDrawData);
	/////////////
	
	
	//事件
	Draw_Event * pDrawEvent = (Draw_Event*)malloc(Draw_Event_Count * sizeof(Draw_Event));
	
	for(int i = 0;i < Draw_Event_Count;i++)
	{
		OC_Draw_Event * pOC_Draw_Event = (OC_Draw_Event*)[pPaintView.m_pDrawActionArr objectAtIndex:i];
		if(pOC_Draw_Event)
		{
			pDrawEvent[i].m_nColor = pOC_Draw_Event.m_nColor;
			pDrawEvent[i].m_nIndex = pOC_Draw_Event.m_nIndex;
			pDrawEvent[i].m_nSize  = pOC_Draw_Event.m_nSize;
			pDrawEvent[i].m_nTool  = pOC_Draw_Event.m_nTool;
		}
	}
	
	//长度
	[packet putUInt32:(sizeof(_UINT32) + Draw_Event_Count * sizeof(Draw_Event))];
	//数据
	[packet putData:pDrawEvent :Draw_Event_Count * sizeof(Draw_Event)];
	
	SAFE_FREE(pDrawEvent);
	
	//总长度
	[packet putSize];
	
	
	NSData * pData = [NSData dataWithBytes:pDrawDataBuf length:[packet getSize]];
	
	success = [pData writeToFile:path atomically:YES];
	
	SAFE_FREE(pDrawDataBuf);
	
}

-(void) LoadColorDelay
{
	/*
	Account * pAccount = [Account sharedInstance];
	
	CGFloat pWidth = 0.0f;
	
	for(int i = 0;i < [pAccount.colorArr count];i++)
	{
		NSNumber * pValue = (NSNumber*)[pAccount.colorArr objectAtIndex:i];
		if(pValue)
		{
			_UINT32 pColorValue = [pValue unsignedIntegerValue];
			
			UIColor * pColor = 
			[UIColor colorWithRed:GET_RED(pColorValue)/  255.0f
							green:GET_GREEN(pColorValue)/255.0f 
							 blue:GET_BLUE(pColorValue)/ 255.0f 
							alpha:1.0f];
			
			ColorButton  * pColorButton = [[[ColorButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) 
																		Color:pColor] autorelease];
			
			
			[pColorButton setFrame:CGRectMake(pWidth, (m_pColorScrollView.frame.size.height - pColorButton.frame.size.height)/2 , pColorButton.frame.size.width, pColorButton.frame.size.height)];
			[pColorButton setTag:i];
			
			pColorButton.m_pCB		 = @selector(colorButtonCallback:);
			pColorButton.m_pTarget   = self;
			
			[m_pColorScrollView addSubview:pColorButton];
			
			pWidth += pColorButton.frame.size.width;
			
			[m_pColorScrollView setContentSize:CGSizeMake(pWidth, COLOR_SCROLL_HEIGTH)];
		}
	}
	*/
}

-(void) buyColorCallback
{
	NSLog(@"buyColorCallback");
	
	for(ColorButton * pColorButton in [m_pColorScrollView subviews])
	{
		[pColorButton removeFromSuperview];
	}
	
	LastColorButton = nil;
	
	[m_pColorScrollView setContentSize:CGSizeMake(0, COLOR_SCROLL_HEIGTH)];
	
	[self performSelector:@selector(LoadColorDelay) withObject:nil afterDelay:0.1f];
}

-(void) menuMoreColorCallback:(id) pSender
{
	/*
	ColorShopView *colorShopView = [[[NSBundle mainBundle] loadNibNamed:@"ColorShopView" owner:self options:nil] lastObject];
	colorShopView.m_pTarget = self;
	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.2f;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromRight; 
    [GameEngine GoToUIView:colorShopView withTransition:animation];
	*/
}

-(void) menuRecycleCallback:(id) pSender
{
	/*
	if([GameEngine GetInstance].m_bIsLoading || m_bIsWaiting)
	{
		return;
	}
	
	[PaintReDrawAlertView show];
	*/
}

-(void) menuPenCallback:(id)    pSender
{
	CCPopup * PenPopup   = (CCPopup*)[self getChildByTag:PaintWord_Pen_tag];
	if(PenPopup)
	{
		[PenPopup ClickMainMenu];
	}
	CCPopup * EraserPopup   = (CCPopup*)[self getChildByTag:PaintWord_Eraser_tag];
	if(EraserPopup)
	{
		[EraserPopup ShrinkMenu];
	}
}

-(void) menuEraserCallback:(id) pSender
{
	CCPopup * PenPopup   = (CCPopup*)[self getChildByTag:PaintWord_Pen_tag];
	if(PenPopup)
	{
		[PenPopup ShrinkMenu];
	}
	CCPopup * EraserPopup   = (CCPopup*)[self getChildByTag:PaintWord_Eraser_tag];
	if(EraserPopup)
	{
		[EraserPopup ClickMainMenu];
	}
}

- (void) dealloc
{
	[self removeAllNotifications];
	
	[colorArr release];
	
	[super dealloc];
}

- (void)PaintDone
{
	CCPaint * pPaintView = (CCPaint*)[self getChildByTag:PaintWord_Paint_tag];
	if(pPaintView)
	{
		//[pPaintView saveplay];
		
		/*
		CMsgDrawPostData * pMsg = [[[CMsgDrawPostData alloc] init] autorelease];
		pMsg.pDrawTrackArr  = pPaintView.m_pDrawTrackArr;
		pMsg.pDrawActionArr = pPaintView.m_pDrawActionArr;
		pMsg.m_strUserA = [Account getMail];
		pMsg.m_strUserB = [GameEngine GetInstance].m_pCurGameInfo.partnerNames;
		pMsg.m_nWordID  = [GameEngine GetInstance].m_pCurWord.word_id;
		
		m_bIsWaiting = YES;
		
		[[SockEngine GetSockEngine] AppendRequest:pMsg];
		[[SockEngine GetSockEngine] setDelegate:self];
		
		[[GameEngine GetInstance] ShowLoading:[[CCDirector sharedDirector] openGLView]];
		*/
	}
}

- (void)PaintReDraw
{
	CCPaint * pPaintView = (CCPaint*)[self getChildByTag:PaintWord_Paint_tag];
	if(pPaintView)
	{
		if(pPaintView.m_bIsRecycling)
			return;
		
		[pPaintView RecyclePaint];
		
		[pPaintView AddPaintAction:PaintTool_Type_Clear :m_nPenColor :m_nPenSize];
	}
}

- (void)registerAllNotifications
{
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PaintDone)   name:PaintDoneNotification   object:nil];
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PaintReDraw) name:PaintReDrawNotification object:nil];
}

- (void)removeAllNotifications
{
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:PaintDoneNotification   object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:PaintReDrawNotification object:nil];
}

@end
