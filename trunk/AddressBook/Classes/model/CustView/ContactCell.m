//
//  ContactCell.m
//  AddressBook
//
//  Created by Peteo on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactCell.h"
#import "PublicData.h"

NSString *KContactCell_ID = @"ContactCell";

#define HEAD_SIZE 32.0f

@implementation ContactCell

@synthesize m_nOffSet,m_pHead,m_pName,m_IsSelect;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        // Initialization code.
		
		m_nOffSet = 5;
		
		m_pMove = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 5, 10)];
		[m_pMove setImage:[UIImage imageNamed:@"move.png"]];
		[self addSubview:m_pMove];
		
		m_pCheckSelect = [[UIImageView alloc] initWithFrame:CGRectMake(4, 23, 12, 12)];
		[m_pCheckSelect setImage:[UIImage imageNamed:@"checkBox_hover.png"]];
		[self addSubview:m_pCheckSelect];
		
		m_pCheck = [[UIImageView alloc] initWithFrame:CGRectMake(4, 23, 12, 12)];
		[m_pCheck setImage:[UIImage imageNamed:@"checkBox.png"]];
		[self addSubview:m_pCheck];
		
		m_pHead = [[UIImageView alloc] initWithFrame:CGRectMake(m_nOffSet, (42 - HEAD_SIZE)/2, HEAD_SIZE, HEAD_SIZE)];
		m_pHead.contentMode = UIViewContentModeScaleAspectFit;
		[m_pHead setImage:[UIImage imageNamed:@"head.png"]];
		[self addSubview:m_pHead];
		
		m_pName = [[UILabel alloc] initWithFrame:CGRectMake(m_nOffSet + HEAD_SIZE + 5,0,188,42)];
		m_pName.textAlignment = UITextAlignmentLeft;
		m_pName.backgroundColor = [UIColor clearColor];
		m_pName.font = [UIFont fontWithName:FONT_NAME size:20];
		m_pName.textColor = [UIColor blackColor];
		[self addSubview:m_pName];
		
		[m_pCheckSelect setHidden:YES];
		[m_pCheck	    setHidden:YES];
		
		m_IsSelect = NO;
		
		//右箭头
		UIImage * pArrowImg = [UIImage imageNamed:@"arrow.png"];
		UIImageView * pArrowView = [[[UIImageView alloc] initWithImage:pArrowImg] autorelease];
		[pArrowView setFrame:CGRectMake(225, 15, pArrowImg.size.width, pArrowImg.size.height)];
		[self addSubview:pArrowView];
		
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
	[m_pHead release];
	[m_pName release];
	[m_pMove release];
	[m_pCheckSelect release];
	[m_pCheck release];
	
    [super dealloc];
}

- (void) setOffSet:(BOOL)pHasOffSet
{
	//m_IsSelect = NO;
	
	if(pHasOffSet)
	{
		m_nOffSet = 20;
		
		m_pHead.frame = CGRectMake(m_nOffSet, (42 - HEAD_SIZE)/2, HEAD_SIZE, HEAD_SIZE);
		m_pName.frame = CGRectMake(m_nOffSet + HEAD_SIZE + 5,0,188,42);
	
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
		
		m_pHead.frame = CGRectMake(m_nOffSet, (42 - HEAD_SIZE)/2, HEAD_SIZE, HEAD_SIZE);
		m_pName.frame = CGRectMake(m_nOffSet + HEAD_SIZE + 5,0,188,42);
		
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
