    //
//  test1.m
//  notifiy_test
//
//  Created by unidigital UNIDIGITAL on 11-7-21.
//  Copyright 2011 unidigital. All rights reserved.
//

#import "test1.h"


@implementation test1


@synthesize eventStore, defaultCalendar;



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.eventStore = [[EKEventStore alloc] init];
	
	// Get the default calendar from store.
	self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];

	
	
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
	[eventStore      release];
	[defaultCalendar release];
	
    [super dealloc];
}

- (IBAction) test
{
	UILocalNotification *notification=[[UILocalNotification alloc] init];
	
	NSDate *now1 = [NSDate date];
	
	notification.timeZone=[NSTimeZone defaultTimeZone];
	
	notification.repeatInterval = NSDayCalendarUnit;
	
	notification.applicationIconBadgeNumber = 2;
	
	notification.alertAction = @"查看";
	
	NSString *myDateString = @"2011-07-21 14:45:43";
	//拿到原先的日期格式
	NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
	[inputFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //2010-12-08 06:53:43
	
	//将NSString转换为NSDate
	NSDate *theDate  = [inputFormat dateFromString:myDateString];
	
	//notification.fireDate = theDate;
	
	notification.fireDate=[now1 dateByAddingTimeInterval:30];
	
	notification.alertBody = @"生日快乐";
	
	[notification setSoundName:@"sound.caf"];
	
	//notification.soundName = [[NSBundle mainBundle] pathForResource:@"6" ofType:@"wav"];
	
	//notification.soundName = [[NSBundle mainBundle] pathForResource:@"Iphone_Alarm" ofType:@"mp3"];
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSString stringWithFormat:@"%d",0], @"key1", nil];
	
	[notification setUserInfo:dict];
	
	[[UIApplication sharedApplication] scheduleLocalNotification:notification];
	
	
	
	
	//event
	
	NSError * error     = nil;
	
	EKEvent * thisEvent = [EKEvent eventWithEventStore:self.eventStore];
	
	thisEvent.calendar  = self.defaultCalendar;
	
	thisEvent.title     = @"111111111";
	
	thisEvent.startDate = [NSDate date];
	
	thisEvent.endDate   = [NSDate date];
	
	BOOL pResult = [self.eventStore saveEvent:thisEvent span:EKSpanThisEvent error:&error];
	
	pResult = pResult;
}
	

@end
