    //
//  memoVC.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "memoVC.h"
#import "CustomDatePicker.h"
#import "AddressBookAppDelegate.h"
#import "ModalAlert.h"

@implementation memoVC

@synthesize m_pTableView_IB;
@synthesize m_pRightAdd;
@synthesize m_pDate;

@synthesize eventsList,detailViewController;

-(void)getTimeResult:(id)index
{
	NSDate * date = (NSDate*)index;
	
	self.m_pDate = date;
	
	[m_pDateButton setButtonDate:self.m_pDate];
	
	[self fetchEventsForToday];
	
	[m_pTableView_IB reloadData];
}

-(void)GetDatePressed:(id)sender
{
	isLongPress = NO;
	[m_pMemoCheckBox removeFromSuperview];
	
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	CustomDatePicker *tvc = [[[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) DatePickerMode:UIDatePickerModeDate] autorelease];
	tvc.Target   = self;
	tvc.Selector = @selector(getTimeResult:);			
	[app.window addSubview:tvc];
}

-(void)GetPressed:(id)sender
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	NSString * pStr = (NSString*)sender;
	switch ([pStr intValue]) 
	{
		case 0:
		{
			//删除
			if([ModalAlert ask:@"是否确认删除?" withCancel:@"取消" withButtons:nil])
			{
				//临时数组
				NSMutableArray *pTempList = [NSMutableArray arrayWithCapacity:[self.eventsList count]];
				for(int pRow = 0;pRow < [self.eventsList count];pRow++)
				{
					EKEvent * pEvent = (EKEvent*)[self.eventsList objectAtIndex:pRow];
					[pTempList addObject:pEvent];
				}
				
				for(int pRow = 0;pRow < [self.eventsList count];pRow++)
				{
					NSIndexPath * indexPath = [NSIndexPath indexPathForRow:pRow inSection:0];
					MemoCell  *cell = (MemoCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
					
					if(cell && cell.m_IsSelect)
					{
						NSError * error = nil;
						EKEvent * pEvent = (EKEvent*)[self.eventsList objectAtIndex:pRow];
						if(pEvent)
						{
							if([app.eventStore removeEvent:pEvent span:EKSpanThisEvent error:&error])
							{
								[pTempList removeObject:pEvent];
								
								//如果是联系人的日历，移除数据库
								[DataStore removeDateEvent:pEvent.eventIdentifier];
							}
						}
					}
				}
				
				[self.eventsList removeAllObjects];
				for(int pRow = 0;pRow < [pTempList count];pRow++)
				{
					EKEvent * pEvent = (EKEvent*)[pTempList objectAtIndex:pRow];
					[self.eventsList addObject:pEvent];
				}
				
				isLongPress = NO;
				[m_pMemoCheckBox removeFromSuperview];
				[m_pTableView_IB reloadData];
			}
		}
			break;
		case 1:
		{
			//取消
			isLongPress = NO;
			[m_pMemoCheckBox removeFromSuperview];
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
		
		[app.window addSubview:m_pMemoCheckBox];
		
		[m_pTableView_IB reloadData];
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"备忘录";
	self.navigationItem.rightBarButtonItem = m_pRightAdd;
	
	eventsList = [[NSMutableArray alloc] initWithArray:0];
	
	//NSArray * p = [self.eventStore calendars];
	
	//self.navigationController.delegate = self;
	
	NSDate *NowDate = [NSDate date];
    NSDateFormatter* indateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [indateFormatter setDateFormat:@"yyyy-MM-dd"];
	
	NSString *dateStr = [indateFormatter stringFromDate:NowDate];
	
    NSDate* startDate = [indateFormatter dateFromString:dateStr];
	
	self.m_pDate = startDate;
	
	m_pDateButton = [[DateButton alloc] initWithFrame:CGRectMake(6,6,32,32)];
	[m_pDateButton setButtonDate:self.m_pDate];
	[self.navigationController.navigationBar addSubview:m_pDateButton];
	m_pDateButton.Target   = self;
	m_pDateButton.Selector = @selector(GetDatePressed:);
	
	m_pMemoCheckBox = [[MemoCheckBox alloc] initWithFrame:CGRectMake(0,424,320,56)];
	m_pMemoCheckBox.Target   = self;
	m_pMemoCheckBox.Selector = @selector(GetPressed:);
	
	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPress:)];
	
    [m_pTableView_IB addGestureRecognizer:longPressGesture];
	
    [longPressGesture release];
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
	[m_pTableView_IB release];
	[m_pRightAdd     release];
	[m_pDate         release];
	[m_pDateButton   release];
	[m_pMemoCheckBox release];
	
	[detailViewController release];
	[eventsList			  release];
	
    [super dealloc];
}

-(IBAction)addItemBtn:(id)sender
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	isLongPress = NO;
	[m_pMemoCheckBox removeFromSuperview];
	
	// When add button is pushed, create an EKEventEditViewController to display the event.
	EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
	
	// set the addController's event store to the current event store.
	addController.eventStore = app.eventStore;
	
	// present EventsAddViewController as a modal view controller
	[self presentModalViewController:addController animated:YES];
	
	addController.editViewDelegate = self;
	[addController release];
}

// Fetching events happening in the next 24 hours with a predicate, limiting to the default calendar 
- (void)fetchEventsForToday 
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	[self.eventsList removeAllObjects];
	
	// endDate is 1 day = 60*60*24 seconds = 86400 seconds from startDate
	NSDate *endDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.m_pDate];
	//NSDate *endDate = [NSDate distantFuture];
	
	// Create the predicate. Pass it the default calendar.
	NSArray *calendarArray = [NSArray arrayWithObject:app.defaultCalendar];
	
	NSPredicate *predicate = [app.eventStore predicateForEventsWithStartDate:self.m_pDate endDate:endDate 
																	calendars:calendarArray]; 
	
	// Fetch all events that match the predicate.
	NSArray *events = [app.eventStore eventsMatchingPredicate:predicate];
	
	//NSLog(@"%@",events);
	
	[self.eventsList addObjectsFromArray:events];
	
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

#pragma mark -
#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{ 
	return 1;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
	if(self.m_pDate)
	{
		//通过日期推算星期的代码
		//NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
		//[inputFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
		 
		//NSDate *formatterDate = [inputFormatter dateFromString:@"1999-07-11 at 10:30"];
		 
		NSDateFormatter *outputFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[outputFormatter setDateFormat:@"EEEE                          MMMM d yyyy"];
		
		NSString *newDateString = [outputFormatter stringFromDate:self.m_pDate];
		
		return newDateString;
	}
	else
	{
		return nil;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return eventsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//static NSString *CellIdentifier = @"memoCell";
	
	// Add disclosure triangle to cell
	UITableViewCellAccessoryType editableCellAccessoryType = UITableViewCellAccessoryNone;
	
	MemoCell *cell = (MemoCell*)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"memoCell_%d",indexPath.row]];
	if (cell == nil)
	{
		cell = [[[MemoCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:[NSString stringWithFormat:@"memoCell_%d",indexPath.row]] autorelease];
	}
	
	cell.accessoryType = editableCellAccessoryType;
	
	// Get the event at the row selected and display it's title
	EKEvent * pEvent = (EKEvent*)[self.eventsList objectAtIndex:indexPath.row];
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
	
	if(isLongPress)
	{
		[cell setOffSet:YES];
	}
	else
	{
		[cell setOffSet:NO];
	}
	
	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if(isLongPress)
	{
		if (tableView == self.m_pTableView_IB)
		{
			MemoCell  *cell = (MemoCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
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
	
	[m_pDateButton setHidden:NO];
	
	//[m_pTableView_IB deselectRowAtIndexPath:m_pTableView_IB.indexPathForSelectedRow animated:NO];
	
	// Fetch today's event on selected calendar and put them into the eventsList array
	[self fetchEventsForToday];
	
	[m_pTableView_IB reloadData];
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[m_pDateButton setHidden:YES];
}

#pragma mark -
#pragma mark EKEventEditViewDelegate

// Overriding EKEventEditViewDelegate method to update event store according to user actions.
- (void)eventEditViewController:(EKEventEditViewController *)controller 
		  didCompleteWithAction:(EKEventEditViewAction)action 
{
	NSError *error = nil;
	EKEvent *thisEvent = controller.event;
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
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
			if (app.defaultCalendar ==  thisEvent.calendar) 
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
			if (app.defaultCalendar ==  thisEvent.calendar) 
			{
				[self.eventsList removeObject:thisEvent];
			}
			[controller.eventStore removeEvent:thisEvent span:EKSpanThisEvent error:&error];
			
			//如果是联系人的日历，移除数据库
			[DataStore removeDateEvent:thisEvent.eventIdentifier];
			
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
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	EKCalendar *calendarForEdit = app.defaultCalendar;
	return calendarForEdit;
}

@end