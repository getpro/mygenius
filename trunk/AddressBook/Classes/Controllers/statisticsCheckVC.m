//
//  statisticsCheckVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "statisticsCheckVC.h"
#import "RecommendVC.h"
#import "AddressBookAppDelegate.h"
#import "CustomDatePicker.h"

typedef enum
{
    StatisticsCheck_TableView_Section_Contact,
    StatisticsCheck_TableView_Section_Time,
	StatisticsCheck_TableView_Section_Type,
	StatisticsCheck_TableView_Section_Count
}StatisticsCheck_TableView_Section;

@implementation statisticsCheckVC

@synthesize m_pTableView_IB;
@synthesize m_pABContact;
@synthesize m_pStartDate;
@synthesize m_pEndDate;
@synthesize delegate;
@synthesize m_nTypeIndex;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"查询设置";
	
	m_pTypeArr = [NSArray arrayWithObjects:@"全部",@"生日",@"纪念日",@"其他",nil];
	[m_pTypeArr retain];
	
	m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	m_pTableView_IB.scrollEnabled = NO;
	
	m_pTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10,200,32)];
	m_pTextField.delegate = self;
	m_pTextField.adjustsFontSizeToFitWidth = YES;
	m_pTextField.font = [UIFont systemFontOfSize:17];
	m_pTextField.minimumFontSize = 8;
	//m_pTextField.textAlignment = UITextAlignmentCenter;
	
	// Instead of a "Return" button, our keyboard will have a "Done" button.  When it is hit, we 
	// want to put away the keyboard.
	m_pTextField.returnKeyType = UIReturnKeyDone;
	/*
	[textField addTarget:self
				  action:@selector(doneWithKeyboard:)
		forControlEvents:UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
	*/
	m_pTextField.text = m_pABContact.contactName;
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
	[m_pTableView_IB release];
	[m_pABContact    release];
	[m_pStartDate    release];
	[m_pEndDate      release];
	[m_pTextField    release];
	[m_pTypeArr      release];
	
    [super dealloc];
}

#pragma mark TableView methods

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellIdentifier = @"statisticsCheckCell";
	UITableViewCell* cell = (UITableViewCell*)[aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if (cell != nil)
	{
		switch (indexPath.section)
		{
			case StatisticsCheck_TableView_Section_Contact:
			{
				cell.accessoryType = UITableViewCellAccessoryNone;
				cell.textLabel.text = @"联系人";
				[cell.contentView addSubview:m_pTextField];
			}
				break;
			case StatisticsCheck_TableView_Section_Time:
			{
				if(indexPath.row == 0)
				{
					cell.textLabel.text = @"开始";
					
					if(m_pStartDate)
					{
						NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
						
						[formatter setDateFormat:@"yyyy年MM月dd"];
						
						NSString *dateStr = [formatter stringFromDate:m_pStartDate];
						
						if(dateStr)
						{
							cell.detailTextLabel.text = dateStr;
						}
					}
				}
				else if(indexPath.row == 1)
				{
					cell.textLabel.text = @"结束";
					if(m_pEndDate)
					{
						NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
						
						[formatter setDateFormat:@"yyyy年MM月dd"];
						
						NSString *dateStr = [formatter stringFromDate:m_pEndDate];
						
						if(dateStr)
						{
							cell.detailTextLabel.text = dateStr;
						}
					}
				}
			}
				break;
			case StatisticsCheck_TableView_Section_Type:
			{
				cell.textLabel.text = @"事件类型";
				cell.detailTextLabel.text = [m_pTypeArr objectAtIndex:m_nTypeIndex];
			}
				break;
			default:
				break;
		}
	}
	
	return cell;
}

//获取联系人
-(void)getRecommendResult:(id)index
{
	ABContact * pABContact = (ABContact*)index;
	
	if(pABContact)
	{
		NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:StatisticsCheck_TableView_Section_Contact];
		UITableViewCell  *cell = (UITableViewCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
		cell.detailTextLabel.text = pABContact.contactName;
		
		self.m_pABContact = pABContact;
		
		[m_pTableView_IB reloadData];
	}
}

//获取开始时间
-(void)getStartTimeResult:(id)index
{
	NSDate * date = (NSDate*)index;
	
	self.m_pStartDate = date;
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	
	[formatter setDateFormat:@"yyyy年MM月dd"];
	
	NSString *dateStr = [formatter stringFromDate:date];
	
	if(dateStr)
	{
		NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:StatisticsCheck_TableView_Section_Time];
		UITableViewCell  *cell = (UITableViewCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
		
		cell.detailTextLabel.text = dateStr;
	}
	
	[m_pTableView_IB reloadData];
}

//获取结束时间
-(void)getEndTimeResult:(id)index
{
	NSDate * date = (NSDate*)index;
	
	self.m_pEndDate = date;
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	
	[formatter setDateFormat:@"yyyy年MM月dd"];
	
	NSString *dateStr = [formatter stringFromDate:date];
	
	if(dateStr)
	{
		NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:StatisticsCheck_TableView_Section_Time];
		UITableViewCell  *cell = (UITableViewCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
		
		cell.detailTextLabel.text = dateStr;
	}
	
	[m_pTableView_IB reloadData];
}

-(void)getTypeResult:(id)index
{
	NSString * pIndex = (NSString*)index;
	
	m_nTypeIndex = [pIndex intValue];
	
	NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:StatisticsCheck_TableView_Section_Type];
	UITableViewCell  *cell = (UITableViewCell*)[self.m_pTableView_IB cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = [m_pTypeArr objectAtIndex:[pIndex intValue]];
	
	[self.m_pTableView_IB reloadData];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	
	switch (indexPath.section) 
	{
		case StatisticsCheck_TableView_Section_Contact:
		{
			//"联系人"
			//RecommendVC *tvc = [[[RecommendVC alloc] init] autorelease];
			//tvc.Target   = self;
			//tvc.Selector = @selector(getRecommendResult:);
			
			//[self.navigationController pushViewController:tvc animated:YES];
			
		}
			break;
		case StatisticsCheck_TableView_Section_Time:
		{
			if(indexPath.row == 0)
			{
				//"开始"
				CustomDatePicker *tvc = [[[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) DatePickerMode:UIDatePickerModeDate] autorelease];
				if(m_pStartDate)
				{
					tvc.m_pDatePicker.date = m_pStartDate;
				}
				tvc.Target   = self;
				tvc.Selector = @selector(getStartTimeResult:);			
				[app.window addSubview:tvc];
			}
			else if(indexPath.row == 1)
			{
				//"结束"
				CustomDatePicker *tvc = [[[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) DatePickerMode:UIDatePickerModeDate] autorelease];
				if(m_pEndDate)
				{
					tvc.m_pDatePicker.date = m_pEndDate;
				}
				tvc.Target   = self;
				tvc.Selector = @selector(getEndTimeResult:);			
				[app.window addSubview:tvc];
			}
		}
			break;
		case StatisticsCheck_TableView_Section_Type:
		{
			//"事件类型";
			CustomPicker *tvc = [[[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)] autorelease];
			tvc.Target   = self;
			tvc.Selector = @selector(getTypeResult:);
			tvc.sourceArray = m_pTypeArr;
			
			[app.window addSubview:tvc];
		}
			break;
		default:
			break;
	}
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{ 
	return StatisticsCheck_TableView_Section_Count;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger pRetNum = 1;
	
	switch (section) 
	{
		case StatisticsCheck_TableView_Section_Contact:
		{
			pRetNum = 1;
		}
			break;
		case StatisticsCheck_TableView_Section_Time:
		{
			pRetNum = 2;
		}
			break;
		case StatisticsCheck_TableView_Section_Type:
		{
			pRetNum = 1;
		}
			break;
		default:
			break;
	}
	
	return pRetNum;
}

-(IBAction)search:(id)sender
{
	if([m_pStartDate timeIntervalSince1970] > [m_pEndDate timeIntervalSince1970])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开始时间必须小于结束时间"
													   delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[alert show];
		[alert release];
		return;
	}
	
	if(m_pTextField.text == nil || [m_pTextField.text isEqual:@""])
	{
		self.m_pABContact = nil;
	}
	else
	{
		NSArray * pArry = [ABContactsHelper contactsMatchingName:m_pTextField.text];
		
		if([pArry count] == 0)
		{
			//全名称匹配
			AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
			ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:0];
			
			ABContact * pABContact = [AllContactData byNameToGetContact:m_pTextField.text];
			if(pABContact == nil)
			{
				//没有找到联系人
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无该联系人信息"
															   delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
				[alert show];	
				[alert release];
				
				return;
			}
			else
			{
				self.m_pABContact = pABContact;
			}
		}
		else
		{
			self.m_pABContact = (ABContact*)[pArry objectAtIndex:0];
		}
	}
	
	if(delegate)
	{
		[delegate CheckCallBack:m_pStartDate:m_pEndDate:m_pABContact:m_nTypeIndex];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return NO;
}

@end
