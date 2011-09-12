//
//  GroupItemView.m
//  AddressBook
//
//  Created by Peteo on 11-9-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupItemView.h"
#import "PublicData.h"

@implementation GroupItemView

-(void)btnPressed:(id)sender
{
	NSLog(@"btnPressed");
	[_SelectBg setHidden:NO];
}

- (id)initWithFrame:(CGRect)frame :(NSString*) pStr
{
    self = [super initWithFrame:frame];
    if (self)
	{
        // Initialization code.
		[self setUserInteractionEnabled:YES];
		
		self.backgroundColor = [UIColor clearColor];
		
		UIImage  * pBgImg = [UIImage imageNamed:@"leftBar_bg.png"];
		UIButton * pBg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[pBg setBackgroundImage:pBgImg forState:UIControlStateNormal];
		[pBg setBackgroundImage:pBgImg forState:UIControlStateHighlighted];
		
		[pBg setBackgroundColor:[UIColor clearColor]];
	    [pBg addTarget:self action:@selector(btnPressed:)forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:pBg];
		
		UIImage * pSelectImg = [UIImage imageNamed:@"leftBar_group_bg.png"];
		_SelectBg = [[UIImageView alloc] initWithImage:pSelectImg];
		[_SelectBg setFrame:CGRectMake(1, 1, pSelectImg.size.width, pSelectImg.size.height)];
		[_SelectBg setHidden:YES];
		[self addSubview:_SelectBg];
		
		UILabel * pLabel  = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
		pLabel.textAlignment = UITextAlignmentCenter;
		pLabel.backgroundColor = [UIColor clearColor];
		pLabel.font = [UIFont fontWithName:FONT_NAME size:12];
		pLabel.textColor = [UIColor whiteColor];
		pLabel.text = pStr;
		[self addSubview:pLabel];
		
		UIImage * pNumImg = [UIImage imageNamed:@"leftBar_group_number.png"];
		_NumBg = [[UIImageView alloc] initWithImage:pNumImg];
		[_NumBg setFrame:CGRectMake(16, 1, pNumImg.size.width, pNumImg.size.height)];
		[_NumBg setHidden:NO];
		[self addSubview:_NumBg];
		
		_LabelNum = [[UILabel alloc] initWithFrame:CGRectMake(16, 1, pNumImg.size.width, pNumImg.size.height)];
		_LabelNum.textAlignment = UITextAlignmentCenter;
		_LabelNum.backgroundColor = [UIColor clearColor];
		_LabelNum.font = [UIFont fontWithName:FONT_NAME size:10];
		_LabelNum.textColor = [UIColor whiteColor];
		_LabelNum.text = @"22";
		[_LabelNum setHidden:NO];
		[self addSubview:_LabelNum];
		
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
	[_SelectBg release];
	[_NumBg	   release];
	[_LabelNum release];
	
    [super dealloc];
}


@end
