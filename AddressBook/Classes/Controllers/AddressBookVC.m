//
//  AddressBookVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBookVC.h"
#import "AddressBookAppDelegate.h"
#import "pinyin.h"
#import "ContactData.h"
#import "ContactCell.h"
#import "ModalAlert.h"
#import "AddressPreInfoVC.h"
#import "AddressAddSeniorVC.h"
#import "ABContactsHelper.h"
#import "CustomPicker.h"

@implementation AddressBookVC

/*
联系人列表的原始坐标和大小
*/
#define TABLEVIEW_X  53.0f
#define TABLEVIEW_Y   0.0f
#define TABLEVIEW_W 267.0f
#define TABLEVIEW_H 416.0f

#define SEARCH_BAR_H 44.0f

@synthesize m_pSearchDC;
@synthesize m_pSearchBar;
@synthesize m_pTableView_IB;
@synthesize m_pScrollView_IB;
@synthesize m_pImageView_IB;
@synthesize m_pRightAdd;

@synthesize filteredArray;
@synthesize contactNameArray;
@synthesize contactNameDic;
@synthesize sectionArray;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
    [super viewDidLoad];
	
	//m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	self.navigationItem.title = @"好帮手";
	self.navigationItem.rightBarButtonItem = m_pRightAdd;
	
	filteredArray    = [[NSMutableArray alloc] init];
	contactNameArray = [[NSMutableArray alloc] init];
	contactNameDic   = [[NSMutableDictionary alloc] init];
	sectionArray     = [[NSMutableArray alloc] initWithCapacity:27];
	
	// Create a search bar
	self.m_pSearchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(TABLEVIEW_X, 0, TABLEVIEW_W, SEARCH_BAR_H)] autorelease];
	self.m_pSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.m_pSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.m_pSearchBar.keyboardType = UIKeyboardTypeDefault;
	self.m_pSearchBar.delegate = self;
	self.m_pSearchBar.barStyle = UIBarStyleDefault;
	//self.m_pSearchBar.tintColor = [UIColor darkGrayColor];
	self.m_pTableView_IB.tableHeaderView = self.m_pSearchBar;
	
	// Create the search display controller
	self.m_pSearchDC = [[[UISearchDisplayController alloc] initWithSearchBar:self.m_pSearchBar contentsController:self] autorelease];
	self.m_pSearchDC.searchResultsDataSource = self;
	self.m_pSearchDC.searchResultsDelegate = self;
	
	//隐藏滚动条
	m_pScrollView_IB.showsVerticalScrollIndicator   = NO;
	m_pScrollView_IB.showsHorizontalScrollIndicator = NO;
	
	[self LoadGroup];

	[self initData:0];
}

-(void)LoadGroup
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:0];
	
	for(UIView * pView in m_pScrollView_IB.subviews)
	{
		[pView removeFromSuperview];
	}
	
	[m_pScrollView_IB setContentSize:CGSizeMake(TABLEVIEW_X, 0)];
	
	//添加全部
	GroupItemView * pLabel = nil;
	pLabel = [[[GroupItemView alloc] initWithFrame:CGRectMake(0,0,TABLEVIEW_X,40) 
												  :@"全部"
												  :[AllContactData.contactsArray count]] autorelease];
	
	[pLabel SetHidden:NO];
	pLabel.delegate = self;
	pLabel.tag = 0;
	
	[m_pScrollView_IB addSubview:pLabel];
	
	int nCount = [app.m_arrGroup count];
	
	//测试添加分组
	for(int i = 1; i <= nCount; i++)
	{
		ContactData * GroupContactData = (ContactData *)[app.m_arrContactData objectAtIndex:i];
		
		ABGroup * pGroup = [app.m_arrGroup objectAtIndex:(i - 1)];
		pLabel = [[[GroupItemView alloc] initWithFrame:CGRectMake(0,i * 40,TABLEVIEW_X,40) 
													  :pGroup.name 
													  :[GroupContactData.contactsArray count]] autorelease];
		
		pLabel.delegate = self;
		pLabel.tag = i;
		
		[m_pScrollView_IB addSubview:pLabel];
	}
		
	[m_pScrollView_IB setContentSize:CGSizeMake(TABLEVIEW_X, 40 * (nCount + 1))];
}

-(void)initData:(NSInteger)pIndex
{
	NSLog(@"initData");
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:pIndex];
	contacts = AllContactData.contactsArray;
	
	if([contacts count] < 1)
	{
		[contactNameArray removeAllObjects];
		[contactNameDic   removeAllObjects];
		for (int i = 0; i < 27; i++) 
			[self.sectionArray replaceObjectAtIndex:i withObject:[NSMutableArray array]];
		
		[m_pTableView_IB reloadData];
		return;
	}
	
	[contactNameArray removeAllObjects];
	[contactNameDic   removeAllObjects];
	[sectionArray     removeAllObjects];
	
	for (int i = 0; i < 27; i++)
		[self.sectionArray addObject:[NSMutableArray array]];
	
	for(ABContact *contact in contacts)
	{
		NSString *string = nil;
		
		if(contact.contactName && [contact.contactName length] > 0)
		{
			[contactNameArray addObject:contact.contactName];
			string = contact.contactName;
		}
		else
		{
			[contactNameArray addObject:[NSString stringWithFormat:@"无名"]];
			string = @"无名";
		}
	
		//NSLog(@"[%@]",string);
		//NSLog(@"[string%d]",[string length]);
		
		if([ContactData searchResult:string searchText:@"曾"])
			sectionName = @"Z";
		else if([ContactData searchResult:string searchText:@"解"])
			sectionName = @"X";
		else if([ContactData searchResult:string searchText:@"仇"])
			sectionName = @"Q";
		else if([ContactData searchResult:string searchText:@"朴"])
			sectionName = @"P";
		else if([ContactData searchResult:string searchText:@"查"])
			sectionName = @"Z";
		else if([ContactData searchResult:string searchText:@"能"])
			sectionName = @"N";
		else if([ContactData searchResult:string searchText:@"乐"])
			sectionName = @"Y";
		else if([ContactData searchResult:string searchText:@"单"])
			sectionName = @"S";
		else
			sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([string characterAtIndex:0])] uppercaseString];
		
		[self.contactNameDic setObject:string forKey:sectionName];
		
		NSUInteger firstLetter = [ALPHA rangeOfString:[sectionName substringToIndex:1]].location;
		
		if (firstLetter != NSNotFound)
			[[self.sectionArray objectAtIndex:firstLetter] addObject:contact];
	}
	
	[m_pTableView_IB reloadData];
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
	[m_pSearchDC      release];
	[m_pSearchBar     release];
	[m_pTableView_IB  release];
	[m_pScrollView_IB release];
	[m_pImageView_IB  release];
	[m_pRightAdd      release];
	
	[contactNameArray release];
	[contactNameDic	  release];
	[filteredArray	  release];
	[sectionArray	  release];
	[sectionName      release];
	
    [super dealloc];
}

#pragma mark UISearchBarDelegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)asearchBar
{
	NSLog(@"searchBarTextDidBeginEditing");
	
	self.m_pSearchBar.prompt = @"输入字母或汉字搜索";
	[self.m_pTableView_IB setFrame:CGRectMake(0,TABLEVIEW_Y,TABLEVIEW_W + TABLEVIEW_X,TABLEVIEW_H)];
	[self.m_pSearchBar setFrame:CGRectMake(0, 0, TABLEVIEW_W + TABLEVIEW_X, SEARCH_BAR_H)];
	
	[m_pScrollView_IB setHidden:YES];
	[m_pImageView_IB  setHidden:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	NSLog(@"searchBarCancelButtonClicked");
	
	[self.m_pSearchBar setText:@""];
	self.m_pSearchBar.prompt = nil;
	[self.m_pSearchBar setFrame:CGRectMake(TABLEVIEW_X, 0, TABLEVIEW_W, SEARCH_BAR_H)];
	
	self.m_pTableView_IB.tableHeaderView = self.m_pSearchBar;
	[self.m_pTableView_IB setFrame:CGRectMake(TABLEVIEW_X,TABLEVIEW_Y,TABLEVIEW_W,TABLEVIEW_H)];
	
	[m_pScrollView_IB setHidden:NO];
	[m_pImageView_IB  setHidden:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	NSLog(@"searchBarSearchButtonClicked");
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
	NSLog(@"searchBarBookmarkButtonClicked");
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar 
{
	NSLog(@"searchBarResultsListButtonClicked");
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	NSLog(@"searchBarTextDidEndEditing");
	
	[self.m_pSearchBar setText:@""];
	self.m_pSearchBar.prompt = nil;
	[self.m_pSearchBar setFrame:CGRectMake(TABLEVIEW_X, 0, TABLEVIEW_W, SEARCH_BAR_H)];
	
	self.m_pTableView_IB.tableHeaderView = self.m_pSearchBar;
	[self.m_pTableView_IB setFrame:CGRectMake(TABLEVIEW_X,TABLEVIEW_Y,TABLEVIEW_W,TABLEVIEW_H)];
	
	[m_pScrollView_IB setHidden:NO];
	[m_pImageView_IB  setHidden:NO];
}

#pragma mark TableView methods

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//NSLog(@"cellForRowAtIndexPath");
	
	UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	ContactCell *cell = (ContactCell*)[aTableView dequeueReusableCellWithIdentifier:KContactCell_ID];
	if (!cell)
		cell = [[[ContactCell alloc] initWithStyle:style reuseIdentifier:KContactCell_ID] autorelease];
	
	ABContact *contact = nil;
	
	// Retrieve the crayon and its color
	if (aTableView == self.m_pTableView_IB)
		contact = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	else
		contact = [self.filteredArray objectAtIndex:indexPath.row];
	
	cell.m_pName.text = [NSString stringWithCString:[contact.contactName UTF8String] encoding:NSUTF8StringEncoding];
	
	if(contact.image)
	{
		cell.m_pHead.image = contact.image;
	}
	else 
	{
		cell.m_pHead.image = [UIImage imageNamed:@"head.png"];
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
	//NSLog(@"didSelectRowAtIndexPath");
	
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	//NSError * error;
	
	ABContact *contact = nil;
	
	if (aTableView == self.m_pTableView_IB)
		contact = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	else
		contact = [self.filteredArray objectAtIndex:indexPath.row];
	
	//test 设置分组
	//ABGroup * pGroup = [app.m_arrGroup objectAtIndex:1];
	//BOOL pB = [pGroup addMember:contact withError:&error];
	
	AddressPreInfoVC * pAddressPreInfoVC = [[AddressPreInfoVC alloc] init];
	pAddressPreInfoVC.m_pContact = contact;
	
	[self.navigationController pushViewController:pAddressPreInfoVC animated:YES];
	 
	[pAddressPreInfoVC release];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"canEditRowAtIndexPath");
	
	if(aTableView == self.m_pTableView_IB)
		// Return NO if you do not want the specified item to be editable.
		return YES;
	else
		return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSLog(@"commitEditingStyle");
	
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
	//NSLog(@"numberOfSectionsInTableView");
	
	if(aTableView == self.m_pTableView_IB) 
		return 27;
	return 1;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView 
{
	//NSLog(@"sectionIndexTitlesForTableView");
	
	if (aTableView == self.m_pTableView_IB)  // regular table
	{
		NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
		for (int i = 0; i < 27; i++) 
			if ([[sectionArray objectAtIndex:i] count])
				[indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
		//[indices addObject:@"\ue057"]; // <-- using emoji
		return indices;
	}
	else return nil; // search table
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	//NSLog(@"sectionForSectionIndexTitle");
	
	if (title == UITableViewIndexSearch)
	{
		[self.m_pTableView_IB scrollRectToVisible:self.m_pSearchBar.frame animated:NO];
		return -1;
	}
	return [ALPHA rangeOfString:title].location;
}




- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
	//NSLog(@"titleForHeaderInSection");
	
	if (aTableView == self.m_pTableView_IB) 
	{
		if ([self.sectionArray count] > 0 && [[self.sectionArray objectAtIndex:section] count] == 0) 
			return nil;
		return [NSString stringWithFormat:@"%@", [[ALPHA substringFromIndex:section] substringToIndex:1]];
	}
	else return nil;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	//NSLog(@"numberOfRowsInSection");
	
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	//[self initData];
	// Normal table
	if (aTableView == self.m_pTableView_IB && [self.sectionArray count]) 
		return [[self.sectionArray objectAtIndex:section] count];
	else
		[filteredArray removeAllObjects];
	
	// Search table
	// 搜索算法太慢，需要优化
	
	for(ABContact *contact in contacts)
	{
		NSString *string = contact.contactName;
		NSString *name = @"";
		for (int i = 0; i < [string length]; i++)
		{
			if([name length] < 1)
				name = [NSString stringWithFormat:@"%c",pinyinFirstLetter([string characterAtIndex:i])];
			else
				name = [NSString stringWithFormat:@"%@%c",name,pinyinFirstLetter([string characterAtIndex:i])];
		}
		if ([ContactData searchResult:name searchText:self.m_pSearchBar.text])
			[filteredArray addObject:contact];
		else 
		{
			if ([ContactData searchResult:string searchText:self.m_pSearchBar.text])
				[filteredArray addObject:contact];
			else 
			{
				NSArray  * phoneArray = nil;
				NSString * phone = @"";
				
				if(contact)
				{
					phoneArray = [ContactData getPhoneNumberAndPhoneLabelArray:contact];
				}
				
				if(phoneArray && [phoneArray count] == 1)
				{
					NSDictionary *PhoneDic = [phoneArray objectAtIndex:0];
					phone = [ContactData getPhoneNumberFromDic:PhoneDic];
					if([ContactData searchResult:phone searchText:self.m_pSearchBar.text])
						[filteredArray addObject:contact];
				}
				else  if(phoneArray && [phoneArray count] > 1)
				{
					for(NSDictionary *dic in phoneArray)
					{
						phone = [ContactData getPhoneNumberFromDic:dic];
						if([ContactData searchResult:phone searchText:self.m_pSearchBar.text])
						{
							[filteredArray addObject:contact];
							break;
						}
					}
				}
			}
		}
	}
	
	/*
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
		if ([ContactData searchResult:name searchText:self.m_pSearchBar.text])
			[filteredArray addObject:string];
		else 
		{
			if ([ContactData searchResult:string searchText:self.m_pSearchBar.text])
				[filteredArray addObject:string];
			else 
			{
				ABContact *contact = [app.m_pContactData byNameToGetContact:string];
				
				NSArray  * phoneArray = nil;
				NSString * phone = @"";
				
				if(contact)
				{
					phoneArray = [ContactData getPhoneNumberAndPhoneLabelArray:contact];
				}
				
				if(phoneArray && [phoneArray count] == 1)
				{
					NSDictionary *PhoneDic = [phoneArray objectAtIndex:0];
					phone = [ContactData getPhoneNumberFromDic:PhoneDic];
					if([ContactData searchResult:phone searchText:self.m_pSearchBar.text])
						[filteredArray addObject:string];
				}
				else  if(phoneArray && [phoneArray count] > 1)
				{
					for(NSDictionary *dic in phoneArray)
					{
						phone = [ContactData getPhoneNumberFromDic:dic];
						if([ContactData searchResult:phone searchText:self.m_pSearchBar.text])
						{
							[filteredArray addObject:string];	
							break;
						}
					}
				}
			}
		}
	}
	*/
	
	
	return self.filteredArray.count;
}


-(IBAction)editItemBtn:(id)sender
{
	
}


-(IBAction)addItemBtn: (id)sender
{
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
															 delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil
													otherButtonTitles:@"新建分组", @"新建联系人", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	//[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	
	[actionSheet showInView:[self.view superview]];
	[actionSheet release];
}

#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller. 
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:NO];
	
	//[self.view setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
	
	if(person)
	{
		//点击完成
		AddressAddSeniorVC * pVc = [[AddressAddSeniorVC alloc] init];
		
		[self.navigationController pushViewController:pVc animated:NO];
		
		[pVc release];
	}
}

#pragma mark GroupItem methods
-(void) GroupItemViewSelect:(NSInteger)pIndex
{
	for(GroupItemView * pGroup in [m_pScrollView_IB subviews])
	{
		if(pGroup.tag == pIndex)
		{
			[pGroup SetHidden:NO];
		}
		else 
		{
			[pGroup SetHidden:YES];
		}
		
		[self initData:pIndex];
	}
}

- (void)GreateNewGroup
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	NSString * pStr = [ModalAlert ask:@"新建分组" withTextPrompt:@"请输入组名称"];
	
	if(pStr)
	{
		NSLog(@"NewGroupName[%@]",pStr);
		
		//创建新的分组
		NSError * error;
		ABGroup * pNew = [ABGroup group];
		pNew.name = pStr;
		if([ABContactsHelper addGroup:pNew withError:&error])
		{
			//分组信息入库
			[DataStore insertGroup:pNew];
			
			[app.m_arrGroup addObject:pNew];
		}
		
		[self LoadGroup];
	}
}

- (void)GreateNewPerson
{
	//调用系统的添加联系人界面
	ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
	picker.newPersonViewDelegate = self;
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
	[self presentModalViewController:navigation animated:YES];
	
	[picker release];
	[navigation release];
}

#pragma mark actionSheet methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		//新建分组
		[self performSelector:@selector(GreateNewGroup)  withObject:nil afterDelay:0.1];
	}
	else if(buttonIndex == 1)
	{
		//新建联系人
		[self performSelector:@selector(GreateNewPerson) withObject:nil afterDelay:0.1];
	}
}



@end
