    //
//  dateVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "statisticsVC.h"
#import "AddressBookAppDelegate.h"

@implementation statisticsVC

@synthesize m_pSearchDC;
@synthesize m_pSearchBar;
@synthesize m_pTableView_IB;
@synthesize m_pStartDate;
@synthesize m_pEndDate;
@synthesize m_pABContact;
@synthesize eventsList;
@synthesize sectionArray;
@synthesize sectionTitle;

-(void)GetDatePressed:(id)sender
{
	statisticsCheckVC * pStatisticsCheckVC = [[statisticsCheckVC alloc] init];
	pStatisticsCheckVC.delegate = self;
	pStatisticsCheckVC.m_pStartDate = m_pStartDate;
	pStatisticsCheckVC.m_pEndDate   = m_pEndDate;
	
	[self.navigationController pushViewController:pStatisticsCheckVC animated:YES];
	
	[pStatisticsCheckVC release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"日程查询";
	
	eventsList   = [[NSMutableArray alloc] initWithArray:0];
	sectionArray = [[NSMutableArray alloc] initWithArray:0];
	sectionTitle = [[NSMutableArray alloc] initWithArray:0];
	
	// Create a search bar
	self.m_pSearchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
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
	
	NSDate *NowDate = [NSDate date];
    NSDateFormatter* indateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [indateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *dateStr   = [indateFormatter stringFromDate:NowDate];
    NSDate   *startDate = [indateFormatter dateFromString:dateStr];
	self.m_pStartDate   = startDate;
	
	// endDate is 1 day = 60*60*24 seconds = 86400 seconds from startDate
	self.m_pEndDate     = [NSDate dateWithTimeInterval:86400 * 7 sinceDate:self.m_pStartDate];
	
	m_pDateButton = [[checkDateButton alloc] initWithFrame:CGRectMake(6,7,50,30)];
	[m_pDateButton setButtonDate:self.m_pStartDate :self.m_pEndDate];
	[self.navigationController.navigationBar addSubview:m_pDateButton];
	m_pDateButton.Target   = self;
	m_pDateButton.Selector = @selector(GetDatePressed:);
	
	
	
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
	[m_pABContact   release];
	[m_pStartDate	release];
	[m_pEndDate	    release];
	[eventsList     release];
	[sectionArray   release];
	[sectionTitle   release];
	
    [super dealloc];
}

#pragma mark UISearchBarDelegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)asearchBar
{
	//self.searchBar.prompt = @"输入字母、汉字或电话号码搜索";
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[self.m_pSearchBar setText:@""]; 
	self.m_pSearchBar.prompt = nil;
	[self.m_pSearchBar setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
	self.m_pTableView_IB.tableHeaderView = self.m_pSearchBar;	
}

#pragma mark TableView methods

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//static NSString *CellIdentifier = @"memoCell";
	
	// Add disclosure triangle to cell
	UITableViewCellAccessoryType editableCellAccessoryType = UITableViewCellAccessoryNone;
	
	MemoCell *cell = (MemoCell*)[aTableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"memoCell_%d_%d",indexPath.section,indexPath.row]];
	if (cell == nil)
	{
		cell = [[[MemoCell alloc] initWithStyle:UITableViewCellStyleDefault 
								reuseIdentifier:[NSString stringWithFormat:@"memoCell_%d_%d",indexPath.section,indexPath.row]] autorelease];
	}
	
	cell.accessoryType = editableCellAccessoryType;
	
	// Get the event at the row selected and display it's title
	//EKEvent * pEvent = (EKEvent*)[self.eventsList objectAtIndex:indexPath.row];
	EKEvent * pEvent = (EKEvent*)[[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	if(pEvent)
	{
		cell.m_pTitle.text  = [pEvent title];
		cell.m_pLocate.text = [pEvent location];
		
		NSLog(@"Event[%@]",pEvent.eventIdentifier);
		NSLog(@"Event[%@]",pEvent.title);
		
		if([pEvent isAllDay])
		{
			cell.m_pTime.text = @"全天";
		}
		else
		{
			NSDate * pStartDate = [pEvent startDate];
			NSDate * pEndDate   = [pEvent endDate];
			
			NSDateFormatter *Formatter = [[[NSDateFormatter alloc] init] autorelease];
			[Formatter setDateFormat:@"HH:mm"];
			
			NSString *StartString = [Formatter stringFromDate:pStartDate];
			NSString *EndString   = [Formatter stringFromDate:pEndDate];
			
			//NSLog(@"[%@]",StartString);
			//NSLog(@"[%@]",EndString);
			cell.m_pTime.text = [NSString stringWithFormat:@"%@-%@",StartString,EndString];
		}
		
		NSString * pNote = [pEvent notes];
		if(pNote)
		{
			[self checkType:pNote:cell];
		}
		else
		{
			cell.m_pType.text = @"";
		}
	}
	
	/*
	if(isLongPress)
	{
		[cell setOffSet:YES];
	}
	else
	{
		[cell setOffSet:NO];
	}
	*/
	
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
	return [sectionArray count];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView 
{
	return nil; // search table
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return -1;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
	NSDate * pDateTitle = (NSDate*)[sectionTitle objectAtIndex:section];
	//通过日期推算星期的代码
	NSDateFormatter *outputFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[outputFormatter setDateFormat:@"EEEE                          MMMM d yyyy"];
	
	NSString *newDateString = [outputFormatter stringFromDate:pDateTitle];
	
	return newDateString;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	return [[self.sectionArray objectAtIndex:section] count];
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[m_pDateButton setHidden:NO];
	
	[self fetchEvents];
	
	[m_pTableView_IB reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[m_pDateButton setHidden:YES];
}

#pragma markCheckCallBack
-(void)CheckCallBack:(NSDate*)pStartData :(NSDate*)pEndData :(ABContact*)pABContact
{
	self.m_pStartDate = pStartData;
	self.m_pEndDate   = pEndData;
	self.m_pABContact = pABContact;
	
	[m_pDateButton setButtonDate:self.m_pStartDate :self.m_pEndDate];
}

-(void) checkType:(NSString*)pStr :(MemoCell*)pCell
{
	NSRange pRang = [pStr rangeOfString:@"生日"];
	
	if(pRang.length)
	{
		pCell.m_pType.text = @"生日";
		return;
	}
	
	pRang = [pStr rangeOfString:@"纪念日"];
	
	if(pRang.length)
	{
		pCell.m_pType.text = @"纪念日";
		return;
	}
	
	pCell.m_pType.text = @"";
}

// Fetching events happening in the next 24 hours with a predicate, limiting to the default calendar 
- (void)fetchEvents 
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	[self.eventsList   removeAllObjects];
	[self.sectionArray removeAllObjects];
	[self.sectionTitle removeAllObjects];
	
	// Create the predicate. Pass it the default calendar.
	//NSArray *calendarArray = [NSArray arrayWithObject:app.defaultCalendar];
	
	NSDate *endDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.m_pEndDate];
	
	NSPredicate *predicate = [app.eventStore predicateForEventsWithStartDate:self.m_pStartDate 
																	 endDate:endDate 
																   calendars:nil]; 
	
	// Fetch all events that match the predicate.
	NSArray *events = [app.eventStore eventsMatchingPredicate:predicate];
	
	//NSLog(@"%@",events);
	
	[self.eventsList addObjectsFromArray:events];
	
	int nCount = (int)([m_pEndDate timeIntervalSince1970] - [m_pStartDate timeIntervalSince1970])/86400;
	
	NSLog(@"nCount[%d]",nCount + 1);
	
	for (int i = 0; i < nCount + 1; i++)
		[self.sectionArray addObject:[NSMutableArray array]];
	
	for (int i = 0; i < nCount + 1; i++)
	{
		NSDate *TitleDate = [NSDate dateWithTimeInterval:86400*i sinceDate:self.m_pStartDate];
		
		[sectionTitle addObject:TitleDate];
	}
	
	for(EKEvent * pEvent in self.eventsList)
	{
		NSDateFormatter* indateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[indateFormatter setDateFormat:@"yyyy-MM-dd"];
		
		NSString *dateStr = [indateFormatter stringFromDate:[pEvent startDate]];
		NSDate   *startDate = [indateFormatter dateFromString:dateStr];
		
		for (int i = 0; i < nCount + 1; i++)
		{
			NSDate * pDateTitle = (NSDate*)[sectionTitle objectAtIndex:i];
			
			if([startDate isEqualToDate:pDateTitle])
			{
				[[sectionArray objectAtIndex:i] addObject:pEvent];
				break;
			}
		}
	}
	
}

@end
