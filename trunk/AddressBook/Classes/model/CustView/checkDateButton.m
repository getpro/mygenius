//
//  checkDateButton.m
//  AddressBook
//
//  Created by Peteo on 11-10-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "checkDateButton.h"
#import "PublicData.h"

@implementation checkDateButton

@synthesize Target;
@synthesize Selector;

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
		
		[self setImage:[UIImage imageNamed:@"data2.png"]       forState:UIControlStateNormal];
		[self setImage:[UIImage imageNamed:@"data2_hover.png"] forState:UIControlStateHighlighted];
		
		[self addTarget:self action:@selector(btnPressed:)forControlEvents:UIControlEventTouchUpInside];
		
		m_pMonth = [[UILabel alloc] initWithFrame:CGRectMake(0,0,52,10)];
		m_pMonth.textAlignment = UITextAlignmentCenter;
		m_pMonth.backgroundColor = [UIColor clearColor];
		m_pMonth.font = [UIFont fontWithName:FONT_NAME size:8];
		m_pMonth.textColor = [UIColor whiteColor];
		//m_pMonth.text = [NSString stringWithFormat:@"%@  %@",@"Oct",@"Nov"];
		[self addSubview:m_pMonth];
		
		m_pStartDay = [[UILabel alloc] initWithFrame:CGRectMake(0,11,20,16)];
		m_pStartDay.textAlignment = UITextAlignmentCenter;
		m_pStartDay.backgroundColor = [UIColor clearColor];
		m_pStartDay.font = [UIFont fontWithName:FONT_NAME size:14];
		m_pStartDay.textColor = [UIColor brownColor];
		//m_pStartDay.text = @"25";
		[self addSubview:m_pStartDay];
		
		m_pEndDay = [[UILabel alloc] initWithFrame:CGRectMake(30,11,20,16)];
		m_pEndDay.textAlignment = UITextAlignmentCenter;
		m_pEndDay.backgroundColor = [UIColor clearColor];
		m_pEndDay.font = [UIFont fontWithName:FONT_NAME size:14];
		m_pEndDay.textColor = [UIColor brownColor];
		//m_pEndDay.text = @"3";
		[self addSubview:m_pEndDay];
		
	}
	return self;
}

-(void) setButtonDate:(NSDate*)pStartDate :(NSDate*)pEndDate
{
	NSDateFormatter *formattermonth = [[[NSDateFormatter alloc] init] autorelease];
	NSDateFormatter *formatterday   = [[[NSDateFormatter alloc] init] autorelease];
	
	[formattermonth setDateFormat:@"MM"];
	[formatterday   setDateFormat:@"dd"];
	
	NSString *monthStartStr = [formattermonth stringFromDate:pStartDate];
	NSString *dayStartStr   = [formatterday   stringFromDate:pStartDate];
	
	NSString *monthEndStr = [formattermonth stringFromDate:pEndDate];
	NSString *dayEndStr   = [formatterday   stringFromDate:pEndDate];
	
	NSLog(@"[%@]",monthStartStr);
	NSLog(@"[%@]",dayStartStr);
	NSLog(@"[%@]",monthEndStr);
	NSLog(@"[%@]",dayEndStr);
	
	if([monthStartStr isEqual:monthEndStr])
	{
		m_pMonth.text = [NSString stringWithFormat:@"%@",[self getMonthStr:[monthStartStr intValue]]];
	}
	else
	{
		m_pMonth.text = [NSString stringWithFormat:@"%@  %@",[self getMonthStr:[monthStartStr intValue]],[self getMonthStr:[monthEndStr intValue]]];
	}

	m_pStartDay.text = dayStartStr;
	m_pEndDay.text   = dayEndStr;
	
}

-(NSString*) getMonthStr:(int)pIndex
{
	NSString * pRet = nil;
	
	switch (pIndex)
	{
		case 1:
		{
			pRet = @"JAN";
		}
			break;
		case 2:
		{
			pRet = @"FEB";
		}
			break;
		case 3:
		{
			pRet = @"MAR";
		}
			break;
		case 4:
		{
			pRet = @"APR";
		}
			break;
		case 5:
		{
			pRet = @"MAY";
		}
			break;
		case 6:
		{
			pRet = @"JUN";
		}
			break;
		case 7:
		{
			pRet = @"JUL";
		}
			break;
		case 8:
		{
			pRet = @"AUG";
		}
			break;
		case 9:
		{
			pRet = @"SEP";
		}
			break;
		case 10:
		{
			pRet = @"OCT";
		}
			break;
		case 11:
		{
			pRet = @"NOV";
		}
			break;
		case 12:
		{
			pRet = @"DEC";
		}
			break;
		default:
			break;
	}
	
	return pRet;
}

- (void)dealloc 
{
	[m_pMonth	   release];
	[m_pStartDay   release];
	[m_pEndDay     release];
	
    [super dealloc];
}

@end
