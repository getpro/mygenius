//
//  ChoiceLayer.m
//  Yeung
//
//  Created by Peteo on 12-5-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ChoiceLayer.h"

@implementation ChoiceLayer

#define ITEMOPEN ccp(200,360)

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ChoiceLayer *layer = [ChoiceLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) menuOpenCallback:(id) pSender
{
	
}

-(id) init
{
	if( (self=[super init]) )
	{
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite * sprite = [CCSprite spriteWithFile:@"MainBG.png"];
		sprite.position =  ccp( size.width /2 , size.height/2 );
		[self addChild:sprite];
		
		//
		CCMenuItemSprite * menuItemOpen = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button_green_bg.png"] 
								selectedSprite:[CCSprite spriteWithFile:@"button_green_bg_current.png"] 
										target:self 
									  selector:@selector(menuOpenCallback:)];
		
		menuItemOpen.position = ITEMOPEN;
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemOpen,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
		
		CCLabelTTF * LabelYes = [CCLabelTTF labelWithString:@"YES"
												fontName:@"Marker Felt"
												fontSize:42];
		LabelYes.position = ITEMOPEN;
		[self addChild:LabelYes];
		
		
		//
		spriteNo = [CCSprite spriteWithFile:@"button_green_bg.png"];
		spriteNo.position = ccp(size.width/2,160);
		[self addChild:spriteNo];
		
		CCLabelTTF * label = [CCLabelTTF labelWithString:@"NO"
												fontName:@"Marker Felt"
												fontSize:42];
		label.position = ccp(spriteNo.contentSize.width/2,
							 spriteNo.contentSize.height/2);
		[spriteNo addChild:label];
		
		self.isTouchEnabled = YES;
	}
	
	return self;
}


-(CGPoint) RandomPos
{
	CGPoint pRet;
	
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	CGFloat w = spriteNo.contentSize.width;
	CGFloat h = spriteNo.contentSize.height;
    
    while (1) 
    {
        pRet.x = arc4random()%(int)(size.width -w) + w/2;
        pRet.y = arc4random()%(int)(size.height-h) + h/2;
        
        CGRect pRect = 
        
        CGRectMake(ITEMOPEN.x - spriteNo.contentSize.width *1.5f,
                   ITEMOPEN.y - spriteNo.contentSize.height*1.5f,
                   spriteNo.contentSize.width*3,
                   spriteNo.contentSize.height*3);
        
        if(!CGRectContainsPoint(pRect, pRet))
        {
            break;
        }
        
    }
	
	return  pRet;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	CGRect pRect = 
	
	CGRectMake(spriteNo.position.x - spriteNo.contentSize.width *0.5f,
			   spriteNo.position.y - spriteNo.contentSize.height*0.5f,
			   spriteNo.contentSize.width,
			   spriteNo.contentSize.height);
	
	if(CGRectContainsPoint(pRect,touchLocation))
	{
		NSLog(@"3333");
        
        CCMoveTo * pMoveTo = [CCMoveTo actionWithDuration:0.2f position:[self RandomPos]];
        
        [spriteNo runAction:pMoveTo];
	}
	
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGRect pRect = 
	
	CGRectMake(spriteNo.position.x - spriteNo.contentSize.width *0.5f,
			   spriteNo.position.y - spriteNo.contentSize.height*0.5f,
			   spriteNo.contentSize.width,
			   spriteNo.contentSize.height);
	
	if(CGRectContainsPoint(pRect,touchLocation))
	{
		NSLog(@"3333");
        
        CCMoveTo * pMoveTo = [CCMoveTo actionWithDuration:0.2f position:[self RandomPos]];
        
        [spriteNo runAction:pMoveTo];
	}
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGRect pRect = 
	
	CGRectMake(spriteNo.position.x - spriteNo.contentSize.width *0.5f,
			   spriteNo.position.y - spriteNo.contentSize.height*0.5f,
			   spriteNo.contentSize.width,
			   spriteNo.contentSize.height);
	
	if(CGRectContainsPoint(pRect,touchLocation))
	{
		NSLog(@"3333");
        
        CCMoveTo * pMoveTo = [CCMoveTo actionWithDuration:0.5f position:[self RandomPos]];
        
        [spriteNo runAction:pMoveTo];
	}
}	

- (void) dealloc
{
	[super dealloc];
}



@end
