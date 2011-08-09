//
//  demo_iPhone_photon_objcAppDelegate.m
//  demo_iPhone_photon_objc
//
//  Created by Pedro Galystyan on 9/3/08.
//  Copyright home 2008. All rights reserved.
//

#import "demo_iPhone_Photon_objCViewController.h"

@implementation demo_iPhone_photon_objcViewController

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 Implement viewDidLoad if you need to do additional setup after loading the view.
- (void)viewDidLoad {
	[super viewDidLoad];
}
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc
{
	[super dealloc];
}

@end