//
//  serviceListVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "serviceListVC.h"

@implementation serviceListVC

@synthesize m_pTableView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"运营商规则";
	
	m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	m_pTableView_IB.allowsSelectionDuringEditing = YES;
	
	//[m_pTableView_IB setEditing:YES];
	[m_pTableView_IB reloadData];
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
	[m_pTableView_IB release];
	
    [super dealloc];
}


#pragma mark - UITableView delegates

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	//NSInteger row = [indexPath row];
	
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[tableView reloadData];
    }   
    //else if (editingStyle == UITableViewCellEditingStyleInsert) 
	//{
	//	[self presentAttributeTypeChooser];
    //}
}

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//UITableViewCellEditingStyle pRetNum = UITableViewCellEditingStyleNone;
	//NSInteger row = [indexPath row];
	/*
	if([m_pSectionArr count] == indexPath.section)
	{
		pRetNum = UITableViewCellEditingStyleInsert;
	}
	else
	{
		
	}
	*/
	return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//return ([m_pSectionArr count] + 1);
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 0;
	
	return pRetNum;
}

// to determine specific row height for each cell, override this.  In this example, each row is determined
// buy the its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat result = 40.0f;
	return  result;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//NSInteger row = [indexPath row];
	UITableViewCell *cell = nil;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
