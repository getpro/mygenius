    //
//  AddressAddMoreVC.m
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressSeniorInfoVC.h"
#import "PublicData.h"

#import "CustomItemView.h"
#import "CustomButtonView.h"

@implementation AddressSeniorInfoVC

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
	
	CustomButtonView * pRecommend = [[CustomButtonView alloc] initWithFrame:frame];
	pRecommend.m_pTitle.text = @"推荐人";
	
	[m_pUIScrollView_IB addSubview:pRecommend];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomButtonView * pRelation = [[CustomButtonView alloc] initWithFrame:frame];
	pRelation.m_pTitle.text = @"关系";
	
	[m_pUIScrollView_IB addSubview:pRelation];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomItemView * pIdentification = [[CustomItemView alloc] initWithFrame:frame IsEdit:YES];
	pIdentification.m_pTitle.text = @"身份证";
	
	[m_pUIScrollView_IB addSubview:pIdentification];
	
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomItemView * pQQ = [[CustomItemView alloc] initWithFrame:frame IsEdit:YES];
	pQQ.m_pTitle.text = @"QQ";
	
	[m_pUIScrollView_IB addSubview:pQQ];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomItemView * pMSN = [[CustomItemView alloc] initWithFrame:frame IsEdit:YES];
	pMSN.m_pTitle.text = @"MSN";
	
	[m_pUIScrollView_IB addSubview:pMSN];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomItemView * pSkp = [[CustomItemView alloc] initWithFrame:frame IsEdit:YES];
	pSkp.m_pTitle.text = @"Skp";
	
	[m_pUIScrollView_IB addSubview:pSkp];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	CustomItemView * pBank = [[CustomItemView alloc] initWithFrame:frame IsEdit:YES];
	pBank.m_pTitle.text = @"银行帐号";
	
	[m_pUIScrollView_IB addSubview:pBank];
	
	frame.origin.y += ROW_HEIGHT;
	frame.origin.y += ROW_OFFSET_Y;
	
	
	
	
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

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pUIScrollView_IB release];
	
    [super dealloc];
}

-(IBAction)doneItemBtn:  (id)sender
{
	rightOrLeft = YES;
	teXiao      = YES;
	
	NSString * ss = [NSString stringWithFormat:@"%d" , EViewAddressBook];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
}


@end
