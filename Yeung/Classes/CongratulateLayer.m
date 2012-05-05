//
//  CongratulateLayer.m
//  Yeung
//
//  Created by Peteo on 12-5-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CongratulateLayer.h"
#import "DrawData.h"
#import "CCMACRO.h"
#import "Packet.h"
#import "PacketDefine.h"

@implementation CongratulateLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CongratulateLayer *layer = [CongratulateLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) CreatFlower:(CGPoint)pos
{
	CCParticleSystem * emitter = [CCParticleFlower node];
	
	emitter.position = pos;
	[self addChild:emitter];
	
	emitter.texture = [[CCTextureCache sharedTextureCache] addImage: @"stars-grayscale.png"];
	
	emitter.totalParticles = 50;
	
	//emitter.life = 0.1f;
    
    emitter.scale = 0.5f;
}

-(void) menuOpenCallback:(id) pSender
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"Congratulate.dat"];
	
	const int Draw_Data_Count  = [m_pDrawTrackArr  count];
	
	int NEED_MALLOC_SIZE = (Draw_Data_Count  * sizeof(Draw_Data) + sizeof(_UINT32) * 2);
	
	char * pDrawDataBuf = (char*)malloc(NEED_MALLOC_SIZE);
	ZEROMEMORY(pDrawDataBuf,NEED_MALLOC_SIZE);
	
	EncodePacket* packet = [[[EncodePacket alloc] initWithBuffer:pDrawDataBuf] autorelease];
	
	[packet putUInt32:NEED_MALLOC_SIZE];
	
	//画的内容
	//数据
	
	Draw_Data * pDrawData = (Draw_Data*)malloc(Draw_Data_Count * sizeof(Draw_Data));
	
	for(int i = 0;i < Draw_Data_Count;i++)
	{
		OC_Draw_Data * pOC_Draw_Data = (OC_Draw_Data*)[m_pDrawTrackArr objectAtIndex:i];
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
	
    
	//总长度
	[packet putSize];
	
	
	NSData * pData = [NSData dataWithBytes:pDrawDataBuf length:[packet getSize]];
	
	[pData writeToFile:path atomically:YES];
	
	SAFE_FREE(pDrawDataBuf);
}

//回放
- (void)replayDrawStroke:(ccTime)dt 
{
	[self unschedule:@selector(replayDrawStroke:)];
    
	if(replaycurpoint >= [m_pDrawTrackArr count])
	{
		//回放结束
		[self unscheduleAllSelectors];
		return;
	}
	
	OC_Draw_Data * pValueBegin = (OC_Draw_Data*)[m_pDrawTrackArr objectAtIndex:(replaycurpoint)];
	
	if(pValueBegin)
	{
		CGPoint beginPos = ccp(pValueBegin.m_fX,pValueBegin.m_fY);
		
		replaycurpoint ++;
        
		[self CreatFlower:beginPos];
	}
	
	if(replaycurpoint < [m_pDrawTrackArr count])
	{
		OC_Draw_Data * pData = (OC_Draw_Data*)[m_pDrawTrackArr objectAtIndex:replaycurpoint];
		if(pData)
		{
            [self schedule: @selector(replayDrawStroke:) interval:pData.m_fTime/2];
		}
	}
}

-(id) init
{
	if( (self=[super init]) )
	{
        replaycurpoint = 0;
        
        m_LastTime = CFAbsoluteTimeGetCurrent();
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        m_pDrawTrackArr = [[NSMutableArray alloc] initWithCapacity:0];
		
		CCSprite * sprite = [CCSprite spriteWithFile:@"MainBG.png"];
		sprite.position =  ccp( size.width /2 , size.height/2 );
		[self addChild:sprite];
		
		//
		CCLabelTTF * label = [CCLabelTTF labelWithString:@"生日快乐！"
												fontName:@"Marker Felt"
												fontSize:62];
		label.position = ccp(size.width - 200 ,size.height - 100);
		[self addChild:label];
        
        
        //
        /*
        CCMenuItemSprite * menuItemOpen = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button_green_bg.png"] 
								selectedSprite:[CCSprite spriteWithFile:@"button_green_bg_current.png"] 
										target:self 
									  selector:@selector(menuOpenCallback:)];
		
		menuItemOpen.position = ccp(size.width - 200 ,size.height - 100);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemOpen,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
        */
		
		//
		//self.isTouchEnabled = YES;
        
        
        //LOAD
        /*
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
         
        NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"Congratulate.dat"];
        */
        
        NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Congratulate.dat"];
        
        NSData * pData = [NSData dataWithContentsOfFile:path];
        
        DecodePacket* packet = [[[DecodePacket alloc] initWithBytes:[pData bytes]] autorelease];
        
        {
            _INT32 pDataLength = [packet getUInt32];						       //数据长度
            
            _INT32 pDraw_Data_Length = ([packet getUInt32] - sizeof(_UINT32));     //画数据的长度
            
            /*
            if(pDraw_Data_Length > pDataLength)
            {
                return YES;
            }
            */
            
            _INT32 pDraw_Data_Count = pDraw_Data_Length/sizeof(Draw_Data);
            
            Draw_Data * pDraw_Data = (Draw_Data*)malloc(pDraw_Data_Length);
            ZEROMEMORY(pDraw_Data,pDraw_Data_Length);
            
            [packet getData:pDraw_Data :pDraw_Data_Length];
            
            for (int pIndex = 0; pIndex < pDraw_Data_Count; pIndex ++)
            {
                OC_Draw_Data * pOC_Draw_Data = [OC_Draw_Data DrawDataWithItems:pDraw_Data[pIndex].m_fX 
                                                                              :pDraw_Data[pIndex].m_fY
                                                                              :pDraw_Data[pIndex].m_fTime];
                
                [m_pDrawTrackArr addObject:pOC_Draw_Data];
            }
            
            SAFE_FREE(pDraw_Data);
        }
        
        
        [self schedule: @selector(replayDrawStroke:) interval:0.5f];
	}
	
	return self;
}

////

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	[self CreatFlower:touchLocation];
    
    CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
    
    [m_pDrawTrackArr addObject:[OC_Draw_Data DrawDataWithItems:touchLocation.x 
                                                              :touchLocation.y 
                                                              :(pNow - m_LastTime)]];		
    //replaycurpoint ++;

    m_LastTime = pNow;
	
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	//[self CreatFlower:touchLocation];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	//[self CreatFlower:touchLocation];
}

@end
