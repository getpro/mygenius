//
//  CustomButtonView.m
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomButtonView.h"

@implementation CustomButtonView

@synthesize m_pTitle,m_pLabelContent,m_pButton;

//响应按钮事件
-(void)btnPressed:(id)sender
{
	
}

- (id)initWithFrame:(CGRect)frame
{
	if (self=[super initWithFrame:frame])
	{
		[self setUserInteractionEnabled:YES];
		
		self.backgroundColor = [UIColor clearColor];
		
		//Button
		CGRect pButtonRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
		
		m_pButton = [[UIButton alloc] initWithFrame:pButtonRect];
		
		[m_pButton setBackgroundColor:[UIColor clearColor]];
		
		[m_pButton setImage:[UIImage imageNamed:@"image08_kuang.png"] forState:UIControlStateNormal];  
		
		[m_pButton addTarget:self action:@selector(btnPressed:)
			 forControlEvents:UIControlEventTouchUpInside];
		
		
		[self addSubview:m_pButton];
		
		
		//标签
		CGRect pTitleRect = CGRectMake(12, 12, 96, 30);
		
		m_pTitle  = [[UILabel alloc] initWithFrame:pTitleRect];
		
		m_pTitle.shadowColor     = [UIColor clearColor];
		m_pTitle.backgroundColor = [UIColor clearColor];
		
		[self addSubview:m_pTitle];
		
		//内容
		CGRect pContentRect = CGRectMake(90, 12, 200, 30);
		
		m_pLabelContent = [[UILabel alloc] initWithFrame:pContentRect];
		
		m_pLabelContent.shadowColor		= [UIColor clearColor];
		m_pLabelContent.backgroundColor = [UIColor clearColor];
		
		[self addSubview:m_pLabelContent];
		
	}
	return self;
}

- (void)dealloc
{
	[m_pTitle			 release];
	[m_pLabelContent	 release];
	[m_pButton			 release];
	
	[super dealloc];
}

@end
