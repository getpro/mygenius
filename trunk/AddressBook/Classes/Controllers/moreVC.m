    //
//  settingVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "moreVC.h"

typedef enum 
{
    More_TableView_Section_Services,	//运营商
    More_TableView_Section_Share,       //分享，意见
	More_TableView_Section_Help,        //帮助，关于
	More_TableView_Section_Count
}More_TableView_Section;

@implementation moreVC

@synthesize m_pTableView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"更多";
	
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

#pragma mark TableView methods

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"MoreCell";
	NSInteger pRow = indexPath.row;
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	switch (indexPath.section) 
	{
		case More_TableView_Section_Services:
		{
			cell.textLabel.text = @"运营商规则";
		}
			break;
		case More_TableView_Section_Share:
		{
			if(pRow == 0)
			{
				cell.textLabel.text = @"分享好帮手";
			}
			else if(pRow == 1)
			{
				cell.textLabel.text = @"意见反馈";
			}
		}
			break;
		case More_TableView_Section_Help:
		{
			if(pRow == 0)
			{
				cell.textLabel.text = @"帮助信息";
			}
			else if(pRow == 1)
			{
				cell.textLabel.text = @"关于好帮手";
			}
		}
			break;
		default:
			break;
	}
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{ 
	return More_TableView_Section_Count;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	int pRet = 1;
	switch (section) 
	{
		case More_TableView_Section_Services:
		{
			pRet = 1;
		}
			break;
		case More_TableView_Section_Share:
		{
			pRet = 2;
		}
			break;
		case More_TableView_Section_Help:
		{
			pRet = 2;
		}
			break;
		default:
			break;
	}
	
	return pRet;
}


@end
