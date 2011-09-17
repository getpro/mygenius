    //
//  AddressInfoVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressPreInfoVC.h"
#import "PublicData.h"

@implementation AddressPreInfoVC

@synthesize m_pUIScrollView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[m_pUIScrollView_IB setContentSize:CGSizeMake(SCREEN_W, 0)];
	
	CGRect frame    = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
	frame.origin.y += ROW_OFFSET_Y;
	
	//头像
	UIImageView * contentHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 64, 64)];
	[contentHeadView setImage:[UIImage imageNamed:@"head_big.png"]];
	[contentHeadView setUserInteractionEnabled:YES];
	[m_pUIScrollView_IB addSubview:contentHeadView];
	[contentHeadView release];
	
	
	
	
	frame.origin.y += 64;
	frame.origin.y += ROW_OFFSET_Y;
	
	
}


-(void)myInit
{
	
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
	[m_pUIScrollView_IB release];
	
    [super dealloc];
}


@end
