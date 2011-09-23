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
@synthesize m_pHead_IB;
@synthesize m_pName_IB;
@synthesize m_pJobAndDep_IB;
@synthesize m_pOrganization_IB;

@synthesize m_pRightAdd;
@synthesize m_pContact;
@synthesize m_pContainer;
@synthesize m_pData;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	self.navigationItem.title = @"联系人";
	self.navigationItem.rightBarButtonItem = m_pRightAdd;
	
	//头像
	if(m_pContact.image)
	{
		self.m_pHead_IB.image = m_pContact.image;
	}
	
	//姓名
	if(m_pContact.contactName)
	{
		self.m_pName_IB.text = m_pContact.contactName;
	}
	
	//职位部门
	NSMutableString * pJobAndDep = [NSMutableString stringWithCapacity:10];
	if(m_pContact.jobtitle)
	{
		[pJobAndDep appendString:m_pContact.jobtitle];
		[pJobAndDep appendString:@" "];
	}
	if(m_pContact.department)
	{
		[pJobAndDep appendString:m_pContact.department];
	}
	self.m_pJobAndDep_IB.text = pJobAndDep;
	
	//公司
	if(m_pContact.organization)
	{
		self.m_pOrganization_IB.text = m_pContact.organization;
	}
	
	
	m_pContainer = [[CAttributeContainer alloc] init];
	
	CAttribute *attr = nil;
	
	attr = [[[CAttributeString alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"分组"];
	
	attr = [[[CAttributeString alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"移动电话"];
	((CAttributeString*)attr).stringValue = m_pContact.phonenumber;
	
	attr = [[[CAttributeString alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"短信"];
	((CAttributeString*)attr).stringValue = m_pContact.phonenumber;
	
	attr = [[[CAttributeString alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"邮件"];
	((CAttributeString*)attr).stringValue = m_pContact.emailaddresse;
	
	attr = [[[CAttributeString alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"星座"];
	
	m_pData = [[NSMutableArray alloc]initWithArray:m_pContainer.attributes];
	
	/*
	BOOL foundImage  = NO;
	BOOL foundString = NO;
	
	UILabel     *lbl;
	
	for (CAttribute *att in m_pContainer.attributes) 
	{
		if (!foundString && [att.type isEqualToString:@"string"]) 
		{
			lbl = (UILabel*)[sectionHeader viewWithTag:101];
			if (lbl != nil) 
			{
				NSString *st = [att valueForKey:@"stringValue"];
				if (st)
					lbl.text = st;
				[temp addObject:att];
				foundString = YES;
			}
		}
	}
	//if ([temp count]>0)
	//	[data removeObjectsInArray:temp];
	*/
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
	[m_pContainer    release];
	[m_pData         release];
	[m_pHead_IB      release];
	
	[m_pName_IB		 release];
	[m_pJobAndDep_IB release];
	[m_pOrganization_IB release];
	
    [super dealloc];
}

-(IBAction)MoreInfoBtn: (id)sender
{
	AddressBaseInfoVC *pvc = [[AddressBaseInfoVC alloc] init];
	
	pvc.m_pContact = m_pContact;
	//pvc.displayedPerson = m_pContact.record;
	pvc.allowsEditing = YES;
	//[pvc setAllowsDeletion:YES];
	pvc.personViewDelegate = self;
	
	pvc.aBPersonNav = self.navigationController;
	
	[self.navigationController pushViewController:pvc animated:YES];
	
	[pvc release];
	
	//[self presentModalViewController:aBPersonNav animated:YES];
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
	UITableViewCell *cell = nil;
	CAttribute      *attr = nil;
	
	//UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	//UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ID_ID"];
	//if (!cell)
	//	cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"ID_ID"] autorelease];
	
	
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
			/*
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
			*/
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
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	//UIViewController *vc = nil;
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

#pragma mark ABPersonViewControllerDelegate methods

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	//[self dismissModalViewControllerAnimated:YES];
	NSLog(@"111111111");
	return NO;
}

@end
