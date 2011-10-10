//
//  statisticsCheckVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "statisticsCheckVC.h"

typedef enum
{
    StatisticsCheck_TableView_Section_Contact,
    StatisticsCheck_TableView_Section_Time,
	StatisticsCheck_TableView_Section_Type,
	StatisticsCheck_TableView_Section_Count
}StatisticsCheck_TableView_Section;

@implementation statisticsCheckVC

@synthesize m_pTableView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"查询设置";
	
	m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	m_pTableView_IB.scrollEnabled = NO;
	
	
	
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
	
    [super dealloc];
}

#pragma mark TableView methods

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellIdentifier = @"statisticsCheckCell";
	UITableViewCell* cell = (UITableViewCell*)[aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if (cell != nil)
	{
		switch (indexPath.section) 
		{
			case StatisticsCheck_TableView_Section_Contact:
			{
				cell.textLabel.text = @"联系人";
			}
				break;
			case StatisticsCheck_TableView_Section_Time:
			{
				if(indexPath.row == 0)
				{
					cell.textLabel.text = @"开始";
				}
				else if(indexPath.row == 1)
				{
					cell.textLabel.text = @"结束";
				}
			}
				break;
			case StatisticsCheck_TableView_Section_Type:
			{
				cell.textLabel.text = @"事件类型";
			}
				break;
			default:
				break;
		}
	}
	
	return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{ 
	return StatisticsCheck_TableView_Section_Count;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger pRetNum = 1;
	
	switch (section) 
	{
		case StatisticsCheck_TableView_Section_Contact:
		{
			pRetNum = 1;
		}
			break;
		case StatisticsCheck_TableView_Section_Time:
		{
			pRetNum = 2;
		}
			break;
		case StatisticsCheck_TableView_Section_Type:
		{
			pRetNum = 1;
		}
			break;
		default:
			break;
	}
	
	return pRetNum;
}

@end
