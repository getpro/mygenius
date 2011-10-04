//
//  CheckBox.m
//  AddressBook
//
//  Created by Peteo on 11-10-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox

@synthesize Target;
@synthesize Selector;

-(void)GroupPressed:(id)sender
{
	if (Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:@"0"];
	}
}

-(void)DeletePressed:(id)sender
{
	if (Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:@"1"];
	}
}

-(void)CancelPressed:(id)sender
{
	if (Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:@"2"];
	}
}

- (id)initWithFrame:(CGRect)frame 
{    
    self = [super initWithFrame:frame];
    if (self) 
	{
        // Initialization code.
		[self setUserInteractionEnabled:YES];
		
		self.backgroundColor = [UIColor clearColor];
		
		UIImage * pBgImg = [UIImage imageNamed:@"index_checkBox_bg.png"];
		UIImageView * pBG = [[UIImageView alloc] initWithImage:pBgImg];
		[pBG setFrame:CGRectMake(0, 0, pBgImg.size.width, pBgImg.size.height)];
		[self addSubview:pBG];
		[pBG release];
		
		UIButton * buttonGroup = [[UIButton alloc] initWithFrame:CGRectMake(40, 18, 60, 30)];
		[buttonGroup setBackgroundColor:[UIColor clearColor]];
	    [buttonGroup addTarget:self action:@selector(GroupPressed:)forControlEvents:UIControlEventTouchUpInside];
		[buttonGroup setTitle:@"移动组" forState:UIControlStateNormal];
		[buttonGroup setBackgroundImage:[UIImage imageNamed:@"btn_3hover.png"] forState:UIControlStateNormal];
		
		[self addSubview:buttonGroup];
		[buttonGroup release];
		
		//
		UIButton * buttonDelete = [[UIButton alloc] initWithFrame:CGRectMake(130, 18, 60, 30)];
		[buttonDelete setBackgroundColor:[UIColor clearColor]];
	    [buttonDelete addTarget:self action:@selector(DeletePressed:)forControlEvents:UIControlEventTouchUpInside];
		[buttonDelete setTitle:@"删除" forState:UIControlStateNormal];
		[buttonDelete setBackgroundImage:[UIImage imageNamed:@"btn_3red.png"] forState:UIControlStateNormal];
		
		[self addSubview:buttonDelete];
		[buttonDelete release];
		
		//
		UIButton * buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(220, 18, 60, 30)];
		[buttonCancel setBackgroundColor:[UIColor clearColor]];
	    [buttonCancel addTarget:self action:@selector(CancelPressed:)forControlEvents:UIControlEventTouchUpInside];
		[buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
		[buttonCancel setBackgroundImage:[UIImage imageNamed:@"btn_3black.png"] forState:UIControlStateNormal];
		
		[self addSubview:buttonCancel];
		[buttonCancel release];
		
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc 
{
    [super dealloc];
}


@end
