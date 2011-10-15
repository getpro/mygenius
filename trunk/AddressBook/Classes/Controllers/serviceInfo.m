//
//  serviceInfo.m
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "serviceInfo.h"
#import "RuleCheck.h"
#import "LabelAndContent.h"

@implementation serviceInfo

@synthesize m_nSection;
@synthesize m_strTitle;
@synthesize m_strRule;
@synthesize m_pTextView;
@synthesize m_pTextField;
@synthesize m_pButtonItemDone;
@synthesize Target;
@synthesize Selector;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	m_pTextView.delegate = self;
	
	m_pTextView.text  = m_strRule;
	m_pTextField.text = m_strTitle;
	
	self.navigationItem.rightBarButtonItem = m_pButtonItemDone;
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
	[m_pTextView  release];
	[m_pTextField release];
	[m_pButtonItemDone release];
	
    [super dealloc];
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
	{
		[textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(IBAction)doneItemBtn:    (id)sender
{
	//检测规则，并保存
	NSString * pRule = m_pTextView.text;
	if(pRule)
	{
		NSLog(@"pRule[%@]",pRule);
		
		NSArray * pArry = [pRule componentsSeparatedByString:@","];
		
		for(NSString * pStr in pArry)
		{
			NSLog(@"[%@]",pStr);
		}
	}
	
	if (Target && Selector && [Target respondsToSelector:Selector]) 
	{
		LabelAndContent * pNew = [[LabelAndContent alloc] init];
		
		pNew.m_strContent = m_pTextView.text;
		pNew.m_strLabel   = m_pTextField.text;
		
		[Target performSelector:Selector withObject:pNew withObject:[NSString stringWithFormat:@"%d",m_nSection]];
		
		[pNew release];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
