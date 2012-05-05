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
	}
	
	return self;
}

@end
