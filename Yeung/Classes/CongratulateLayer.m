//
//  CongratulateLayer.m
//  Yeung
//
//  Created by Peteo on 12-5-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CongratulateLayer.h"

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
	
	//emitter_.totalParticles = 250;
	
	//emitter.life = 0.01f;
	
	//emitter.startSize    = 30.0f;
	//emitter.startSizeVar = 10.0f;
	
	emitter.endRadius    = 10.0f;
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
		CCLabelTTF * label = [CCLabelTTF labelWithString:@"Congratulate"
												fontName:@"Marker Felt"
												fontSize:42];
		label.position = ccp(size.width/2,size.height/2);
		[self addChild:label];
		
		//
		self.isTouchEnabled = YES;
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
	
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	[self CreatFlower:touchLocation];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	[self CreatFlower:touchLocation];
}

@end
