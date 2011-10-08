//
//  MemoCell.m
//  AddressBook
//
//  Created by Peteo on 11-10-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MemoCell.h"
#import "PublicData.h"

NSString *KMemoCell_ID = @"MemoCell";

@implementation MemoCell

@synthesize m_nOffSet,m_IsSelect,m_pTitle,m_pLocate,m_pTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
        // Initialization code.
		m_nOffSet = 5;
		
		m_pCheckSelect = [[UIImageView alloc] initWithFrame:CGRectMake(4, 23, 12, 12)];
		[m_pCheckSelect setImage:[UIImage imageNamed:@"checkBox_hover.png"]];
		[self addSubview:m_pCheckSelect];
		
		m_pCheck = [[UIImageView alloc] initWithFrame:CGRectMake(4, 23, 12, 12)];
		[m_pCheck setImage:[UIImage imageNamed:@"checkBox.png"]];
		[self addSubview:m_pCheck];
		
		//全天类型
		m_pTime = [[UILabel alloc] initWithFrame:CGRectMake(m_nOffSet,16,60,12)];
		m_pTime.textAlignment = UITextAlignmentLeft;
		m_pTime.backgroundColor = [UIColor clearColor];
		m_pTime.font = [UIFont fontWithName:FONT_NAME size:10];
		m_pTime.textColor = [UIColor blackColor];
		[self addSubview:m_pTime];
		
		//标题
		m_pTitle = [[UILabel alloc] initWithFrame:CGRectMake(m_nOffSet + 65,4,180,20)];
		m_pTitle.textAlignment = UITextAlignmentLeft;
		m_pTitle.backgroundColor = [UIColor clearColor];
		m_pTitle.font = [UIFont fontWithName:FONT_NAME size:20];
		m_pTitle.textColor = [UIColor blackColor];
		[self addSubview:m_pTitle];
		
		//位置
		m_pLocate = [[UILabel alloc] initWithFrame:CGRectMake(m_nOffSet + 65,24,180,20)];
		m_pLocate.textAlignment = UITextAlignmentLeft;
		m_pLocate.backgroundColor = [UIColor clearColor];
		m_pLocate.font = [UIFont fontWithName:FONT_NAME size:16];
		m_pLocate.textColor = [UIColor grayColor];
		[self addSubview:m_pLocate];
		
		[m_pCheckSelect setHidden:YES];
		[m_pCheck	    setHidden:YES];
		
		m_IsSelect = NO;
		
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state.
}


- (void)dealloc 
{
	[m_pCheckSelect release];
	[m_pCheck		release];
	[m_pLocate      release];
	[m_pTitle       release];
	[m_pTime        release];
	
    [super dealloc];
}

- (void) setOffSet:(BOOL)pHasOffSet
{
	if(pHasOffSet)
	{
		m_nOffSet = 20;
		
		if(m_IsSelect)
		{
			[m_pCheckSelect setHidden:NO];
			[m_pCheck	    setHidden:YES];
		}
		else
		{
			[m_pCheckSelect setHidden:YES];
			[m_pCheck	    setHidden:NO];
		}
	}
	else
	{
		m_nOffSet = 5;
		
		[m_pCheckSelect setHidden:YES];
		[m_pCheck	    setHidden:YES];
		
		m_IsSelect = NO;
	}
}

- (void) setSelect:(BOOL)pSelect
{
	m_IsSelect = pSelect;
	
	if(m_IsSelect)
	{
		[m_pCheckSelect setHidden:NO];
		[m_pCheck	    setHidden:YES];
	}
	else
	{
		[m_pCheckSelect setHidden:YES];
		[m_pCheck	    setHidden:NO];
	}
}

@end
