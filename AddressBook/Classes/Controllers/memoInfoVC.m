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

typedef enum
{
	EViewInMemo_Subject = 1,
	EViewInMemo_Des,
	EViewInMemo_Date,
	EViewInMemo_Remind,
	EViewInMemo_Count
}EViewInMemo;

@synthesize m_pUIScrollView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	CGRect frame    = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
	frame.origin.y += ROW_OFFSET_Y;
	
	frame.size.width  = ROW_WIDTH;
	frame.size.height = ROW_HEIGHT;
	frame.origin.x    = (SCREEN_W - ROW_WIDTH )/2;
	
	

	/////
	[m_pUIScrollView_IB setContentSize:CGSizeMake(SCREEN_W, frame.origin.y)];
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
	
    [super dealloc];
}

-(IBAction)returnItemBtn: (id)sender
{
	
}


-(IBAction)editItemBtn:   (id)sender
{
	if([self SaveMemoInfo])
	{
		rightOrLeft = YES;
		teXiao      = YES;
	
		NSString * ss = [NSString stringWithFormat:@"%d" , EViewMemo];
	
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
	}
}


-(void)SetDat
{
	//m_pDatePicker.hidden = NO;
	
	//datepicker.date = [NSDate date];//显示默认当前时间
	
	/*
	NSDateFormatter * conversion1 = [[NSDateFormatter alloc]init];
	
	[conversion1 setDateFormat: @"yyyy-MM-dd HH:mm"];//设置时间格式
	
	CustomButtonView * pDate   = (CustomButtonView*)[self.m_pUIScrollView_IB viewWithTag:EViewInMemo_Date];
	
	if(pDate)
	{
		pDate.m_pLabelContent.text = [conversion1 stringFromDate: [m_pCustomDatePicker.m_pDatePicker date]];
	}
	
	[conversion1 release];
	*/
	
}

-(BOOL)SaveMemoInfo
{
	/*
	CustomItemView * pSubject  = (CustomItemView*)[self.m_pUIScrollView_IB viewWithTag:EViewInMemo_Subject];
	if(pSubject)
	{
		if(pSubject.m_pTextFieldContent.text == nil  || [pSubject.m_pTextFieldContent.text isEqual:@""])
		{
			//主题未填写
			UIAlertView * pAlert = [[UIAlertView alloc] initWithTitle:@"提示!"
												message:@"请填写主题!"
											   delegate:nil
									  cancelButtonTitle:@"确定"
									  otherButtonTitles:nil];
			[pAlert show];
			[pAlert release];
			
			return NO;
		}
	}
	
	CustomButtonView * pDate     = (CustomButtonView*)[self.m_pUIScrollView_IB viewWithTag:EViewInMemo_Date];
	if(pDate)
	{
		if(pDate.m_pLabelContent.text == nil)
		{
			//时间未选着
			UIAlertView * pAlert = [[UIAlertView alloc] initWithTitle:@"提示!"
															  message:@"请选择时间!"
															 delegate:nil
													cancelButtonTitle:@"确定"
													otherButtonTitles:nil];
			[pAlert show];
			[pAlert release];
			
			return NO;
		}
	}
	*/
	//CustomItemView * pDes        = (CustomItemView*)[self.m_pUIScrollView_IB viewWithTag:EViewInMemo_Des];
	
	//CustomButtonView * pRemind   = (CustomButtonView*)[self.m_pUIScrollView_IB viewWithTag:EViewInMemo_Remind];
	
	return YES;
	
}

@end
