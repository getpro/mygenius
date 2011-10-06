//
//  Memo.m
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Memo.h"
#import "PublicData.h"
#import "CustomPicker.h"
#import "CustomDatePicker.h"
#import "AddressBookAppDelegate.h"

typedef enum 
{
    Memo_TableView_Section_Time,
    Memo_TableView_Section_Remind,
	Memo_TableView_Section_Count
}Memo_TableView_Section;

@implementation Memo

@synthesize m_pReturn;
@synthesize m_pDone;
@synthesize Target;
@synthesize Selector;
@synthesize m_pTableView_IB;
@synthesize m_pRemind;
@synthesize m_pTime;
@synthesize m_pDate;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = m_pDone;
	self.navigationItem.leftBarButtonItem  = m_pReturn;
	
	m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	m_pTableView_IB.scrollEnabled = NO;
	
	self.navigationItem.title = @"日期设定";
	
	sourceArray = [NSArray arrayWithObjects:@"无",@"5分钟前",@"15分钟前",@"30分钟前",
											@"1小时前",@"2小时前",@"1天前",@"2天前",
				   @"事件发生日",nil];
	
	[sourceArray retain];
	
	m_nRemindIndex = 0;
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
    [sourceArray release];
	[m_pTableView_IB release];
	[m_pRemind		 release];
	[m_pTime		 release];
	[m_pDate         release];
	
    [super dealloc];
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

#pragma mark - UITableView delegates

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return Memo_TableView_Section_Count;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 1;
	
	return pRetNum;
}

// to determine specific row height for each cell, override this.  In this example, each row is determined
// buy the its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat result = 40.0f;
	return  result;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	//UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	static NSString* cellIdentifier = @"MemoCell";
	UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[UITableViewCell class]])
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if (cell)
	{
		switch (indexPath.section)
		{
			case Memo_TableView_Section_Time:
			{
				if(row == 0)
				{
					cell.textLabel.text = @"日期";
					if(m_pTime)
					{
						cell.detailTextLabel.text = m_pTime;
					}
				}
				break;
			}
			case Memo_TableView_Section_Remind:
			{
				if(row == 0)
				{
					cell.textLabel.text = @"提醒";
					if(m_pRemind)
					{
						cell.detailTextLabel.text = m_pRemind;
					}
				}
				break;
			}
			default:
				break;
		}
	}
	
	return cell;
}

-(void)getRemindResult:(id)index
{
	NSString * pIndex = (NSString*)index;
	NSString * pStr = [sourceArray objectAtIndex:[pIndex intValue]];
	
	m_nRemindIndex = [pIndex intValue];
	
	if(pStr)
	{
		self.m_pRemind = pStr;
	}
	
	[m_pTableView_IB reloadData];
}

-(void)getTimeResult:(id)index
{
	NSDate * date = (NSDate*)index;
	
	self.m_pDate = date;
	
	//NSLog(@"%@",date);
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	
	[formatter setDateFormat:@"yyyy年MM月dd hh:mm"];
	
	NSString *dateStr = [formatter stringFromDate:date];
	
	//nowDate1 = [formatter dateFromString: dateStr];
	
	//NSLog(@"%@",nowDate1);
	
	if(dateStr)
	{
		self.m_pTime = dateStr;
	}
	
	[m_pTableView_IB reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	switch (indexPath.section)
	{
		case Memo_TableView_Section_Time:
		{
			//时间
			{
				CustomDatePicker *tvc = [[[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) DatePickerMode:UIDatePickerModeDateAndTime] autorelease];
				tvc.Target   = self;
				tvc.Selector = @selector(getTimeResult:);			
				[app.window addSubview:tvc];
			}
			break;
		}
		case Memo_TableView_Section_Remind:
		{
			{
				//提醒
				CustomPicker *tvc = [[[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)] autorelease];
				tvc.sourceArray = sourceArray;
				tvc.Target   = self;
				tvc.Selector = @selector(getRemindResult:);			
				[app.window addSubview:tvc];
			}
			break;
		}
		default:
			break;
	}	
}

-(IBAction)ReturnItemBtn:  (id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)DoneItemBtn:    (id)sender
{
	if(m_pTime)
	{
		NSMutableString * pStr = [[[NSMutableString alloc] initWithCapacity:20] autorelease];
		
		[pStr appendString:m_pTime];
		
		if(m_pRemind)
		{
			[pStr appendString:@"  "];
			[pStr appendString:m_pRemind];
		}
		
		[Target setValue:pStr forKey:@"stringValue"];// update the model
		
		if (Target && Selector && [Target respondsToSelector:Selector])
		{
			[Target performSelector:Selector withObject:m_pDate withObject:[NSString stringWithFormat:@"%d",m_nRemindIndex]];
		}
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
