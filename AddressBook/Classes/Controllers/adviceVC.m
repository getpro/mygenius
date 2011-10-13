//
//  adviceVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "adviceVC.h"

@implementation adviceVC

@synthesize m_pTextPhone;
@synthesize m_pTextContent;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	m_pTextPhone.tag   = 0;
	m_pTextContent.tag = 1;
	
	m_pTextPhone.delegate   = self;
	m_pTextContent.delegate = self;
	
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
	[m_pTextPhone   release];
	[m_pTextContent release];
	
    [super dealloc];
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{	
    if ([@"\n" isEqualToString:text] == YES)
	{
		if(textView.tag == 0)
		{
			[textView resignFirstResponder];
			[m_pTextContent becomeFirstResponder];
		}
		else if(textView.tag == 1)
		{
			[textView resignFirstResponder];
		}
        return NO;
    }
    return YES;
} 

@end
