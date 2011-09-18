    //
//  AddressInfoVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressPreInfoVC.h"
#import "PublicData.h"
#import "AddressBaseInfoVC.h"

typedef enum 
{
    TableView_Section_Group,
    TableView_Section_Contact,
    TableView_Section_Constellation,
	TableView_Section_Count
}TableView_Section;

@implementation AddressPreInfoVC

@synthesize m_pTableView_IB;
@synthesize m_pRightAdd;
@synthesize m_pContact;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"联系人";
	self.navigationItem.rightBarButtonItem = m_pRightAdd;
	
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
	[m_pTableView_IB release];
	[m_pContact      release];
	
    [super dealloc];
}

-(IBAction)MoreInfoBtn: (id)sender
{
	ABPersonViewController *pvc = [[[ABPersonViewController alloc] init] autorelease];
	//pvc.navigationItem.leftBarButtonItem = BARBUTTON(@"取消", @selector(cancelBtnAction:));
	 
	pvc.displayedPerson = m_pContact;
	pvc.allowsEditing   = YES;
	//[pvc setAllowsDeletion:YES];
	pvc.personViewDelegate = self;
	//self.aBPersonNav = [[[UINavigationController alloc] initWithRootViewController:pvc] autorelease];
	//self.aBPersonNav.navigationBar.tintColor = SETCOLOR(redcolor,greencolor,bluecolor);
	//[self presentModalViewController:aBPersonNav animated:YES];
	
	//[self.navigationController pushViewController:pvc animated:YES];
	
	UINavigationController * aBPersonNav = [[[UINavigationController alloc] initWithRootViewController:pvc] autorelease];
	[self presentModalViewController:aBPersonNav animated:YES];
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
	return TableView_Section_Count;
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 1;
	
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
	return pRetNum;
}

// to determine specific row height for each cell, override this.  In this example, each row is determined
// buy the its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat result = 40.0f;
	/*
	switch ([indexPath row])
	{
		case 0:
		{
			result = kUIRowHeight;
			break;
		}
		case 1:
		{
			result = kUIRowLabelHeight;
			break;
		}
	}
	*/
	return result;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	
	UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ID_ID"];
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"ID_ID"] autorelease];
	
	
	switch (indexPath.section)
	{
		case TableView_Section_Group:
		{
			if (row == 0)
			{
				cell.textLabel.text = @"分组";
			}
			break;
		}
		case TableView_Section_Contact:
		{
			if (row == 0)
			{
				cell.textLabel.text = @"移动电话";
			}
			else if(row == 1)
			{
				cell.textLabel.text = @"短信";
			}
			else if(row == 2)
			{
				cell.textLabel.text = @"工作";
			}
			break;
		}
		case TableView_Section_Constellation:
		{
			if (row == 0)
			{
				cell.textLabel.text = @"星座";
			}
			break;
		}
		default:
			break;
	}
	
	return cell;
}

#pragma mark ABPersonViewControllerDelegate methods
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
	[self dismissModalViewControllerAnimated:YES];
	return NO;
}

@end
