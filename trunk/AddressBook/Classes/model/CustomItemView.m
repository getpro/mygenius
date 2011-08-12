//
//  CustomItemView.m
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomItemView.h"


@implementation CustomItemView

@synthesize m_pBorder,m_pTitle,m_pLabelContent,m_pTextFieldContent,b_IsEdit;

- (id)initWithFrame:(CGRect)frame
{
	if (self=[super initWithFrame:frame])
	{
		[self setUserInteractionEnabled:YES];
		
		self.backgroundColor = [UIColor clearColor];
		
		//边框
		m_pBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image08_kuang.png"]];
		
		[self addSubview:m_pBorder];
		
		//标签
		m_pTitle  = [[UILabel alloc] initWithFrame:frame];
		
		[self addSubview:m_pTitle];
		
		if(b_IsEdit)
		{
			//可编辑
			m_pTextFieldContent = [[UITextField alloc] initWithFrame:frame];
			
			[self addSubview:m_pTextFieldContent];
		}
		else
		{
			//不可编辑
			m_pLabelContent = [[UILabel alloc] initWithFrame:frame];
			
			[self addSubview:m_pLabelContent];
		}
		
		
		
	}
	
	return self;
}

- (void)dealloc
{
	[m_pBorder			 release];
	[m_pTitle			 release];
	[m_pLabelContent	 release];
	[m_pTextFieldContent release];
	
	[super dealloc];
}

@end
