    //
//  memoVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "memoVC.h"


@implementation memoVC




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	m_pUITabBar_IB.selectedItem = m_pUITabBarItem4_IB;
}

-(void)myInit
{
	m_pUITabBar_IB.selectedItem = m_pUITabBarItem4_IB;
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


- (void)dealloc {
    [super dealloc];
}

-(IBAction)lookItemBtn:(id)sender
{
	//查看
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"查看类型"
															 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
													otherButtonTitles:@"每日事件查看", @"每月时间查看",@"全部", @"返回",nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = m_nTypeIndex;	// make the second button red (destructive)
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];
}

-(IBAction)editItemBtn:(id)sender
{
	//编辑
}


#pragma mark UIActionSheet_Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
}

@end
