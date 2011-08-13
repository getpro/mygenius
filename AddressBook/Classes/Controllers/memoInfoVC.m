    //
//  memoInfoVC.m
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "memoInfoVC.h"
#import "AddressBookAppDelegate.h"

@implementation memoInfoVC

@synthesize m_pCustomDatePicker;

typedef enum
{
	EViewInMemo_Subject,
	EViewInMemo_Des,
	EViewInMemo_Date,
	EViewInMemo_Remind,
	EViewInMemo_Count
}EViewInMemo;

@synthesize m_pUIScrollView_IB;

-(void)myInit
{
	
}

//响应UIDatePicker事件
-(void)DonePressed:(id)sender
{
	[self SetDat];
	[m_pCustomDatePicker setHidden:YES];
}
-(void)CancelPressed:(id)sender
{
	[m_pCustomDatePicker setHidden:YES];
}


//响应日期Pressed事件
-(void)DatePressed:(id)sender
{
	[m_pCustomDatePicker setHidden:NO];
}

//响应提醒Pressed事件
-(void)RemindPressed:(id)sender
{
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	CGRect frame    = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
	frame.origin.y += ROW_OFFSET_Y;
	
	frame.size.width  = ROW_WIDTH;
	frame.size.height = ROW_HEIGHT;
	frame.origin.x    = (SCREEN_W - ROW_WIDTH )/2;
	
	
	CustomItemView * pSubject = [[CustomItemView alloc] initWithFrame:frame IsEdit:YES];
	pSubject.m_pTitle.text = @"主题";
	pSubject.tag = EViewInMemo_Subject;
	[m_pUIScrollView_IB addSubview:pSubject];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	
	CustomItemView * pDes = [[CustomItemView alloc] initWithFrame:frame IsEdit:YES];
	pDes.m_pTitle.text = @"描述";
	pDes.tag = EViewInMemo_Des;
	[m_pUIScrollView_IB addSubview:pDes];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomButtonView * pDate = [[CustomButtonView alloc] initWithFrame:frame target:self action:@selector(DatePressed:)];
	pDate.m_pTitle.text = @"日期";
	pDate.tag = EViewInMemo_Date;
	[m_pUIScrollView_IB addSubview:pDate];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomButtonView * pRemind = [[CustomButtonView alloc] initWithFrame:frame target:self action:@selector(RemindPressed:)];
	pRemind.m_pTitle.text = @"提醒";
	pRemind.tag = EViewInMemo_Remind;
	[m_pUIScrollView_IB addSubview:pRemind];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	

	/////
	[m_pUIScrollView_IB setContentSize:CGSizeMake(SCREEN_W, frame.origin.y)];
	
	CGRect pRectCustomDatePicker = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
	m_pCustomDatePicker = [[CustomDatePicker alloc]initWithFrame:pRectCustomDatePicker target:self actionCancel:@selector(CancelPressed:) actionDone:@selector(DonePressed:)];
	
	[m_pCustomDatePicker setHidden:YES];
	
	[self.view addSubview:m_pCustomDatePicker];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pUIScrollView_IB  release];
	[m_pCustomDatePicker release];
	
    [super dealloc];
}

-(IBAction)returnItemBtn: (id)sender
{
	[[AddressBookAppDelegate getAppDelegate] backScene];
}


-(IBAction)editItemBtn:   (id)sender
{
	
}


-(void)SetDat
{
	//m_pDatePicker.hidden = NO;
	
	//datepicker.date = [NSDate date];//显示默认当前时间
	
	NSDateFormatter * conversion1 = [[NSDateFormatter alloc]init];
	
	[conversion1 setDateFormat: @"yyyy-MM-dd HH:mm"];//设置时间格式
	
	CustomButtonView * pDate   = (CustomButtonView*)[self.m_pUIScrollView_IB viewWithTag:EViewInMemo_Date];
	
	pDate.m_pLabelContent.text = [conversion1 stringFromDate: [m_pCustomDatePicker.m_pDatePicker date]];
	
	[conversion1 release];
	
}

@end
