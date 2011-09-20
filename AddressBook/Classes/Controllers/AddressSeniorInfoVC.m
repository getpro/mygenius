    //
//  AddressAddMoreVC.m
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressSeniorInfoVC.h"
#import "PublicData.h"


@implementation AddressSeniorInfoVC

@synthesize m_pTableView_IB;


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

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pTableView_IB release];
	
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
