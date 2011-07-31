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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
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
