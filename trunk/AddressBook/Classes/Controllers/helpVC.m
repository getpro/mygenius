//
//  helpVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "helpVC.h"


@implementation helpVC

@synthesize m_pTextView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"好帮手使用帮助";
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"txt"];
	NSString *fileText;
	if(path)
	{
		fileText = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
		if(fileText)
		{
			m_pTextView.text = fileText;
		}
		[fileText release];
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
	[m_pTextView release];
	
    [super dealloc];
}


@end
