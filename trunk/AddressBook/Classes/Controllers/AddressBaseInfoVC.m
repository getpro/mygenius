    //
//  AddressEdit.m
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBaseInfoVC.h"
#import "AddressBookAppDelegate.h"

@implementation AddressBaseInfoVC

- (void)toggleStyle:(id)sender
{
	/*
	UIBarButtonItemStyle style = UIBarButtonItemStylePlain;
	
	switch ([sender selectedSegmentIndex])
	{
		case 0:	// UIBarButtonItemStylePlain
		{
			style = UIBarButtonItemStylePlain;
			break;
		}
		case 1: // UIBarButtonItemStyleBordered
		{	
			style = UIBarButtonItemStyleBordered;
			break;
		}
		case 2:	// UIBarButtonItemStyleDone
		{
			style = UIBarButtonItemStyleDone;
			break;
		}
	}
	
	NSArray *toolbarItems = toolbar.items;
	UIBarButtonItem *item;
	for (item in toolbarItems)
	{
		item.style = style;
	}
	*/
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"";
	
	if(m_pSegmentedControl)
	{
		[m_pSegmentedControl setHidden:NO];
	}
	else
	{
		m_pSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"基本信息", @"高级信息", nil]];
		[m_pSegmentedControl addTarget:self action:@selector(toggleStyle:) forControlEvents:UIControlEventValueChanged];
		m_pSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
		m_pSegmentedControl.backgroundColor = [UIColor clearColor];
		[m_pSegmentedControl sizeToFit];
		m_pSegmentedControl.selectedSegmentIndex = 0;
		CGRect segmentedControlFrame = CGRectMake((320 - 166)/2,(45 - 30)/2,166,30);
		m_pSegmentedControl.frame = segmentedControlFrame;
		
		[self.navigationController.navigationBar addSubview:m_pSegmentedControl];
	}
}

- (void)setEditing:(BOOL)editing
{
	if(editing == YES)
	{
		[m_pSegmentedControl setHidden:YES];
	}
	[super setEditing:editing];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	if(editing == YES)
	{
		[m_pSegmentedControl setHidden:YES];
	}
	else
	{
		[m_pSegmentedControl setHidden:NO];
	}
	[super setEditing:editing animated:animated];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
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
	[m_pSegmentedControl release];
	
    [super dealloc];
}

-(IBAction)cancelItemBtn:(id)sender
{
	
}


-(IBAction)doneItemBtn:  (id)sender
{
	
}

#pragma mark ABPersonViewControllerDelegate methods

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	//[self dismissModalViewControllerAnimated:YES];
	NSLog(@"111111111");
	return NO;
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[m_pSegmentedControl setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[m_pSegmentedControl setHidden:YES];
}

@end
