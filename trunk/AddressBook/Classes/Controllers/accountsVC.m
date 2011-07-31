    //
//  accountsVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "accountsVC.h"


@implementation accountsVC


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	m_pUITabBar_IB.selectedItem = m_pUITabBarItem2_IB;
}

-(void)myInit
{
	m_pUITabBar_IB.selectedItem = m_pUITabBarItem2_IB;
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


@end
