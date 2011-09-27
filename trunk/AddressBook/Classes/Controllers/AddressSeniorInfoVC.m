    //
//  AddressAddMoreVC.m
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressSeniorInfoVC.h"
#import "PublicData.h"
#import "AddressBaseInfoVC.h"

@implementation AddressSeniorInfoVC

@synthesize m_pTableView_IB;
@synthesize m_pRightEdit;
@synthesize aBPersonNav;
@synthesize m_pContact;

- (void)toggleStyle:(id)sender
{
	switch ([sender selectedSegmentIndex])
	{
		case 0:
		{
			[aBPersonNav popViewControllerAnimated:NO];
			
			AddressBaseInfoVC *pvc = [[AddressBaseInfoVC alloc] init];
			
			pvc.m_pContact    = m_pContact;
			pvc.allowsEditing = YES;
			//[pvc setAllowsDeletion:YES];
			pvc.personViewDelegate = pvc;
			
			pvc.aBPersonNav = aBPersonNav;
			
			[aBPersonNav pushViewController:pvc animated:NO];
			
			[pvc release];
			
			break;
		}
		case 1: 
		{
			break;
		}
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"";
	self.navigationItem.rightBarButtonItem = m_pRightEdit;
	
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
		m_pSegmentedControl.selectedSegmentIndex = 1;
		CGRect segmentedControlFrame = CGRectMake((320 - 166)/2,(45 - 30)/2,166,30);
		m_pSegmentedControl.frame = segmentedControlFrame;
		
		[self.navigationController.navigationBar addSubview:m_pSegmentedControl];
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

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pTableView_IB	 release];
	[m_pSegmentedControl release];
	[aBPersonNav		 release];
	[m_pContact			 release];
	[m_pRightEdit		 release];
	
    [super dealloc];
}

-(IBAction)doneItemBtn:  (id)sender
{
	
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

#pragma mark - UITableView delegates

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//return TableView_Section_Count;
	return 0;
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
	//NSInteger row = [indexPath row];
	UITableViewCell *cell = nil;
	//CAttribute      *attr = nil;
	
	//UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	//UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ID_ID"];
	//if (!cell)
	//	cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"ID_ID"] autorelease];
	
	/*
	switch (indexPath.section)
	{
		case TableView_Section_Group:
		{
			if (row == 0)
			{
				//cell.textLabel.text = @"分组";
				attr = [self.m_pData objectAtIndex:0];
			}
			break;
		}
		case TableView_Section_Contact:
		{
			attr = [self.m_pData objectAtIndex:row + 1];
			break;
		}
		case TableView_Section_Constellation:
		{
			if (row == 0)
			{
				//cell.textLabel.text = @"星座";
				attr = [self.m_pData objectAtIndex:row + 4];
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
	 CAttribute *attr = [self.m_pData objectAtIndex:indexPath.row];
	 if (attr)
	 {
	 vc = [attr detailViewController:self.editing];
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
