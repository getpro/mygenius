    //
//  baseVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "baseVC.h"


@implementation baseVC

@synthesize m_pUITabBar_IB;

@synthesize m_pUITabBarItem1_IB;
@synthesize m_pUITabBarItem2_IB;
@synthesize m_pUITabBarItem3_IB;
@synthesize m_pUITabBarItem4_IB;
@synthesize m_pUITabBarItem5_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	
	
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
	[m_pUITabBar_IB release];
	
	[m_pUITabBarItem1_IB release];
	[m_pUITabBarItem2_IB release];
	[m_pUITabBarItem3_IB release];
	[m_pUITabBarItem4_IB release];
	[m_pUITabBarItem5_IB release];
	
    [super dealloc];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	if(item.tag == 1)
	{
		rightOrLeft = NO;
		teXiao      = NO;
		
		NSString * ss = [NSString stringWithFormat:@"%d" , EViewAddressBook];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
		
	}
	else if(item.tag == 2)
	{
		rightOrLeft = NO;
		teXiao      = NO;
		
		NSString * ss = [NSString stringWithFormat:@"%d" , EViewAccounts];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
		
	}
	else if(item.tag == 3)
	{
		rightOrLeft = NO;
		teXiao      = NO;
		
		NSString * ss = [NSString stringWithFormat:@"%d" , EViewDate];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
		
	}
	else if(item.tag == 4)
	{
		rightOrLeft = NO;
		teXiao      = NO;
		
		NSString * ss = [NSString stringWithFormat:@"%d" , EViewMemo];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
		
	}
	else if(item.tag == 5)
	{
		rightOrLeft = NO;
		teXiao      = NO;
		
		NSString * ss = [NSString stringWithFormat:@"%d" , EViewSetting];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
		
	}
}


@end
