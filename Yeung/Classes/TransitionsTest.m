//
// Transitions Demo
// a cocos2d example
// http://www.cocos2d-iphone.org
//

#import "TransitionsTest.h"
#import "ChoiceLayer.h"

#define TRANSITION_DURATION (1.0f)
#define PIC_MAX				(13)

@interface FadeWhiteTransition : CCTransitionFade
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface FlipXLeftOver : CCTransitionFlipX 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface FlipXRightOver : CCTransitionFlipX 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface FlipYUpOver : CCTransitionFlipY 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface FlipYDownOver : CCTransitionFlipY 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface FlipAngularLeftOver : CCTransitionFlipAngular 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface FlipAngularRightOver : CCTransitionFlipAngular 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface ZoomFlipXLeftOver : CCTransitionZoomFlipX 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface ZoomFlipXRightOver : CCTransitionZoomFlipX 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface ZoomFlipYUpOver : CCTransitionZoomFlipY 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface ZoomFlipYDownOver : CCTransitionZoomFlipY 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface ZoomFlipAngularLeftOver : CCTransitionZoomFlipAngular 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface ZoomFlipAngularRightOver : CCTransitionZoomFlipAngular 
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface TransitionPageForward : CCTransitionPageTurn
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end
@interface TransitionPageBackward : CCTransitionPageTurn
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end


@implementation FlipXLeftOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationLeftOver];
}
@end
@implementation FadeWhiteTransition
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s withColor:ccWHITE];
}
@end

@implementation FlipXRightOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationRightOver];
}
@end
@implementation FlipYUpOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationUpOver];
}
@end
@implementation FlipYDownOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationDownOver];
}
@end
@implementation FlipAngularLeftOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationLeftOver];
}
@end
@implementation FlipAngularRightOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationRightOver];
}
@end
@implementation ZoomFlipXLeftOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationLeftOver];
}
@end
@implementation ZoomFlipXRightOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationRightOver];
}
@end
@implementation ZoomFlipYUpOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationUpOver];
}
@end
@implementation ZoomFlipYDownOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationDownOver];
}
@end
@implementation ZoomFlipAngularLeftOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationLeftOver];
}
@end
@implementation ZoomFlipAngularRightOver
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s orientation:kOrientationRightOver];
}
@end

@implementation TransitionPageForward
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s backwards:NO];
}
@end

@implementation TransitionPageBackward
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s backwards:YES];
}
@end

static int sceneIdx = 0;

static NSString *tips[] = 
{
	@"进门的鞋柜旁边：",
	@"餐厅的水杯上：",
	@"冰箱上：",
	@"打开冰箱：",
	@"餐桌上：",
	@"外卖单：",
    @"镜子上：",
    @"宠物：",
    @"电视机上：",
    @"书桌柜：",
    @"台灯：",
    @"衣柜门上：",
    @"Pad上："
};

static NSString *transitions[] = 
{
	@"CCTransitionJumpZoom",
	@"CCTransitionCrossFade",
	@"CCTransitionRadialCCW",
	@"CCTransitionRadialCW",
	@"TransitionPageForward",
	@"TransitionPageBackward",
	@"CCTransitionFadeTR",
	@"CCTransitionFadeBL",
	@"CCTransitionFadeUp",
	@"CCTransitionFadeDown",
	@"CCTransitionTurnOffTiles",
	@"CCTransitionSplitRows",
	@"CCTransitionSplitCols",
	@"CCTransitionFade",
	@"FadeWhiteTransition",
	@"FlipXLeftOver",
	@"FlipXRightOver",
	@"FlipYUpOver",
	@"FlipYDownOver",
	@"FlipAngularLeftOver",
	@"FlipAngularRightOver",
	@"ZoomFlipXLeftOver",
	@"ZoomFlipXRightOver",
	@"ZoomFlipYUpOver",
	@"ZoomFlipYDownOver",
	@"ZoomFlipAngularLeftOver",
	@"ZoomFlipAngularRightOver",
	@"CCTransitionShrinkGrow",
	@"CCTransitionRotoZoom",
	@"CCTransitionMoveInL",
	@"CCTransitionMoveInR",
	@"CCTransitionMoveInT",
	@"CCTransitionMoveInB",
	@"CCTransitionSlideInL",
	@"CCTransitionSlideInR",
	@"CCTransitionSlideInT",
	@"CCTransitionSlideInB",
};

Class nextTransition(void);
Class backTransition(void);
Class restartTransition(void);

Class nextTransition()
{	
	// HACK: else NSClassFromString will fail
	[CCTransitionRadialCCW node];
	
	sceneIdx++;
	sceneIdx = sceneIdx % ( sizeof(transitions) / sizeof(transitions[0]) );
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}

Class backTransition()
{
	// HACK: else NSClassFromString will fail
	[CCTransitionFade node];
	
	sceneIdx--;
	int total = ( sizeof(transitions) / sizeof(transitions[0]) );
	if( sceneIdx < 0 )
		sceneIdx += total;
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}

Class restartTransition()
{
	// HACK: else NSClassFromString will fail
	[CCTransitionFade node];
	
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}

@implementation TextLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TextLayer *layer = [TextLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) 
	{
		float x,y;
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		x = size.width;
		y = size.height;
		
		CCLayerColor * pLayerColor = [CCLayerColor layerWithColor:ccc4(255,255,255,255)
															width:size.width
														   height:size.height];
		[self addChild:pLayerColor];
		
		
		NSString * picName = [NSString stringWithFormat:@"pic%d.png",sceneIdx+1];
		
		CCSprite * sprite = [CCSprite spriteWithFile:picName];
		sprite.position =  ccp( size.width /2 , size.height/2 );
		[self addChild:sprite];
		
		/*
		CCLabelTTF *title = [CCLabelTTF labelWithString:transitions[sceneIdx] fontName:@"Thonburi" fontSize:40];
		[self addChild:title];
		[title setColor:ccc3(255,32,32)];
		[title setPosition: ccp(x/2, y-100)];
        */
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:tips[sceneIdx] fontName:@"Marker Felt" fontSize:64];
		[label setColor:ccc3(16,16,255)];
		[label setPosition: ccp(x/2,y/2+300)];	
		[self addChild: label];
		
		// menu
		/*
		CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"b1.png" selectedImage:@"b2.png" target:self selector:@selector(backCallback:)];
		CCMenuItemImage *item2 = [CCMenuItemImage itemFromNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(restartCallback:)];
		CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"f1.png" selectedImage:@"f2.png" target:self selector:@selector(nextCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:item1, item2, item3, nil];
		menu.position = CGPointZero;
		item1.position = ccp( size.width/2 - 100,30);
		item2.position = ccp( size.width/2, 30);
		item3.position = ccp( size.width/2 + 100,30);
		[self addChild: menu z:1];
		*/
		
		CCMenuItemSprite * menuItemNext = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button_green_bg.png"] 
								selectedSprite:[CCSprite spriteWithFile:@"button_green_bg_current.png"] 
										target:self 
									  selector:@selector(nextCallback:)];
		
		menuItemNext.position = ccp(size.width/2,160);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemNext,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
		
		CCLabelTTF * LabelNext = [CCLabelTTF labelWithString:@"NEXT"
													fontName:@"Marker Felt"
													fontSize:42];
		LabelNext.position = ccp(size.width/2,160);
		[self addChild:LabelNext];
		
	}
	
	return self;
}

- (void) dealloc
{
	NSLog(@"------> Scene#1 dealloc!");
	[super dealloc];
}

-(void) nextCallback:(id) sender
{
	Class transition = nextTransition();
	
	if(sceneIdx >= PIC_MAX)
	{
		[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:[ChoiceLayer scene]]];
	}
	else
	{
		CCScene *s2 = [TextLayer2 node];
		[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:s2]];
	}
}	

-(void) backCallback:(id) sender
{
	Class transition = backTransition();
	CCScene *s2 = [TextLayer2 node];
	[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:s2]];
}	

-(void) restartCallback:(id) sender
{
	Class transition = restartTransition();
	CCScene *s2 = [TextLayer2 node];
	[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:s2]];
}

-(void) onEnter
{
	[super onEnter];
	NSLog(@"Scene 1 onEnter");
}

-(void) onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
	NSLog(@"Scene 1: transition did finish");
}

-(void) onExit
{
	[super onExit];
	NSLog(@"Scene 1 onExit");
}

@end


///////////////////////////////////////////////////



@implementation TextLayer2

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TextLayer2 *layer = [TextLayer2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
		
		float x,y;
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		x = size.width;
		y = size.height;
		
		CCLayerColor * pLayerColor = [CCLayerColor layerWithColor:ccc4(255,255,255,255)
															width:size.width
														   height:size.height];
		[self addChild:pLayerColor];
		
		
		
		NSString * picName = [NSString stringWithFormat:@"pic%d.png",sceneIdx+1];
		
		CCSprite * sprite = [CCSprite spriteWithFile:picName];
		sprite.position =  ccp( size.width /2 , size.height/2 );
		[self addChild:sprite];
		
        /*
		CCLabelTTF *title = [CCLabelTTF labelWithString:transitions[sceneIdx] fontName:@"Thonburi" fontSize:40];
		[self addChild:title];
		[title setColor:ccc3(255,32,32)];
		[title setPosition: ccp(x/2, y-100)];
        */
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:tips[sceneIdx] fontName:@"Marker Felt" fontSize:64];
		[label setColor:ccc3(16,16,255)];
		[label setPosition: ccp(x/2,y/2+300)];
		[self addChild: label];
		
		// menu
		/*
		CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"b1.png" selectedImage:@"b2.png" target:self selector:@selector(backCallback:)];
		CCMenuItemImage *item2 = [CCMenuItemImage itemFromNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(restartCallback:)];
		CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"f1.png" selectedImage:@"f2.png" target:self selector:@selector(nextCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:item1, item2, item3, nil];
		menu.position = CGPointZero;
		item1.position = ccp( size.width/2 - 100,30);
		item2.position = ccp( size.width/2, 30);
		item3.position = ccp( size.width/2 + 100,30);
		[self addChild: menu z:1];
		*/
		
		//
		CCMenuItemSprite * menuItemNext = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button_green_bg.png"] 
								selectedSprite:[CCSprite spriteWithFile:@"button_green_bg_current.png"] 
										target:self 
									  selector:@selector(nextCallback:)];
		
		menuItemNext.position = ccp(size.width/2,160);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemNext,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
		
		CCLabelTTF * LabelNext = [CCLabelTTF labelWithString:@"NEXT"
												   fontName:@"Marker Felt"
												   fontSize:42];
		LabelNext.position = ccp(size.width/2,160);
		[self addChild:LabelNext];
		
	}
	
	return self;
}

- (void) dealloc
{
	NSLog(@"------> Scene#2 dealloc!");
	[super dealloc];
}


-(void) nextCallback:(id) sender
{
	Class transition = nextTransition();
	
	if(sceneIdx >= PIC_MAX)
	{
		[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:[ChoiceLayer scene]]];
	}
	else
	{
		CCScene *s2 = [CCScene node];
		[s2 addChild: [TextLayer node]];
		[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:s2]];
	}
}

-(void) backCallback:(id) sender
{
	Class transition = backTransition();
	CCScene *s2 = [CCScene node];
	[s2 addChild: [TextLayer node]];
	[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:s2]];
}	

-(void) restartCallback:(id) sender
{
	Class transition = restartTransition();
	CCScene *s2 = [CCScene node];
	[s2 addChild: [TextLayer node]];
	[[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:s2]];
}

/// callbacks 
-(void) onEnter
{
	[super onEnter];
	NSLog(@"Scene 2 onEnter");
}

-(void) onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
	NSLog(@"Scene 2: transition did finish");
}

-(void) onExit
{
	[super onExit];
	NSLog(@"Scene 2 onExit");
}
@end


///////////////


@implementation PreTestLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PreTestLayer *layer = [PreTestLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) 
	{
		float x,y;
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		x = size.width;
		y = size.height;
		
		CCLayerColor * pLayerColor = [CCLayerColor layerWithColor:ccc4(255,255,255,255)
															width:size.width
														   height:size.height];
		[self addChild:pLayerColor];
		
	
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"幸福，\r\n有时候不需要刻意制造更多浪漫，\r\n买多么贵重的礼物⋯⋯⋯\r\n幸福，\r\n可以只是简单的一句嘱托，一句感情的表达⋯⋯⋯" 
                                             dimensions:CGSizeMake(700,600) 
                                              alignment:CCTextAlignmentLeft
                                               fontName:@"Marker Felt" fontSize:42];
		[label setColor:ccc3(16,16,255)];
		[label setPosition: ccp(x/2,y/2 + 100)];	
		[self addChild: label];
		
		
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"在微博上面看到的一个小故事\r\n我以后也会那么体贴的哦！" 
                                             dimensions:CGSizeMake(700,600) 
                                              alignment:CCTextAlignmentLeft
                                               fontName:@"Marker Felt" fontSize:32];
		[label2 setColor:ccc3(0,0,0)];
		[label2 setPosition: ccp(x/2,y/2 - 300)];	
		[self addChild: label2];
        
		
		CCMenuItemSprite * menuItemNext = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button_green_bg.png"] 
								selectedSprite:[CCSprite spriteWithFile:@"button_green_bg_current.png"] 
										target:self 
									  selector:@selector(nextCallback:)];
		
		menuItemNext.position = ccp(size.width/2,160);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemNext,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
		
		CCLabelTTF * LabelNext = [CCLabelTTF labelWithString:@"NEXT"
													fontName:@"Marker Felt"
													fontSize:42];
		LabelNext.position = ccp(size.width/2,160);
		[self addChild:LabelNext];
		
	}
	
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

-(void) nextCallback:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:
     [CCTransitionPageTurn transitionWithDuration:1.0f
                         scene:[TextLayer scene]
                    backwards:kOrientationLeftOver]];
}	


@end


