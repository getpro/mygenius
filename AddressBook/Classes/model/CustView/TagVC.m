//
//  TagVC.m
//  AddressBook
//
//  Created by Peteo on 11-9-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TagVC.h"

typedef enum 
{
    Tag_TableView_Section_Content,
	Tag_TableView_Section_Custom,
	Tag_TableView_Section_Count
}Tag_TableView_Section;

@implementation TagVC

@synthesize m_pTableView_IB,m_pRightDone,m_pRightEdit;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"标签";
	
	
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
	[m_pRightDone    release];
	[m_pRightEdit    release];
	
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
	return Tag_TableView_Section_Count;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 1;
	
	/*
	 switch (section)
	 {
	 case TableView_Section_Group:
	 {
	 pRetNum = 1;
	 break;
	 }
	 case TableView_Section_Contact:
	 {
	 pRetNum = 3;
	 break;
	 }
	 case TableView_Section_Constellation:
	 {
	 pRetNum = 1;
	 break;
	 }
	 default:
	 break;
	 }
	 */
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
	//CAttribute      *attr = nil;
	/*
	switch (indexPath.section)
	{
		case AddSenior_TableView_Section_Group:
		{
			if (row == 0)
			{
				attr = [m_pData objectAtIndex:0];
			}
			break;
		}
		default:
			break;
	}
	
	cell = [attr cellForTableView:tableView];
	*/
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	//UIViewController *vc = nil;
	
	/*
	 NSInteger row = [indexPath row];
	 CAttribute       *attr = nil;
	 CAttributeString *stringAttr = nil;
	 
	 switch (indexPath.section)
	 {
	 case TableView_Section_Group:
	 {
	 if (row == 0)
	 {
	 //cell.textLabel.text = @"分组";
	 }
	 break;
	 }
	 case TableView_Section_Contact:
	 {
	 attr = [self.m_pData objectAtIndex:row + 1];
	 stringAttr = (CAttributeString*)attr;
	 
	 if (row == 0)
	 {
	 //cell.textLabel.text = @"移动电话";
	 NSLog(@"tel[%@]",stringAttr.stringValue);
	 NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", stringAttr.stringValue]];
	 [[UIApplication sharedApplication] openURL:URL]; 
	 }
	 else if(row == 1)
	 {
	 //cell.textLabel.text = @"短信";
	 NSLog(@"sms[%@]",stringAttr.stringValue);
	 NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", stringAttr.stringValue]];
	 [[UIApplication sharedApplication] openURL:URL];
	 }
	 else if(row == 2)
	 {
	 //cell.textLabel.text = @"工作";
	 NSLog(@"email[%@]",stringAttr.stringValue);
	 NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@", stringAttr.stringValue]];
	 [[UIApplication sharedApplication] openURL:URL];
	 }
	 
	 break;
	 }
	 case TableView_Section_Constellation:
	 {
	 if (row == 0)
	 {
	 //cell.textLabel.text = @"星座";
	 }
	 break;
	 }
	 default:
	 break;
	 }
	 */
	
	/*
	CAttribute *attr = [m_pData objectAtIndex:indexPath.row];
	if (attr)
	{
		vc = [attr detailViewController:self.editing];
	}
	
	if (vc && attr)
	{
		[attr Show:vc];
	}
	*/
	
	/*
	 if (vc)
	 {
	 [self presentModalViewController:vc animated:YES];
	 [tableView deselectRowAtIndexPath:indexPath animated:NO];
	 }
	 else 
	 {
	 [tableView deselectRowAtIndexPath:indexPath animated:YES];
	 }
	 */
}

@end
