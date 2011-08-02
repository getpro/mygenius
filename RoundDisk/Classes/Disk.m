//
//  Disk.m
//  RoundDisk
//
//  Created by msh on 11-6-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Disk.h"


@implementation Disk

+ (id)scene
{
	CCScene *scene = [CCScene node];
	CCLayer *layer = [Disk node];
	[scene addChild:layer];
	
	return scene;
}

- (id)init
{
	if((self = [super init])) {
		CCLOG(@"MainScene init");
		
		
		CGSize size = [[CCDirector sharedDirector]winSize];
		
		//背景
		
		Bg = [CCSprite spriteWithFile:@"BackGound.png"];
		Bg.position = ccp(size.width/2,size.height/2);
		[self addChild:Bg];
		
		roundDisk = [CCSprite spriteWithFile:@"disk.png"];
		roundDisk.position = ccp(size.width/2,size.height/2);
		
		[self addChild:roundDisk];
		diskRotation = 0;
		self.isTouchEnabled = YES;
		[self scheduleUpdate];
		
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)update:(ccTime)delta
{
	roundDisk.rotation = diskRotation;//调整roundDisk偏转角度
	
	if (fabs(angleBeforeTouchesEnd)>0.0001)
	{
		angleBeforeTouchesEnd=angleBeforeTouchesEnd*0.99;
		diskRotation+=angleBeforeTouchesEnd;
	}
	else angleBeforeTouchesEnd = 0;
	
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	angleBeforeTouchesEnd = 0;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	
	CGPoint firstLocation = [touch previousLocationInView:[touch view]];
	CGPoint location = [touch locationInView:[touch view]];
	

	CGPoint touchingPoint = [[CCDirector sharedDirector] convertToGL:location];
	CGPoint firstTouchingPoint = [[CCDirector sharedDirector] convertToGL:firstLocation];
	
	CGPoint firstVector = ccpSub(firstTouchingPoint, roundDisk.position);//计算出两点之间的向量
	CGFloat firstRotateAngle = -ccpToAngle(firstVector);//计算出弧度，结果等于 x＊M_PI
	CGFloat previousTouch = CC_RADIANS_TO_DEGREES(firstRotateAngle);//转换成度
	
	CGPoint vector = ccpSub(touchingPoint, roundDisk.position);//
	CGFloat rotateAngle = -ccpToAngle(vector);//
	CGFloat currentTouch = CC_RADIANS_TO_DEGREES(rotateAngle);//
	angleBeforeTouchesEnd = currentTouch - previousTouch;

	diskRotation += currentTouch - previousTouch;//
	
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}
@end
