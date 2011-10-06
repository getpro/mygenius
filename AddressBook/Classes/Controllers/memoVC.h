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

#import "DateButton.h"

@interface memoVC : UIViewController 
<
UITableViewDelegate, 
UITableViewDataSource,
EKEventEditViewDelegate
>
{
	IBOutlet UITableView      * m_pTableView_IB;
	IBOutlet UIBarButtonItem  * m_pRightAdd;
	
	EKEventViewController *detailViewController;
	EKEventStore *eventStore;
	EKCalendar *defaultCalendar;
	NSMutableArray *eventsList;
	
	NSDate     *m_pDate;
	DateButton *m_pDateButton;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem  * m_pRightAdd;

@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *defaultCalendar;
@property (nonatomic, retain) NSMutableArray *eventsList;
@property (nonatomic, retain) EKEventViewController *detailViewController;
@property (nonatomic, retain) NSDate *m_pDate;

-(void) fetchEventsForToday;

-(IBAction)addItemBtn:(id)sender;

@end
