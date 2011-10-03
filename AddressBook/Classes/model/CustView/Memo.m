//
//  Memo.m
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Memo.h"
#import "PublicData.h"

@implementation Memo

@synthesize m_pReturn;
@synthesize m_pDone;
@synthesize Target;
@synthesize Selector;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"日期设定";
	
	sourceArray = [NSArray arrayWithObjects:@"无",@"5分钟前",@"15分钟前",@"30分钟前",
											@"1小时前",@"2小时前",@"1天前",@"2天前",
				   @"事件发生日",nil];
	
	[sourceArray retain];
	
	CGRect pickerFrame = CGRectMake(0, 0, SCREEN_W, 120);
	picker=[ [UIPickerView alloc] initWithFrame:pickerFrame];
	//picker.autoresizingMask=UIViewAutoresizingFlexibleWidth;
	picker.showsSelectionIndicator = YES;
	picker.delegate   = self; 
	picker.dataSource = self;
	[self.view addSubview:picker];
	
	datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectZero];
	//datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
	datePickerView.frame = CGRectMake(0, 152, SCREEN_W, 250);
	
	[self.view addSubview:datePickerView];
	
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pReturn   release];
	[m_pDone     release];
	[picker		 release];
    [sourceArray release];
	[datePickerView release];
	
    [super dealloc];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	return [sourceArray objectAtIndex:row];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [sourceArray count];
}

@end
