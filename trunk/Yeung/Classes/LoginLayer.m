//
//  LoginLayer.m
//  Yeung
//
//  Created by Peteo on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginLayer.h"

@implementation LoginLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LoginLayer *layer = [LoginLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) GuessWordSuccess
{
	NSLog(@"11111111111111111");
}

-(void) MoveItemDone:(id)sender
{
	CCNode * pNode = (CCNode*)sender;
	
	[self removeChild:pNode cleanup:YES];
}

-(void) menuOpenCallback:(id) pSender
{
	if(m_bIsRight)
	{
		return;
	}
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	NSTimeZone      *timeZone  = [NSTimeZone localTimeZone];
	
	[formatter setTimeZone:timeZone];  
	[formatter setDateFormat:@"M/d/yyyy"];
	
	NSString *stringTime = [formatter stringFromDate:datePickerView.date];
	
	CGSize size = [CCDirector sharedDirector].winSize;
	
	if([stringTime isEqualToString:@"5/12/1988"])
	{
		m_bIsRight = YES;
		
		CCSprite * word_guess_right = [CCSprite spriteWithSpriteFrameName:@"word_guess_right.png"];
		
		word_guess_right.position = ccp(size.width/2 + 40,820);
		
		[self addChild:word_guess_right];
		
		CCScaleTo  *  ScaleTo1 = [CCScaleTo  actionWithDuration:0.2f scale:1.3f];
		CCScaleTo  *  ScaleTo2 = [CCScaleTo  actionWithDuration:0.2f scale:1.0f];
		CCCallFunc *  CallFunc = [CCCallFunc actionWithTarget:self selector:@selector(GuessWordSuccess)];
		
		CCSequence *  ScaleTo  = [CCSequence actions:ScaleTo1,ScaleTo2,CallFunc,nil];
		
		[word_guess_right runAction:ScaleTo];
		
		//[self performSelector:@selector(GuessWordSuccess) withObject:nil afterDelay:0.5f];
	}
	else
	{
		CCLabelTTF * label = [CCLabelTTF labelWithString:@"不对"
												fontName:@"Arial"
												fontSize:42];
		label.position = ccp(size.width/2,280);
		label.color    = ccc3(255,200,28);
		[self addChild:label];
		
		CCDelayTime *  DelayTime = [CCDelayTime actionWithDuration:0.5f];
		CCFadeOut   *  FadeOut   = [CCFadeOut   actionWithDuration:0.5f];
		CCCallFuncN *  CallFunc  = [CCCallFunc  actionWithTarget:self selector:@selector(MoveItemDone:)];
		
		CCSequence *  ScaleTo  = [CCSequence actions:DelayTime,FadeOut,CallFunc,nil];
		
		[label runAction:ScaleTo];
		
		m_nWrongNum++;
		
		if(m_nWrongNum == 5)
		{
			CCLabelTTF * labelTip = [CCLabelTTF labelWithString:@"提示:"
													fontName:@"Arial"
													fontSize:62];
			labelTip.position = ccp(size.width/2,360);
			[self addChild:labelTip];
		}
	}
}

-(id) init
{
	if( (self=[super init]) )
	{
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		m_nWrongNum = 0;
		
		CCSprite * sprite = [CCSprite spriteWithFile:@"MainBG.png"];
		sprite.position =  ccp( size.width /2 , size.height/2 );
		[self addChild:sprite];
		
		CCLabelTTF * labelTip = [CCLabelTTF labelWithString:@"打开123"
												   fontName:@"Marker Felt"
												   fontSize:72];
		labelTip.position = ccp(size.width/2,680);
		[self addChild:labelTip];
		
		//按钮
		
		CCMenuItemSprite * menuItemOpen = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button_green_bg.png"] 
								selectedSprite:[CCSprite spriteWithFile:@"button_green_bg_current.png"] 
										target:self 
									  selector:@selector(menuOpenCallback:)];
		
		menuItemOpen.position = ccp(size.width/2,160);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemOpen,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
		
		CCLabelTTF * label = [CCLabelTTF labelWithString:@"打开"
												fontName:@"Marker Felt"
												fontSize:42];
		label.position = ccp(size.width/2,160);
		[self addChild:label];
		
		
		//日期
		
		CGSize datePickerSize = CGSizeMake(size.width,220);
		
		CGRect datePickerRect = CGRectMake((size.width  - datePickerSize.width)/2, 
										   (size.height - datePickerSize.height)/2,
										   datePickerSize.width,
										   datePickerSize.height);
		
		datePickerView = [[[UIDatePicker alloc] initWithFrame:datePickerRect] autorelease];
		
		datePickerView.backgroundColor  = [UIColor clearColor];
		datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		datePickerView.datePickerMode   = UIDatePickerModeDate;
		[datePickerView setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		[datePickerView setDate:[NSDate date] animated:NO];
		
		
		[[[CCDirector sharedDirector] openGLView] addSubview:datePickerView];
	}
	
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
