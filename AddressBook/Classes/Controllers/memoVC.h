//
//  memoVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  备忘录

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface memoVC : UIViewController 
<  
UIActionSheetDelegate,
UISearchBarDelegate,
UITableViewDelegate, 
UITableViewDataSource,
EKEventEditViewDelegate
>
{
	UISearchDisplayController * m_pSearchDC;
	UISearchBar				  * m_pSearchBar;
	
	IBOutlet UITableView      * m_pTableView_IB;
	IBOutlet UIBarButtonItem  * m_pRightAdd;
	
	EKEventViewController *detailViewController;
	EKEventStore *eventStore;
	EKCalendar *defaultCalendar;
	NSMutableArray *eventsList;
	
}

@property (retain,nonatomic) UISearchDisplayController * m_pSearchDC;
@property (retain,nonatomic) UISearchBar			   * m_pSearchBar;
@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem  * m_pRightAdd;

@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *defaultCalendar;
@property (nonatomic, retain) NSMutableArray *eventsList;
@property (nonatomic, retain) EKEventViewController *detailViewController;

- (NSArray *) fetchEventsForToday;

-(IBAction)addItemBtn:(id)sender;

@end
