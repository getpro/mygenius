    //
//  dateVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "statisticsVC.h"
#import "statisticsCheckVC.h"

@implementation statisticsVC

@synthesize m_pSearchDC;
@synthesize m_pSearchBar;
@synthesize m_pTableView_IB;
@synthesize m_pStartDate;
@synthesize m_pEndDate;

-(void)GetDatePressed:(id)sender
{
	statisticsCheckVC * pStatisticsCheckVC = [[statisticsCheckVC alloc] init];
	
	[self.navigationController pushViewController:pStatisticsCheckVC animated:YES];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"日程查询";
	
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
	[m_pStartDate	release];
	[m_pEndDate	    release];
	
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
	return nil;
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
	return 0;
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
	return nil;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	return 0;
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[m_pDateButton setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[m_pDateButton setHidden:YES];
}

@end
