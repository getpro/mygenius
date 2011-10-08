//
//  DateButton.m
//  AddressBook
//
//  Created by Peteo on 11-10-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DateButton.h"
#import "PublicData.h"

@implementation DateButton

@synthesize Target;
@synthesize Selector;
@synthesize date;

-(void)btnPressed:(id)sender
{
	if (Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:sender];
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self setUserInteractionEnabled:YES];
		self.backgroundColor = [UIColor clearColor];
		
		[self setImage:[UIImage imageNamed:@"data.png"]       forState:UIControlStateNormal];
		[self setImage:[UIImage imageNamed:@"data_hover.png"] forState:UIControlStateHighlighted];
		
		[self addTarget:self action:@selector(btnPressed:)forControlEvents:UIControlEventTouchUpInside];
		
		m_pMonth = [[UILabel alloc] initWithFrame:CGRectMake(0,1,32,10)];
		m_pMonth.textAlignment = UITextAlignmentCenter;
		m_pMonth.backgroundColor = [UIColor clearColor];
		m_pMonth.font = [UIFont fontWithName:FONT_NAME size:8];
		m_pMonth.textColor = [UIColor whiteColor];
		[self addSubview:m_pMonth];
		
		m_pDay = [[UILabel alloc] initWithFrame:CGRectMake(0,12,32,16)];
		m_pDay.textAlignment = UITextAlignmentCenter;
		m_pDay.backgroundColor = [UIColor clearColor];
		m_pDay.font = [UIFont fontWithName:FONT_NAME size:14];
		m_pDay.textColor = [UIColor brownColor];
		[self addSubview:m_pDay];
		
	}
	return self;
}

-(void) setButtonDate:(NSDate*)pDate
{
	//self.date = pDate;
	
	NSDateFormatter *formattermonth = [[[NSDateFormatter alloc] init] autorelease];
	NSDateFormatter *formatterday   = [[[NSDateFormatter alloc] init] autorelease];
	
	[formattermonth setDateFormat:@"MM"];
	[formatterday   setDateFormat:@"dd"];
	
	NSString *monthStr = [formattermonth stringFromDate:pDate];
	NSString *dayStr   = [formatterday   stringFromDate:pDate];
	
	//NSLog(@"[%@]",monthStr);
	//NSLog(@"[%@]",dayStr);
	
	int month   = [monthStr   intValue];
	
	m_pDay.text = dayStr;
	
	switch (month)
	{
		case 1:
		{
			m_pMonth.text = @"JAN";
		}
			break;
		case 2:
		{
			m_pMonth.text = @"FEB";
		}
			break;
		case 3:
		{
			m_pMonth.text = @"MAR";
		}
			break;
		case 4:
		{
			m_pMonth.text = @"APR";
		}
			break;
		case 5:
		{
			m_pMonth.text = @"MAY";
		}
			break;
		case 6:
		{
			m_pMonth.text = @"JUN";
		}
			break;
		case 7:
		{
			m_pMonth.text = @"JUL";
		}
			break;
		case 8:
		{
			m_pMonth.text = @"AUG";
		}
			break;
		case 9:
		{
			m_pMonth.text = @"SEP";
		}
			break;
		case 10:
		{
			m_pMonth.text = @"OCT";
		}
			break;
		case 11:
		{
			m_pMonth.text = @"NOV";
		}
			break;
		case 12:
		{
			m_pMonth.text = @"DEC";
		}
			break;
		default:
			break;
	}
}

- (void)dealloc 
{
	[date release];
	
	[m_pMonth release];
	[m_pDay   release];
	
    [super dealloc];
}

@end
