    //
//  AddressAddMoreVC.m
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressAddSeniorVC.h"
#import "PublicData.h"
#import "AddressBaseInfoVC.h"
#import "AddressBookAppDelegate.h"
#import "AddFieldVC.h"


typedef enum 
{
    AddSenior_TableView_Section_Group,
	AddSenior_TableView_Section_Blood,
	AddSenior_TableView_Section_Account,
	AddSenior_TableView_Section_AddField,
	AddSenior_TableView_Section_Count
}AddSenior_TableView_Section;

@implementation AddressAddSeniorVC

@synthesize m_pTableView_IB;
@synthesize m_pRightDone;
@synthesize m_pContact;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[m_pTableView_IB setEditing:YES];
	m_pTableView_IB.allowsSelectionDuringEditing = YES;
	
	self.navigationItem.title = @"高级信息";
	self.navigationItem.rightBarButtonItem = m_pRightDone;
	
	m_pContainer = [[CAttributeContainer alloc] init];
	
	CAttribute *attr = nil;
	
	attr = [[[CAttributeGroup alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"分组"];
	
	attr = [[[CAttributeBlood alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"血型"];
	
	attr = [[[CAttributeString alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"帐号"];
		
	m_pData = [[NSMutableArray alloc]initWithArray:m_pContainer.attributes];
	
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
	[m_pTableView_IB	 release];
	[m_pContact			 release];
	[m_pRightDone		 release];
	[m_pContainer        release];
	[m_pData             release];
	
    [super dealloc];
}

-(IBAction)doneItemBtn:  (id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

#pragma mark - UITableView delegates

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(indexPath.section == AddSenior_TableView_Section_AddField)
		return UITableViewCellEditingStyleInsert;
	
	return UITableViewCellEditingStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return AddSenior_TableView_Section_Count;
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
	NSInteger row = [indexPath row];
	UITableViewCell *cell = nil;
	CAttribute      *attr = nil;
	
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
		case AddSenior_TableView_Section_Blood:
		{
			if (row == 0)
			{
				attr = [m_pData objectAtIndex:1];
			}
			break;
		}
		case AddSenior_TableView_Section_Account:
		{
			if (row == 0)
			{
				attr = [m_pData objectAtIndex:2];
			}
			break;
		}
		case AddSenior_TableView_Section_AddField:
		{
			if (row == 0)
			{
				static NSString* cellIdentifier = @"AddFieldCell";
				UITableViewCell * cell2 = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
				if (![cell2 isKindOfClass:[UITableViewCell class]])
				{
					cell2 = [[[CAttributeCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
					cell2.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
				}
				if (cell2 != nil)
				{
					cell2.textLabel.text = @"添加字段";
				}
				return cell2;
			}
			break;
		}
		default:
			break;
	}
	
	cell = [attr cellForTableView:tableView];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UIViewController *vc = nil;
	
	if(indexPath.section == AddSenior_TableView_Section_AddField)
	{
		NSLog(@"AddField");
		
		AddFieldVC * pVC = [[AddFieldVC alloc] init];
		
		[self.navigationController pushViewController:pVC animated:YES];
		
		[pVC release];
		
		return;
	}
	
	CAttribute *attr = [m_pData objectAtIndex:indexPath.section];
	if (attr)
	{
		vc = [attr detailViewController:self.editing];
	}
	
	if (vc && attr)
	{
		[attr Show:vc];
	}
	
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
