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

-(void) menuOpenCallback:(id) pSender
{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	NSTimeZone      *timeZone  = [NSTimeZone localTimeZone];
	
	[formatter setTimeZone:timeZone];  
	[formatter setDateFormat:@"M/d/yyyy"];
	
	NSString *stringTime = [formatter stringFromDate:datePickerView.date];
	
	if([stringTime isEqualToString:@"5/12/1988"])
	{
		NSLog(@"11111111111111111");
	}
}

-(id) init
{
	if( (self=[super init]) )
	{
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite * sprite = [CCSprite spriteWithFile:@"MainBG.png"];
		sprite.position =  ccp( size.width /2 , size.height/2 );
		[self addChild:sprite];
		
		//按钮
		
		CCMenuItemSprite * menuItemOpen = 
		[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button_green_bg.png"] 
								selectedSprite:[CCSprite spriteWithFile:@"button_green_bg_current.png"] 
										target:self 
									  selector:@selector(menuOpenCallback:)];
		
		menuItemOpen.position = ccp(430,160);
		
		CCMenu * pMenu = [CCMenu menuWithItems:menuItemOpen,nil];
		pMenu.position    = CGPointZero;
		pMenu.anchorPoint = CGPointZero;
		[self addChild:pMenu];
		
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
