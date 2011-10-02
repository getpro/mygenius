//
//  TagVC.m
//  AddressBook
//
//  Created by Peteo on 11-9-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TagVC.h"
#import "AddressBookAppDelegate.h"
#import "ModalAlert.h"

typedef enum 
{
    Tag_TableView_Section_Content,
	Tag_TableView_Section_Custom,
	Tag_TableView_Section_Count
}Tag_TableView_Section;

@implementation TagVC

@synthesize m_pTableView_IB,m_pRightReturn,m_pRightEdit,m_nType;
@synthesize Target;
@synthesize Selector;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"标签";
	
	self.navigationItem.rightBarButtonItem = m_pRightEdit;
	self.navigationItem.leftBarButtonItem  = m_pRightReturn;
	
	switch (m_nType) 
	{
		case Tag_Type_None:
		{
			m_pDateArry = [NSArray arrayWithObjects:nil];
		}
			break;
		case Tag_Type_Memo:
		{
			m_pDateArry = [NSArray arrayWithObjects:@"结婚纪念日",@"周年",@"买车纪念日",nil];
		}
			break;
		case Tag_Type_Account:
		{
			m_pDateArry = [NSArray arrayWithObjects:@"QQ",@"MSN",@"Skype",@"招商",@"工商",@"农业",@"浦发",nil];
		}
			break;
		case Tag_Type_Certificate:
		{
			m_pDateArry = [NSArray arrayWithObjects:@"身份证",@"学生证",@"工作证",nil];
		}
			break;
		default:
			break;
	}
	
	[m_pDateArry retain];
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
	[m_pRightReturn  release];
	[m_pRightEdit    release];
	
	[m_pDateArry     release];
	
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
	if([m_pDateArry count] == 0)
	{
		//只有自定义标签
		return Tag_TableView_Section_Custom;
	}
	else
	{
		return Tag_TableView_Section_Count;
	}
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	NSInteger pRetNum = 1;
	
	switch (section)
	{
		case Tag_TableView_Section_Content:
		{
			pRetNum = [m_pDateArry count];
			break;
		}
		case Tag_TableView_Section_Custom:
		{
			// + 1 添加自定义标签
			pRetNum = [app.m_arrCustomTag count] + 1;
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
	return  result;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellIdentifier = @"TagCell";
	NSInteger row = [indexPath row];
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	UITableViewCell * cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[UITableViewCell class]])
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	if (cell != nil)
	{
		switch (indexPath.section)
		{
			case Tag_TableView_Section_Content:
			{
				cell.textLabel.text = [m_pDateArry objectAtIndex:row];
				break;
			}
			case Tag_TableView_Section_Custom:
			{
				if(row == [app.m_arrCustomTag count])
				{
					cell.textLabel.text = @"添加自定义标签";
				}
				else
				{
					cell.textLabel.text = [app.m_arrCustomTag objectAtIndex:row];
				}
				break;
			}
		}
		
	}
	return cell;
}

- (void)GreateNewGroup
{
	NSString * pStr = [ModalAlert ask:@"新建添加自定义标签" withTextPrompt:@"请输入标签名称"];
	if(pStr)
	{
		NSLog(@"NewGroupName[%@]",pStr);
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSInteger row = [indexPath row];
	
	NSString * pStr = nil;
	
	switch (indexPath.section)
	{
		case Tag_TableView_Section_Content:
		{
			pStr = [m_pDateArry objectAtIndex:row];
			break;
		}
		case Tag_TableView_Section_Custom:
		{
			if (row == [app.m_arrCustomTag count])
			{
				[self GreateNewGroup];
			}
			else
			{
				pStr = [app.m_arrCustomTag objectAtIndex:row];
			}
		}
		default:
			break;
	}
	
	if (pStr && Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:pStr];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)ReturnItemBtn:  (id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)EditItemBtn:    (id)sender
{
	
}

@end
