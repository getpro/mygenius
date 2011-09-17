    //
//  memoVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "memoVC.h"
#import "AddressBookAppDelegate.h"

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@implementation memoVC

@synthesize m_pSearchDC;
@synthesize m_pSearchBar;
@synthesize m_pTableView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	
	
	// Create a search bar
	self.m_pSearchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)] autorelease];
	self.m_pSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.m_pSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.m_pSearchBar.keyboardType = UIKeyboardTypeDefault;
	self.m_pSearchBar.delegate = self;
	self.m_pTableView_IB.tableHeaderView = self.m_pSearchBar;
	
	// Create the search display controller
	self.m_pSearchDC = [[[UISearchDisplayController alloc] initWithSearchBar:self.m_pSearchBar contentsController:self] autorelease];
	self.m_pSearchDC.searchResultsDataSource = self;
	self.m_pSearchDC.searchResultsDelegate = self;
}

-(void)myInit
{
	
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
	[m_pSearchDC     release];
	[m_pSearchBar    release];
	[m_pTableView_IB release];
	
    [super dealloc];
}

-(IBAction)addItemBtn:(id)sender
{
	/*
	//查看
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"查看类型"
															 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
													otherButtonTitles:@"每日事件查看", @"每月时间查看",@"全部", @"返回",nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = m_nTypeIndex;	// make the second button red (destructive)
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];
	*/
	
	rightOrLeft = YES;
	teXiao      = YES;
	
	NSString * ss = [NSString stringWithFormat:@"%d" , EViewmemoInfoVC];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
	
}

-(IBAction)editItemBtn:(id)sender
{
	//编辑
}


#pragma mark UIActionSheet_Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)asearchBar
{
	self.m_pSearchBar.prompt = @"输入字母或汉字搜索";
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[self.m_pSearchBar setText:@""]; 
	self.m_pSearchBar.prompt = nil;
	[self.m_pSearchBar setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
	self.m_pTableView_IB.tableHeaderView = self.m_pSearchBar;	
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"ContactCell"];
	
	if (!cell) 
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"ContactCell"] autorelease];
	
	NSString * contactName = nil;
	
	
	contactsInfo * pcontactsInfo = (contactsInfo*)[[AddressBookAppDelegate getAppDelegate].m_arrContactsInfo objectAtIndex:indexPath.row];
	if(pcontactsInfo)
	{
		contactName = pcontactsInfo.m_strcontactsName;
	}
	// Retrieve the crayon and its color
	/*
	 if (aTableView == self.DataTable)
	 contactName = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	 else
	 contactName = [self.filteredArray objectAtIndex:indexPath.row];
	 */
	
	if(contactName)
	{
		cell.textLabel.text = [NSString stringWithCString:[contactName UTF8String] encoding:NSUTF8StringEncoding];
	}
	
	/*
	 ABContact *contact = [ContactData byNameToGetContact:contactName];
	 if(contact)
	 {
	 NSArray *phoneArray = [ContactData getPhoneNumberAndPhoneLabelArray:contact];
	 if([phoneArray count] > 0)
	 {
	 NSDictionary *dic = [phoneArray objectAtIndex:0];
	 NSString *phone = [ContactData getPhoneNumberFromDic:dic];
	 cell.detailTextLabel.text = phone;
	 }
	 }
	 else
	 cell.detailTextLabel.text = @"";
	 */
	
	return cell;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
	 [aTableView deselectRowAtIndexPath:indexPath animated:NO];
	 ABPersonViewController *pvc = [[[ABPersonViewController alloc] init] autorelease];
	 pvc.navigationItem.leftBarButtonItem = BARBUTTON(@"取消", @selector(cancelBtnAction:));
	 
	 NSString *contactName = @"";
	 if (aTableView == self.DataTable)
	 contactName = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	 else
	 contactName = [self.filteredArray objectAtIndex:indexPath.row];
	 
	 ABContact *contact = [ContactData byNameToGetContact:contactName];
	 pvc.displayedPerson = contact.record;
	 pvc.allowsEditing = YES;
	 //[pvc setAllowsDeletion:YES];
	 pvc.personViewDelegate = self;
	 self.aBPersonNav = [[[UINavigationController alloc] initWithRootViewController:pvc] autorelease];
	 self.aBPersonNav.navigationBar.tintColor = SETCOLOR(redcolor,greencolor,bluecolor);
	 [self presentModalViewController:aBPersonNav animated:YES];
	 */
	
	rightOrLeft = YES;
	teXiao      = YES;
	
	NSString * ss = [NSString stringWithFormat:@"%d" , EViewmemoInfoVC];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(aTableView == self.m_pTableView_IB)
		// Return NO if you do not want the specified item to be editable.
		return YES;
	else
		return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	/*
	 NSString *contactName = @"";
	 if (aTableView == self.DataTable)
	 contactName = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	 else
	 contactName = [self.filteredArray objectAtIndex:indexPath.row];
	 ABContact *contact = [ContactData byNameToGetContact:contactName];
	 
	 if ([ModalAlert ask:@"真的要删除 %@?", contact.compositeName])
	 {
	 [[self.sectionArray objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
	 [ContactData removeSelfFromAddressBook:contact withErrow:nil];
	 [DataTable reloadData];
	 }
	 [DataTable  setEditing:NO];
	 editBtn.title = @"编辑";
	 isEdit = NO;
	 */
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{ 
	//if(aTableView == self.DataTable)
	//	return 27;
	return 1; 
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView 
{
	if (aTableView == self.m_pTableView_IB)  // regular table
	{
		/*
		 NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
		 for (int i = 0; i < 27; i++) 
		 if ([[self.sectionArray objectAtIndex:i] count])
		 [indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
		 //[indices addObject:@"\ue057"]; // <-- using emoji
		 return indices;
		 */
		
		return nil;
	}
	else
	{
		return nil; // search table
	}
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	/*
	 if (title == UITableViewIndexSearch) 
	 {
	 [self.DataTable scrollRectToVisible:self.searchBar.frame animated:NO];
	 return -1;
	 }
	 return [ALPHA rangeOfString:title].location;
	 */
	
	return 0;
}



- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
	if (aTableView == self.m_pTableView_IB) 
	{
		/*
		 if ([[self.sectionArray objectAtIndex:section] count] == 0) return nil;
		 return [NSString stringWithFormat:@"%@", [[ALPHA substringFromIndex:section] substringToIndex:1]];
		 */
		return nil;
	}
	else
	{
		return nil;
	}
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	//[self initData];
	// Normal table
	/*
	 if (aTableView == self.DataTable) 
	 {
	 return [[self.sectionArray objectAtIndex:section] count];
	 }
	 else
	 {
	 [filteredArray removeAllObjects];
	 }
	 // Search table
	 for(NSString *string in contactNameArray)
	 {
	 NSString *name = @"";
	 for (int i = 0; i < [string length]; i++)
	 {
	 if([name length] < 1)
	 name = [NSString stringWithFormat:@"%c",pinyinFirstLetter([string characterAtIndex:i])];
	 else
	 name = [NSString stringWithFormat:@"%@%c",name,pinyinFirstLetter([string characterAtIndex:i])];
	 }
	 if ([ContactData searchResult:name searchText:self.searchBar.text])
	 [filteredArray addObject:string];
	 else 
	 {
	 if ([ContactData searchResult:string searchText:self.searchBar.text])
	 [filteredArray addObject:string];
	 else {
	 ABContact *contact = [ContactData byNameToGetContact:string];
	 NSArray *phoneArray = [ContactData getPhoneNumberAndPhoneLabelArray:contact];
	 NSString *phone = @"";
	 
	 if([phoneArray count] == 1)
	 {
	 NSDictionary *PhoneDic = [phoneArray objectAtIndex:0];
	 phone = [ContactData getPhoneNumberFromDic:PhoneDic];
	 if([ContactData searchResult:phone searchText:self.searchBar.text])
	 [filteredArray addObject:string];
	 }else  if([phoneArray count] > 1)
	 {
	 for(NSDictionary *dic in phoneArray)
	 {
	 phone = [ContactData getPhoneNumberFromDic:dic];
	 if([ContactData searchResult:phone searchText:self.searchBar.text])
	 {
	 [filteredArray addObject:string];	
	 break;
	 }
	 }
	 }
	 
	 }
	 }
	 }
	 return self.filteredArray.count;
	 */
	
	return [[AddressBookAppDelegate getAppDelegate].m_arrContactsInfo count];
}


@end
