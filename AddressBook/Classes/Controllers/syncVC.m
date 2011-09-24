    //
//  accountsVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "syncVC.h"
#import "syncAccountVC.h"
#import "FtpUpLoad.h"
#import "syncButtonCell.h"

typedef enum 
{
    Sync_TableView_Section_Sync,
    Sync_TableView_Section_BackUp,
	Sync_TableView_Section_Count
}Sync_TableView_Section;

@implementation syncVC

@synthesize m_pTableView_IB;

//同步帐号按钮事件
-(void)btnPressed:(id)sender
{
	syncAccountVC *pvc = [[syncAccountVC alloc] init];
	
	[self.navigationController pushViewController:pvc animated:YES];
	
	[pvc release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"同步备份";
	
	m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	m_pTableView_IB.scrollEnabled = NO;
	
	//同步帐号按钮
	m_pSyncAccountBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 6, 32, 32)];
	[m_pSyncAccountBtn setBackgroundImage:[UIImage imageNamed:@"sync_account.png"] forState:UIControlStateNormal];
	[m_pSyncAccountBtn setBackgroundImage:[UIImage imageNamed:@"sync_account_hover.png"] forState:UIControlStateHighlighted];
	
	[m_pSyncAccountBtn setBackgroundColor:[UIColor clearColor]];
	[m_pSyncAccountBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.navigationController.navigationBar addSubview:m_pSyncAccountBtn];
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
	[m_pSyncAccountBtn release];
	[m_pTableView_IB   release];
	
    [super dealloc];
}

-(IBAction)sendBtn:(id)sender
{
	FtpUpLoad * pFtp = [[FtpUpLoad alloc]init];
	
	/*
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AddressBook.db"];
	*/
	
	NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"head.png"];
	
	[pFtp startSend:defaultDBPath];
	
	//[pFtp release];
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[m_pSyncAccountBtn setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[m_pSyncAccountBtn setHidden:YES];
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
	return Sync_TableView_Section_Count;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 1;
	
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
	
	UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	syncButtonCell *cell = (syncButtonCell*)[tableView dequeueReusableCellWithIdentifier:KsyncButtonCell_ID];
	if (!cell)
	{
		switch (indexPath.section)
		{
			case Sync_TableView_Section_Sync:
			{
				if(row == 0)
				{
					cell = [[[syncButtonCell alloc] initWithStyle:style reuseIdentifier:KsyncButtonCell_ID type:ESyncButtonType_Sync] autorelease];
				}
				break;
			}
			case Sync_TableView_Section_BackUp:
			{
				if(row == 0)
				{
					cell = [[[syncButtonCell alloc] initWithStyle:style reuseIdentifier:KsyncButtonCell_ID type:ESyncButtonType_BackUp] autorelease];
				}
				break;
			}
			default:
				break;
		}
	}
	
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
