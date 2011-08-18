//
//  Waiting.m
//  punchball
//
//  Created by Peteo on 11-8-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Waiting.h"


@implementation Waiting

@synthesize delegate;

+(Scene *) scene : (id<WaitReturnDelegate>) _delegate
{
	// 'scene' is an autorelease object.
	Scene *scene = [Scene node];
	
	// 'layer' is an autorelease object.
	Waiting * layer = [Waiting node];
	layer.delegate  = _delegate;
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) Return: (id) sender
{	
	if(delegate)
	{
		[delegate WaitReturn];
	}
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]))
	{
		// ask director the the window size
		CGSize size = [[Director sharedDirector] winSize];
		
		Sprite *bg = [Sprite spriteWithFile:@"bg.png"];
		bg.anchorPoint = ccp(0.0f,0.0f);	
		[self addChild:bg z:0];
		
		Label* label = [Label labelWithString: @"Loading ..." fontName: @"Marker Felt" fontSize: 64 ];
		
		label.position = CGPointMake(size.width / 2 , size.height / 2 );
		
		[self addChild:label];
		
		//返回按钮
		MenuItemImage * returnImg = [MenuItemImage itemFromNormalImage:@"b_back.png" selectedImage:@"b_back_s.png" target:self selector:@selector(Return:)];
		CGRect pReturnImgRect = [returnImg rect];
		Menu * returnMenu = [Menu menuWithItems: returnImg, nil];
		returnMenu.position = cpv(0 + pReturnImgRect.size.width / 2, size.height - pReturnImgRect.size.height / 2);
		[self addChild:returnMenu z:1];
		
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
