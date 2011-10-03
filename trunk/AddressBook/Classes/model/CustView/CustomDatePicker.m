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
@synthesize Target;
@synthesize Selector;

- (id)initWithFrame:(CGRect)frame
{
	if (self=[super initWithFrame:frame])
	{
		[self setUserInteractionEnabled:YES];
		// Initialization code.
		//黑色背景阴影
		UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
		
		[view setBackgroundColor:[UIColor blackColor]];
		//[view setTag:LOAD_BACKGROUND];
		[view setAlpha:0.6f];
		[self addSubview:view];
		
		//sourceArray = [[NSArray alloc]initWithObjects: @"iOS应用软件开发", @"iOS企业OA开发",@"iOS定制应用", @"iOS游戏开发", nil];
		
		//CGRect pFrame = CGRectMake(0, 200, SCREEN_W, SCREEN_H - 200);
		//pickerSheet = [[UIActionSheet alloc] initWithFrame:pFrame];
		//pickerSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
		
		UIToolbar * toolbar = [UIToolbar new];
		toolbar.barStyle = UIBarStyleBlackOpaque;
		
		// size up the toolbar and set its frame
		[toolbar sizeToFit];
		//CGFloat toolbarHeight = [toolbar frame].size.height;
		//CGRect mainViewBounds = self.view.bounds;
		[toolbar setFrame:CGRectMake(0,230,SCREEN_W,40)];
		[self addSubview:toolbar];
		
		
		UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
									   initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
									   target:self action:@selector(pickerHideCancel)];
		
		cancelItem.style = UIBarButtonItemStyleBordered;
		
		// flex item used to separate the left groups items and right grouped items
		UIBarButtonItem *flexItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				   target:nil
																				   action:nil];
		
		UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				   target:nil
																				   action:nil];
		
		UIBarButtonItem *donelItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered 
																	 target:self action:@selector(pickerHideOK)];
		
		donelItem.style = UIBarButtonItemStyleBordered;
		
		NSArray *items = [NSArray arrayWithObjects: cancelItem, flexItem1,flexItem2,donelItem, nil];
		[toolbar setItems:items animated:NO];
		
		
		
		m_pDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
		//datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		m_pDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
		m_pDatePicker.frame = CGRectMake(0, 270, SCREEN_W, 250);
		
		[self addSubview:m_pDatePicker];
		
	}
	return self;
}

- (void)dealloc
{
	[m_pDatePicker release];
	
	[super dealloc];
}

-(void)pickerHideOK
{
	if (Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:m_pDatePicker.date];
	}
	
	[self removeFromSuperview];
}

-(void)pickerHideCancel
{
	[self removeFromSuperview];
}

@end
