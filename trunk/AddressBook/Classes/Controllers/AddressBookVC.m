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

-(void)getGroupResult:(id)index
{
	NSString * pIndex = (NSString*)index;
	
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	ABGroup * pGroup = [app.m_arrGroup objectAtIndex:[pIndex intValue]];
	
	if(pGroup)
	{
		NSLog(@"Group[%@]",pGroup.name);
		if([ModalAlert ask:@"是否确认移动分组?" withCancel:@"取消" withButtons:nil])
		{
			ABContact *contact = nil;
			NSError   *error;
			
			for(int pSection = 0;pSection < [self.sectionArray count];pSection++)
			{
				for(int pRow = 0;pRow < [[self.sectionArray objectAtIndex:pSection] count];pRow++)
				{
					NSIndexPath * indexPath = [NSIndexPath indexPathForRow:pRow inSection:pSection];
					ContactCell  *cell = (ContactCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
					
					if(cell && cell.m_IsSelect)
					{
						contact = [[self.sectionArray objectAtIndex:pSection] objectAtIndex:pRow];
						if(contact)
						{
							//移动分组
							ABRecordID  pRecordID  = ABRecordGetRecordID(contact.record);
							
							//移动之前的分组ID
							int nowGroupID = [DataStore GetGroupID2:pRecordID];
							
							//设置新分组
							ABRecordID pGroupID = pGroup.recordID;
							
							if(nowGroupID != pGroupID)
							{
								//设置新分组
								ABGroup * pGroup = nil;
								for(pGroup in app.m_arrGroup)
								{
									if(ABRecordGetRecordID(pGroup.record) == pGroupID)
									{
										break;
									}
								}
								
								if([pGroup addMember:contact withError:&error])
								{
									[DataStore updateGroup:pRecordID:pGroupID];
								}
								
								//移除老分组
								ABGroup * pNowGroup = nil;
								if(nowGroupID > 0)
								{
									for(pNowGroup in app.m_arrGroup)
									{
										if(ABRecordGetRecordID(pNowGroup.record) == nowGroupID)
										{
											break;
										}
									}
									
									if([pNowGroup removeMember:contact withError:&error])
									{
										//[DataStore updateGroup:pRecordID:0];
									}
								}
							}
						}
					}
				}
			}
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"changeAddress" object:nil];
			
			//取消
			isLongPress = NO;
			[m_pCheckBox removeFromSuperview];
			
			[self LoadGroup];
			
			[self initData:m_nGroupIndex];
		}
	}
}

-(void)GetPressed:(id)sender
{
	NSString * pStr = (NSString*)sender;
	switch ([pStr intValue]) 
	{
		case 0:
		{
			AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
			
			//移动组
			NSMutableArray * DateArry = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
			
			for(int i = 0; i < [app.m_arrGroup count]; i++)
			{
				ABGroup * pGroup = [app.m_arrGroup objectAtIndex:(i)];
				[DateArry addObject:pGroup.name];
			}
			
			m_pGroupPicker.sourceArray = DateArry;
			[app.window addSubview:m_pGroupPicker];
			
		}
			break;
		case 1:
		{
			//删除
			if([ModalAlert ask:@"是否确认删除?" withCancel:@"取消" withButtons:nil])
			{
				ABContact *contact = nil;
				
				for(int pSection = 0;pSection < [self.sectionArray count];pSection++)
				{
					for(int pRow = 0;pRow < [[self.sectionArray objectAtIndex:pSection] count];pRow++)
					{
						NSIndexPath * indexPath = [NSIndexPath indexPathForRow:pRow inSection:pSection];
						ContactCell  *cell = (ContactCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
						
						if(cell && cell.m_IsSelect)
						{
							contact = [[self.sectionArray objectAtIndex:pSection] objectAtIndex:pRow];
							if(contact && [ContactData removeSelfFromAddressBook:contact.record])
							{
								[DataStore RemoveContact:contact.record];
							}
						}
					}
				}
				
				[[NSNotificationCenter defaultCenter] postNotificationName:@"changeAddress" object:nil];
				
				//取消
				isLongPress = NO;
				[m_pCheckBox removeFromSuperview];
				
				[self LoadGroup];
				
				[self initData:m_nGroupIndex];
			}
		}
			break;
		case 2:
		{
			//取消
			isLongPress = NO;
			[m_pCheckBox removeFromSuperview];
			[m_pTableView_IB reloadData];
		}
			break;
		default:
			break;
	}
}

- (void)LongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
	NSLog(@"LongPress");
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) 
	{
        NSLog(@"LongPressBegin");
		
    }
	else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded)
	{
		NSLog(@"LongPressEnd");
		isLongPress = YES;
		//[app setBottomHiden:YES];
		
		[app.window addSubview:m_pCheckBox];
		
		[m_pTableView_IB reloadData];
	}
}

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
	sectionArray     = [[NSMutableArray alloc] initWithCapacity:28];
	
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
	
	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPress:)];
	
    [m_pTableView_IB addGestureRecognizer:longPressGesture];
	
    [longPressGesture release];
	
	m_pCheckBox = [[CheckBox alloc] initWithFrame:CGRectMake(0,424,320,56)];
	m_pCheckBox.Target   = self;
	m_pCheckBox.Selector = @selector(GetPressed:);
	
	m_pGroupPicker = [[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
	m_pGroupPicker.Target   = self;
	m_pGroupPicker.Selector = @selector(getGroupResult:);
	
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
	if(m_nGroupIndex == 0)
	{
		[pLabel SetHidden:NO];
	}
	pLabel.delegate = self;
	pLabel.tag = 0;
	
	[m_pScrollView_IB addSubview:pLabel];
	
	int nCount = [app.m_arrGroup count];
	
	//添加分组
	for(int i = 1; i <= nCount; i++)
	{
		ContactData * GroupContactData = (ContactData *)[app.m_arrContactData objectAtIndex:i];
		
		ABGroup * pGroup = [app.m_arrGroup objectAtIndex:(i - 1)];
		pLabel = [[[GroupItemView alloc] initWithFrame:CGRectMake(0,i * 40,TABLEVIEW_X,40) 
													  :pGroup.name 
													  :[GroupContactData.contactsArray count]] autorelease];
		
		pLabel.delegate = self;
		pLabel.tag = i;
		
		if(m_nGroupIndex == i)
		{
			[pLabel SetHidden:NO];
		}
		
		[m_pScrollView_IB addSubview:pLabel];
	}
		
	[m_pScrollView_IB setContentSize:CGSizeMake(TABLEVIEW_X, 40 * (nCount + 1))];
}

-(void)initData:(NSInteger)pIndex
{
	m_nGroupIndex = pIndex;
	
	NSLog(@"initData");
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:pIndex];
	contacts = AllContactData.contactsArray;
	
	if([contacts count] < 1)
	{
		[contactNameArray removeAllObjects];
		[contactNameDic   removeAllObjects];
		for (int i = 0; i < 28; i++)
			[self.sectionArray replaceObjectAtIndex:i withObject:[NSMutableArray array]];
		
		[m_pTableView_IB reloadData];
		return;
	}
	
	[contactNameArray removeAllObjects];
	[contactNameDic   removeAllObjects];
	[sectionArray     removeAllObjects];
	
	for (int i = 0; i < 28; i++)
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
		{
			[[self.sectionArray objectAtIndex:firstLetter] addObject:contact];
		}
		else
		{
			//添加到# Section
			[[self.sectionArray objectAtIndex:27] addObject:contact];
		}
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
	
	[m_pCheckBox      release];
	[m_pGroupPicker   release];
	
    [super dealloc];
}

#pragma mark UISearchBarDelegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)asearchBar
{
	NSLog(@"searchBarTextDidBeginEditing");
	
	isLongPress = NO;
	[m_pCheckBox removeFromSuperview];
	
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
	
	//这里有问题
	/*
	[self.m_pSearchBar setText:@""];
	self.m_pSearchBar.prompt = nil;
	[self.m_pSearchBar setFrame:CGRectMake(TABLEVIEW_X, 0, TABLEVIEW_W, SEARCH_BAR_H)];
	
	self.m_pTableView_IB.tableHeaderView = self.m_pSearchBar;
	[self.m_pTableView_IB setFrame:CGRectMake(TABLEVIEW_X,TABLEVIEW_Y,TABLEVIEW_W,TABLEVIEW_H)];
	
	[m_pScrollView_IB setHidden:NO];
	[m_pImageView_IB  setHidden:NO];
	*/
}

#pragma mark TableView methods

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//NSLog(@"cellForRowAtIndexPath");
	UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	
	ContactCell * cell = (ContactCell*)[aTableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@_%d_%d",KContactCell_ID,indexPath.section,indexPath.row]];
	if (!cell)
	cell = [[[ContactCell alloc] initWithStyle:style reuseIdentifier:[NSString stringWithFormat:@"%@_%d_%d",KContactCell_ID,indexPath.section,indexPath.row]] autorelease];
	
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

	if(isLongPress)
	{
		[cell setOffSet:YES];
	}
	else
	{
		[cell setOffSet:NO];
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
	
	ABContact *contact = nil;
	
	if (aTableView == self.m_pTableView_IB)
		contact = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	else
		contact = [self.filteredArray objectAtIndex:indexPath.row];
	
	if(isLongPress)
	{
		if (aTableView == self.m_pTableView_IB)
		{
			ContactCell  *cell = (ContactCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
			if(cell.m_IsSelect)
			{
				[cell setSelect:NO];
			}
			else
			{
				[cell setSelect:YES];
			}
		}
	}
	else
	{
		AddressPreInfoVC * pAddressPreInfoVC = [[AddressPreInfoVC alloc] init];
		pAddressPreInfoVC.m_pContact = contact;
		
		[self.navigationController pushViewController:pAddressPreInfoVC animated:YES];
		
		[pAddressPreInfoVC release];
	}
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"canEditRowAtIndexPath");
	
	if(aTableView == self.m_pTableView_IB)
		// Return NO if you do not want the specified item to be editable.
		return NO;
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
		return 28;
	return 1;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView 
{
	//NSLog(@"sectionIndexTitlesForTableView");
	
	if (aTableView == self.m_pTableView_IB)  // regular table
	{
		NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
		for (int i = 0; i < 28; i++)
			if ([[sectionArray objectAtIndex:i] count])
			{
				if(i == 27)
				{
					[indices addObject:@"#"];
				}
				else
				{
					[indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
				}
			}
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
		if(section == 27)
			return @"#";
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

ABRecordRef GRecord;

-(void)AddGp:(id)p1
{
	CFErrorRef  error;
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	//ABRecordRef aRecord = (ABRecordRef)p1;
	
	ABGroup * pGroup = [app.m_arrGroup objectAtIndex:2];
	
    @try 
	{ 
		
        //ABAddressBookSave(addressBook, &error);         // 如果出现异常错误
		[pGroup addMember2:GRecord withError:&error];
    }
    @catch (NSException *exception) 
	{
		
        NSLog(@"%@:%@", [exception name], [exception reason]);    //抓错，系统报错
		
    }
	
    @finally {
		
    }
	
	//int p = 0;
	
	//CFErrorGetCode(error);
	
	//NSLog(@"[%d]",p);
}

#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller. 
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:NO];
	
	//[self.view setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
	
	if(person)
	{
		[DataStore insertContactsBaseInfo:person];
		
		CFErrorRef   errorRef;
		
		ABAddressBookAddRecord(addressBook,person,&errorRef);
		ABAddressBookSave(addressBook, &errorRef);
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"changeAddress" object:nil];
		
		//点击完成
		AddressAddSeniorVC * pVc = [[AddressAddSeniorVC alloc] init];
		pVc.m_pContact = [ABContact contactWithRecord:person];
		
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
			[self initData:pIndex];
		}
		else 
		{
			[pGroup SetHidden:YES];
		}
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
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"changeAddress" object:nil];
		
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

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self LoadGroup];
	
	[self initData:0];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

@end
