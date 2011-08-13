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

- (id)initWithFrame:(CGRect)frame IsEdit:(BOOL)pIsEdit
{
	if (self=[super initWithFrame:frame])
	{
		[self setUserInteractionEnabled:YES];
		
		self.backgroundColor = [UIColor clearColor];
		
		b_IsEdit = pIsEdit;
		
		//边框
		m_pBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image08_kuang.png"]];
		
		[self addSubview:m_pBorder];
		
		//标签
		CGRect pTitleRect = CGRectMake(12, 12, 96, 30);
		
		m_pTitle  = [[UILabel alloc] initWithFrame:pTitleRect];
		
		[self addSubview:m_pTitle];
		
		CGRect pContentRect = CGRectMake(90, 12, 200, 30);
		
		if(b_IsEdit)
		{
			//可编辑
			m_pTextFieldContent = [[UITextField alloc] initWithFrame:pContentRect];
			m_pTextFieldContent.delegate = self;
			m_pTextFieldContent.borderStyle = UITextBorderStyleNone;
			//m_pTextFieldContent.textColor = [UIColor whiteColor];
			m_pTextFieldContent.textAlignment = UITextAlignmentCenter;
			m_pTextFieldContent.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
			m_pTextFieldContent.keyboardType = UIKeyboardTypeDefault;
			m_pTextFieldContent.returnKeyType = UIReturnKeyDone;
			m_pTextFieldContent.clearButtonMode = UITextFieldViewModeWhileEditing;
			
			
			[self addSubview:m_pTextFieldContent];
		}
		else
		{
			//不可编辑
			m_pLabelContent = [[UILabel alloc] initWithFrame:pContentRect];
			
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	
	return YES;
}

@end
