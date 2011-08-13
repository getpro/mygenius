//
//  CustomDatePicker.m
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomDatePicker.h"
#import "PublicData.h"

@implementation CustomDatePicker

@synthesize m_pDatePicker;

- (id)initWithFrame:(CGRect)frame target:(id)target actionCancel:(SEL)actionCancel actionDone:(SEL)actionDone
{
	if (self=[super initWithFrame:frame])
	{
		[self setUserInteractionEnabled:YES];
		
		//self.backgroundColor = [UIColor clearColor];
		
		//半透明黑色背景
		UIView * view = [[UIView alloc] initWithFrame:frame];
		
		[view setBackgroundColor:[UIColor blackColor]];
		//[view setTag:LOAD_BACKGROUND];
		[view setAlpha:0.8f];
		[self addSubview:view];
		
		[view release];
		
		
		CGRect pDatePicker = CGRectMake(0, 220, SCREEN_W, 216);
		
		m_pDatePicker = [[UIDatePicker alloc]initWithFrame:pDatePicker];
		
		m_pDatePicker.datePickerMode    = UIDatePickerModeDateAndTime;
		m_pDatePicker.minuteInterval    = 5;
		
		/*
		[m_pDatePicker addTarget:target action:action
				forControlEvents:UIControlEventValueChanged];
		*/
		
		//[m_pDatePicker addTarget:self action:@selector(touchUpOutside:)
		//		forControlEvents:UIControlEventTouchUpOutside];
		
		NSLocale * pLocale   = [[NSLocale alloc] initWithLocaleIdentifier:@"China"];
		m_pDatePicker.locale = pLocale;
		
		[pLocale release];
		
		[self addSubview:m_pDatePicker];
		
		//确定和取消
		UIToolbar * pToolbarBg = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 436, SCREEN_W, 44)];
		
		pToolbarBg.barStyle = UIBarStyleBlackOpaque;
		
		UIToolbar * pToolbarCancel = [[UIToolbar alloc]initWithFrame:CGRectMake(40, 0, 100, 44)];
		
		pToolbarCancel.barStyle = UIBarStyleBlackOpaque;
		
		UIToolbar * pToolbarDone = [[UIToolbar alloc]initWithFrame:CGRectMake(180, 0, 100, 44)];
		
		pToolbarDone.barStyle = UIBarStyleBlackOpaque;
		
		[pToolbarBg addSubview:pToolbarCancel];
		[pToolbarBg addSubview:pToolbarDone];
		
		
		UIBarButtonItem * pCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered
										   target:target action:actionCancel];
		
		pCancel.width = 89.0f;
		
		UIBarButtonItem * pDone = [[UIBarButtonItem alloc]   initWithTitle:@"确定" style:UIBarButtonItemStyleBordered
										   target:target action:actionDone];
		
		pDone.width = 89.0f;
		
		NSMutableArray * buttonCancels = [[NSMutableArray alloc] initWithCapacity:1];
		NSMutableArray * buttonDones   = [[NSMutableArray alloc] initWithCapacity:1];
		
		[buttonCancels addObject:pCancel];
		[pCancel release];
		
		[buttonDones addObject:pDone];
		[pDone release];
		
		[pToolbarCancel setItems:buttonCancels animated:NO];
		[pToolbarDone   setItems:buttonDones animated:NO];
		
		[buttonCancels release];
		[buttonDones   release];
		
		[self addSubview:pToolbarBg];
		
		[pToolbarCancel release];
		[pToolbarDone   release];
		[pToolbarBg     release];
	}
	return self;
}

- (void)dealloc
{
	[m_pDatePicker release];
	
	[super dealloc];
}

@end
