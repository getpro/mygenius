//
//  RecommendVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecommendVC.h"
#import "AddressBookAppDelegate.h"

@implementation RecommendVC

@synthesize m_pTableView_IB;
@synthesize Target;
@synthesize Selector;
@synthesize m_pReturn;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.leftBarButtonItem  = m_pReturn;
	
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
	[m_pReturn       release];
	
    [super dealloc];
}

#pragma mark - UITableView delegates

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:0];
	
	NSInteger pRetNum = [AllContactData.contactsArray count];
	
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
	static NSString* cellIdentifier = @"RecommendCell";
	NSInteger row = [indexPath row];
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:0];
	
	ABContact * pABContact = (ABContact*)[AllContactData.contactsArray objectAtIndex:row];
	
	UITableViewCell * cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[UITableViewCell class]])
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	if (cell != nil)
	{
		cell.textLabel.text = pABContact.contactName;
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSInteger row = [indexPath row];
	
	ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:0];
	
	ABContact * pABContact = (ABContact*)[AllContactData.contactsArray objectAtIndex:row];

	if (pABContact && Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:pABContact];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)ReturnItemBtn:  (id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
