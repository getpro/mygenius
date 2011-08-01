//
//  test1.h
//  notifiy_test
//
//  Created by unidigital UNIDIGITAL on 11-7-21.
//  Copyright 2011 unidigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface test1 : UIViewController 
{
	EKEventStore * eventStore;
	EKCalendar   * defaultCalendar;
}

@property (nonatomic, retain) EKEventStore * eventStore;
@property (nonatomic, retain) EKCalendar   * defaultCalendar;

- (IBAction) test;

@end
