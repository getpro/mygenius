    //
//  memoVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "memoVC.h"
#import "AddressBookAppDelegate.h"

@implementation memoVC

@synthesize m_pSearchDC;
@synthesize m_pSearchBar;
@synthesize m_pTableView_IB;
@synthesize m_pRightAdd;

@synthesize eventsList, eventStore, defaultCalendar, detailViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"备忘录";
	self.navigationItem.rightBarButtonItem = m_pRightAdd;
	
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
	
	// Initialize an event store object with the init method. Initilize the array for events.
	self.eventStore = [[EKEventStore alloc] init];
	
	self.eventsList = [[NSMutableArray alloc] initWithArray:0];
	
	// Get the default calendar from store.
	self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
	
	//NSArray * p = [self.eventStore calendars];
	
	//self.navigationController.delegate = self;
	
	// Fetch today's event on selected calendar and put them into the eventsList array
	[self.eventsList addObjectsFromArray:[self fetchEventsForToday]];
	
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
	
	self.eventsList = nil;
}


- (void)dealloc 
{
	[m_pSearchDC     release];
	[m_pSearchBar    release];
	[m_pTableView_IB release];
	[m_pRightAdd     release];
	
	[eventStore			  release];
	[eventsList			  release];
	[defaultCalendar	  release];
	[detailViewController release];
	
    [super dealloc];
}

-(IBAction)addItemBtn:(id)sender
{
	// When add button is pushed, create an EKEventEditViewController to display the event.
	EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
	
	// set the addController's event store to the current event store.
	addController.eventStore = self.eventStore;
	
	// present EventsAddViewController as a modal view controller
	[self presentModalViewController:addController animated:YES];
	
	addController.editViewDelegate = self;
	[addController release];
}



// Fetching events happening in the next 24 hours with a predicate, limiting to the default calendar 
- (NSArray *)fetchEventsForToday 
{	
	NSDate *startDate = [NSDate date];
	
	// endDate is 1 day = 60*60*24 seconds = 86400 seconds from startDate
	NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:86400];
	
	// Create the predicate. Pass it the default calendar.
	NSArray *calendarArray = [NSArray arrayWithObject:defaultCalendar];
	
	NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate 
																	calendars:calendarArray]; 
	
	// Fetch all events that match the predicate.
	NSArray *events = [self.eventStore eventsMatchingPredicate:predicate];
	
	return events;
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

#pragma mark -
#pragma mark Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return eventsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"memoCell";
	
	// Add disclosure triangle to cell
	UITableViewCellAccessoryType editableCellAccessoryType =UITableViewCellAccessoryDisclosureIndicator;
	
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.accessoryType = editableCellAccessoryType;
	
	// Get the event at the row selected and display it's title
	cell.textLabel.text = [[self.eventsList objectAtIndex:indexPath.row] title];
	
	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	// Upon selecting an event, create an EKEventViewController to display the event.
	self.detailViewController = [[EKEventViewController alloc] initWithNibName:nil bundle:nil];			
	detailViewController.event = [self.eventsList objectAtIndex:indexPath.row];
	
	// Allow event editing.
	detailViewController.allowsEditing = YES;
	
	//	Push detailViewController onto the navigation controller stack
	//	If the underlying event gets deleted, detailViewController will remove itself from
	//	the stack and clear its event property.
	[self.navigationController pushViewController:detailViewController animated:YES];
	
}

#pragma mark -
#pragma mark Navigation Controller delegate

- (void)navigationController:(UINavigationController *)navigationController 
	  willShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
	// if we are navigating back to the rootViewController, and the detailViewController's event
	// has been deleted -  will title being NULL, then remove the events from the eventsList
	// and reload the table view. This takes care of reloading the table view after adding an event too.
	if (viewController == self && self.detailViewController.event.title == NULL) 
	{
		[self.eventsList removeObject:self.detailViewController.event];
		[m_pTableView_IB reloadData];
	}
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[m_pTableView_IB deselectRowAtIndexPath:m_pTableView_IB.indexPathForSelectedRow animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark EKEventEditViewDelegate

// Overriding EKEventEditViewDelegate method to update event store according to user actions.
- (void)eventEditViewController:(EKEventEditViewController *)controller 
		  didCompleteWithAction:(EKEventEditViewAction)action 
{
	NSError *error = nil;
	EKEvent *thisEvent = controller.event;
	
	switch (action) 
	{
		case EKEventEditViewActionCanceled:
			// Edit action canceled, do nothing. 
			break;
			
		case EKEventEditViewActionSaved:
			// When user hit "Done" button, save the newly created event to the event store, 
			// and reload table view.
			// If the new event is being added to the default calendar, then update its 
			// eventsList.
			if (self.defaultCalendar ==  thisEvent.calendar) 
			{
				[self.eventsList addObject:thisEvent];
			}
			[controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
			[m_pTableView_IB reloadData];
			break;
			
		case EKEventEditViewActionDeleted:
			// When deleting an event, remove the event from the event store, 
			// and reload table view.
			// If deleting an event from the currenly default calendar, then update its 
			// eventsList.
			if (self.defaultCalendar ==  thisEvent.calendar) 
			{
				[self.eventsList removeObject:thisEvent];
			}
			[controller.eventStore removeEvent:thisEvent span:EKSpanThisEvent error:&error];
			[m_pTableView_IB reloadData];
			break;
			
		default:
			break;
	}
	// Dismiss the modal view controller
	[controller dismissModalViewControllerAnimated:YES];
	
}


// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller 
{
	EKCalendar *calendarForEdit = self.defaultCalendar;
	return calendarForEdit;
}

@end
