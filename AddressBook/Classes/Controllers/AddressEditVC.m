    //
//  AddressEdit.m
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressEditVC.h"
#import "AddressBookAppDelegate.h"

@implementation AddressEditVC

@synthesize m_pUIScrollView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[m_pUIScrollView_IB setContentSize:CGSizeMake(SCREEN_W, SCREEN_H/2 + 420)];
}


-(void)myInit
{
	if(m_pUIScrollView_IB)
	{
		[m_pUIScrollView_IB setContentOffset:CGPointMake(0, 0)];
	}
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

-(IBAction)cancelItemBtn:(id)sender
{
	[[AddressBookAppDelegate getAppDelegate] backScene];
}


-(IBAction)doneItemBtn:  (id)sender
{
	[[AddressBookAppDelegate getAppDelegate] backScene];
}


@end
