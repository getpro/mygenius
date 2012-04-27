//
//  CCPaint.m
//  DrawSomeThing
//
//  Created by Peteo on 12-3-31.
//  Copyright 2012 The9. All rights reserved.
//

#import "CCPaint.h"
#import "DrawData.h"
#import "CCMACRO.h"

@implementation CCPaint

@synthesize m_pDrawTrackArr;
@synthesize m_pDrawActionArr;
@synthesize m_bIsRecycling;

+(id) nodeWithFlag:(BOOL)pIsSmall
{
	return [[[self alloc] initWithFlag:pIsSmall] autorelease];
}

-(id) initWithFlag:(BOOL)pIsSmall
{
	if( (self=[super init])) 
	{
        //CGSize size = [[CCDirector sharedDirector] winSize];
		
		/*
		GLview = [[CCDirector sharedDirector] openGLView];
		
		if(pIsSmall)
		{
			tmpView = [[[UIView alloc]initWithFrame:CGRectMake( 0.0f,
															   89.0f - 35.0f,
															   PAINT_SIZE_W,
															   PAINT_SIZE_H_SMALL)] autorelease];
		}
		else
		{
			tmpView = [[[UIView alloc]initWithFrame:CGRectMake( 0.0f,
															   89.0f,
															   PAINT_SIZE_W,
															   PAINT_SIZE_H)] autorelease];
		}
		
		tmpView.userInteractionEnabled = NO;
		tmpView.backgroundColor = [UIColor clearColor];
		
		//需要移除
		[GLview addSubview:tmpView];
		 
		*/
        
		replaycurpoint   = 0;
		
		m_bImmediateShow = NO;
		
		m_bIsRecycling   = NO;
		
		m_LastTime = CFAbsoluteTimeGetCurrent();
		
		m_pDrawTrackArr  = [[NSMutableArray alloc] initWithCapacity:10];
		m_pDrawActionArr = [[NSMutableArray alloc] initWithCapacity:10];
		
		CCLayerColor * pBg = [CCLayerColor layerWithColor:ccc4(255,255,255,255) width:PAINT_SIZE_W  height:PAINT_SIZE_H];
		pBg.position = ccp(PAINT_POS_X,PAINT_POS_Y);
		[self addChild:pBg];
        
        //创建render texture,用于绘画
		//创建画布
		strokesTexture = [[CCRenderTexture renderTextureWithWidth:PAINT_SIZE_W height:PAINT_SIZE_H] retain];
		[strokesTexture setPosition:ccp(PAINT_POS_X + PAINT_SIZE_W/2,PAINT_POS_Y + PAINT_SIZE_H/2)];
		[self addChild:strokesTexture z:1];
        
		//默认黑色
		//brush = [[CCSprite spriteWithSpriteFrameName:@"dot.png"] retain];
		brush = [[CCSprite spriteWithFile:@"fire.png"] retain];
		[brush setOpacity:20];
		brush.scale	= 0.25f;
		brush.color = ccc3(0,0,0);
		
		/*
		brush.color = ccc3(0,0,0);
		//brush.scale	= 0.25f;
		brush.scale	= 0.1f;
		*/
		
		//设置混合参数
		[brush setBlendFunc: (ccBlendFunc) { GL_ONE, GL_ONE_MINUS_SRC_ALPHA }];
		
		//设置不透明度
		[brush setOpacity:200];
        self.isTouchEnabled = YES;
	}
	return self;
}

//单个点
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (isreplaying) 
	{
		return;
	}
	
	UITouch *touch = [touches anyObject];
	CGPoint start = [touch locationInView: [touch view]];
	
	start = [[CCDirector sharedDirector] convertToGL: start];
	start = [self convertToNodeSpace:start];
	
	NSLog(@"[%f][%f]",start.x,start.y);
	
	[self drawToStrokeTexture:start end:start remember:TRUE];
}

//触摸移动
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{

	// if isreplaying now, deel with pause and stop
	if (isreplaying) 
	{
		return ;
	}
	
	UITouch *touch = [touches anyObject];
	
	CGPoint start = [touch locationInView: [touch view]];	
	start = [[CCDirector sharedDirector] convertToGL: start];
	start = [self convertToNodeSpace:start];
	
	CGPoint end = [touch previousLocationInView:[touch view]];
	end = [[CCDirector sharedDirector] convertToGL:end];
	end = [self convertToNodeSpace:end];
	
	//输入区域
    //NSLog(@"%@   %@",start.x,start.y);
	
	//if((start.x >= PAINT_POS_X) && (start.x <= PAINT_SIZE_W) && (start.y >= PAINT_POS_Y) && (start.y <= PAINT_POS_Y + PAINT_SIZE_H))
	if((start.x > 0) && (start.x < 768) && (start.y > 0) && (start.y < 1024))
	{
		[self drawToStrokeTexture:start end:end remember:TRUE];
	}
}

- (void) CheckAction
{
	if([m_pDrawActionArr count] == 0)
	{
		return;
	}
	
	for(int pIndex = 0;pIndex < [m_pDrawActionArr count];pIndex++)
	{
		OC_Draw_Event * pDrawAction = (OC_Draw_Event*)[m_pDrawActionArr objectAtIndex:pIndex];
		if(pDrawAction)
		{
			if(replaycurpoint == pDrawAction.m_nIndex)
			{
				switch (pDrawAction.m_nTool)
				{
					case PaintTool_Type_Pen:
					{
						[self setPenColor:pDrawAction.m_nColor];
						[self setPenSize:pDrawAction.m_nSize];
					}
						break;
					case PaintTool_Type_Eraser:
					{
						[self setPenColor:pDrawAction.m_nColor];
						[self setPenSize:pDrawAction.m_nSize];
					}
						break;
					case PaintTool_Type_Clear:
					{
						[self RecyclePaint];
					}
						break;
					default:
						break;
				}
			}
		}
	}
}

- (void) replay :(BOOL)pSelf
{
	self.isTouchEnabled = NO;
	
	replaycurpoint = 0;
	[m_pDrawTrackArr    removeAllObjects];
	[m_pDrawActionArr   removeAllObjects];
	
	/*
	if(pSelf)
	{
		[m_pDrawTrackArr  addObjectsFromArray:[GameEngine GetInstance].m_pSelfDrawTrackArr];
		[m_pDrawActionArr addObjectsFromArray:[GameEngine GetInstance].m_pSelfDrawActionArr];
	}
	else
	{
		[m_pDrawTrackArr  addObjectsFromArray:[GameEngine GetInstance].m_pOppDrawTrackArr];
		[m_pDrawActionArr addObjectsFromArray:[GameEngine GetInstance].m_pOppDrawActionArr];
	}
	*/
	
	replaycurpoint = [m_pDrawTrackArr count];
	
	for(int pIndex = 0;pIndex < [m_pDrawActionArr count];pIndex ++)
	{
		OC_Draw_Event * pEvent = (OC_Draw_Event*)[m_pDrawActionArr objectAtIndex:pIndex];
		if(pEvent && pEvent.m_nIndex < replaycurpoint)
		{
			//m_pTrackWithAction[pEvent.m_nIndex] = 1;
			
			OC_Draw_Data * pData = (OC_Draw_Data*)[m_pDrawTrackArr objectAtIndex:pEvent.m_nIndex];
			if(pData)
			{
				pData.m_bHaveAction = YES;
			}
		}
	}
	
	//默认第一个画的时间点为0.5f
	//if([m_pDrawTimeArr count] > 0)
	{
		//NSNumber * pTime = (NSNumber*)[m_pDrawTimeArr objectAtIndex:0];
		
		//[self schedule: @selector(replayStroke:) interval:[pTime floatValue]];
		
		[self schedule: @selector(replayStroke:) interval:0.5f];
	}
}

- (void) saveplay
{	
	int NEED_MALLOC_SIZE =  (
							[m_pDrawTrackArr  count] * sizeof(Draw_Data)  +
						    [m_pDrawActionArr count] * sizeof(Draw_Event) + 
							 sizeof(_UINT32) * 3 + 
							 128
							);
	
	char * pDrawDataBuf = (char*)malloc(NEED_MALLOC_SIZE);
	
	ZEROMEMORY(pDrawDataBuf,NEED_MALLOC_SIZE);
	
	//replaycurpoint = 0;
	
	//test
	/*
	CMsgDrawPostData * pMsg = [[[CMsgDrawPostData alloc] init] autorelease];
	
	pMsg.pDrawTrackArr  = m_pDrawTrackArr;
	pMsg.pDrawActionArr = m_pDrawActionArr;
	
	int pDataSize = [pMsg Encode:pDrawDataBuf];
	
	NSData * pDrawData = [NSData dataWithBytes:pDrawDataBuf length:pDataSize];
	
	//replaycurpoint = [m_pDrawTrackArr count];
	
	NSArray  * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString * documentsDirectory = [paths objectAtIndex:0];
	
	NSString * DrawDataFilePath   = [documentsDirectory stringByAppendingPathComponent:DRAWDATA_FILE];
	
	BOOL isSaveOK = [pDrawData writeToFile:DrawDataFilePath atomically:YES];
	
	if(isSaveOK)
	{
		CCLOG(@"DRAWDATA_FILE_SaveOK[%d]",[pDrawData length]);
	}
	
	SAFE_FREE(pDrawDataBuf);
	*/
}

- (void) RecycleDone
{
	m_bIsRecycling = NO;
}

- (void) RecycleDelay
{
	//tmp.backgroundColor = [UIColor whiteColor];
	
	CATransition *transition = [CATransition animation];
	transition.duration = 0.75;
	transition.type = @"pageCurl";
	transition.subtype = kCATransitionFromBottom;
	
	[[tmpView.subviews objectAtIndex:0] removeFromSuperview];
	//[tmp insertSubview:[viewarray objectAtIndex:1] atIndex:0];
    
	[tmpView.layer addAnimation:transition forKey:nil];
	
	[self performSelector:@selector(RecycleDone) withObject:nil afterDelay:1.0f];
}

- (void) RecyclePaint
{
	if(m_bIsRecycling)
	{
		return;
	}
	
	m_bIsRecycling = YES;
	
	//[self performSelector:@selector(RecycleDelay) withObject:nil afterDelay:0.01f];
	
	/*
	CCRenderTexture *a2 = [CCRenderTexture renderTextureWithWidth:PAINT_SIZE_W 
														   height:PAINT_SIZE_H];
	[a2 beginWithClear:255 g:255 b:255 a:255];
	[a2 end];
	*/
	
	UIImageView * ImageView = [[[UIImageView alloc] initWithImage:[strokesTexture getUIImageFromBuffer]] autorelease];
	ImageView.userInteractionEnabled = NO;
	ImageView.backgroundColor = [UIColor whiteColor];
	ImageView.frame = CGRectMake(0,
								 0,
								 PAINT_SIZE_W,
								 PAINT_SIZE_H);
	
	[strokesTexture clear:0 g:0 b:0 a:0];
	
	/*
	UIImageView * BlackView = [[UIImageView alloc] initWithImage:[a2 getUIImageFromBuffer]];
	BlackView.userInteractionEnabled = NO;
	BlackView.frame = CGRectMake(0,
								 0,
								 PAINT_SIZE_W,
								 PAINT_SIZE_H);
	*/
	
	//viewarray = [[NSMutableArray alloc]init];
	//[viewarray addObject:ImageView];
	//[viewarray addObject:BlackView];
	[tmpView insertSubview:ImageView atIndex:0];
	
	[self performSelector:@selector(RecycleDelay) withObject:nil afterDelay:0.01f];
}

- (void) setPenSize  :(int)pSize
{
	switch (pSize)
	{
		case 1:
		{
			brush.scale	= 0.25f;
		}
			break;
		case 2:
		{
			brush.scale	= 0.5f;
		}
			break;
		case 3:
		{
			brush.scale	= 1.0f;
		}
			break;
		case 4:
		{
			brush.scale	= 1.5f;
		}
			break;
		default:
			break;
	}
}

- (void) AddPaintAction:(int) pToolType :(int) pColor :(int) pSize
{
	OC_Draw_Event * pDrawAction = [OC_Draw_Event DrawEventWithItems:pSize :pColor :pToolType :replaycurpoint];
	
	[m_pDrawActionArr addObject:pDrawAction];
}

- (void) setPenColor :(_UINT32)pColor
{
	//UIImage * image = nil;
	
	brush.color = ccc3(GET_RED(pColor),GET_GREEN(pColor),GET_BLUE(pColor));
}

//在画布上画笔画
- (void)drawToStrokeTexture:(CGPoint)start end:(CGPoint)end remember:(bool)remember 
{
	if (remember)
	{
		CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
		//CCLOG(@"Now[%f]",(pNow - m_LastTime));
				
		[m_pDrawTrackArr addObject:[OC_Draw_Data DrawDataWithItems:start.x :start.y :(pNow - m_LastTime)]];		
		replaycurpoint ++;
		
		[m_pDrawTrackArr addObject:[OC_Draw_Data DrawDataWithItems:end.x :end.y :0.0f]];
		replaycurpoint ++;
		
		m_LastTime = pNow;
	}
    
	// begin drawing to the upper render texture
	[strokesTexture begin];
	
	float distance = ccpDistance(start, end);
	if (distance >= 1)
	{
		int d = (int)distance;
		for (int i = 0; i < d; i++)
		{
			float difx = end.x - start.x;
			float dify = end.y - start.y;
			float delta = (float)i / distance;
			[brush setPosition:ccp(start.x + (difx * delta), start.y + (dify * delta) - PAINT_POS_Y)];
			[brush visit];
		}
	}
	else if(distance == 0)
	{
		//一个点
		
		//CCLOG(@"start[%f][%f]",start.x,start.y);
		//[brush setOpacity:255];
		[brush setPosition:ccp(start.x,start.y - PAINT_POS_Y)];
		[brush visit];
		//[brush setOpacity:180];
	}
	[strokesTexture end];
}

//回放笔画，间隔0.005秒调用replayDrawStroke
- (void)replayStroke:(ccTime)dt
{
	[self unscheduleAllSelectors];
	isreplaying = TRUE;
	
	// clear strokeTexture
	[strokesTexture clear:0 g:0 b:0 a:0];
	
	replaycurpoint    = 0;
	isreplayingpaused = FALSE;
	
	//self.isTouchEnabled = YES;
	[self schedule: @selector(replayDrawStroke:) interval:0.01];
}

//回放
- (void)replayDrawStroke:(ccTime)dt 
{
	[self unschedule:@selector(replayDrawStroke:)];
	
	if (isreplayingpaused)
		return;
	
	if(replaycurpoint >= [m_pDrawTrackArr count])
	{
		//回放结束
		[self unscheduleAllSelectors];
		//[self resetStrokeParameter];
		isreplaying = FALSE;
		return;
	}
	
	OC_Draw_Data * pValueBegin = (OC_Draw_Data*)[m_pDrawTrackArr objectAtIndex:(replaycurpoint)];
	OC_Draw_Data * pValueEnd   = (OC_Draw_Data*)[m_pDrawTrackArr objectAtIndex:(replaycurpoint + 1)];
	
	if(pValueBegin && pValueEnd)
	{
		if(pValueBegin.m_bHaveAction)
		{
			[self CheckAction];
		}
		
		CGPoint beginPos = ccp(pValueBegin.m_fX,pValueBegin.m_fY);
		
		replaycurpoint ++;
		
		if(pValueEnd.m_bHaveAction)
		{
			[self CheckAction];
		}
		
		CGPoint   endPos = ccp(pValueEnd.m_fX,pValueEnd.m_fY);
		
		replaycurpoint ++;
		
		[self drawToStrokeTexture:beginPos end:endPos remember:FALSE];
	}
	
	if(replaycurpoint < [m_pDrawTrackArr count])
	{
		OC_Draw_Data * pData = (OC_Draw_Data*)[m_pDrawTrackArr objectAtIndex:replaycurpoint];
		if(pData)
		{
			if(pData.m_fTime > MAX_PAINT_INTERVAL)
			{
				[self schedule: @selector(replayDrawStroke:) interval:MAX_PAINT_INTERVAL];
			}
			else
			{
				[self schedule: @selector(replayDrawStroke:) interval:pData.m_fTime];
			}
		}
	}
}

- (void) dealloc
{
	[tmpView removeFromSuperview];
	
	[m_pDrawActionArr release];
	[m_pDrawTrackArr  release];
	[strokesTexture   release];	
	[brush	          release];
	
	[super dealloc];
}

@end
