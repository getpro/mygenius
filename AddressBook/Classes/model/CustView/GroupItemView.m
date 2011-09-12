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

@synthesize delegate = _delegate;
@synthesize count = _count;

-(void)btnPressed:(id)sender
{
	//UIButton * pBut = (UIButton*)sender;
	NSLog(@"btnPressed[%d]",self.tag);
	if(_delegate)
	{
		[_delegate GroupItemViewSelect:self.tag];
	}
}

- (id)initWithFrame:(CGRect)frame :(NSString*) pStr :(NSInteger)pCount
{
    self = [super initWithFrame:frame];
    if (self)
	{
        // Initialization code.
		[self setUserInteractionEnabled:YES];
		
		_count = pCount;
		
		self.backgroundColor = [UIColor clearColor];
		
		//UIImage  * pBgImg = [UIImage imageNamed:@"leftBar_bg.png"];
		UIButton * pBg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		//[pBg setBackgroundImage:pBgImg forState:UIControlStateNormal];
		//[pBg setBackgroundImage:pBgImg forState:UIControlStateHighlighted];
		
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
		
		//计算字符宽度
		CGRect pNumframe = CGRectMake(0.0,0.0,100, 1000.0);
		CGSize calcSize = [[NSString stringWithFormat:@"%d",_count] sizeWithFont:[UIFont fontWithName:FONT_NAME size:10]
						   constrainedToSize:pNumframe.size
							   lineBreakMode:UILineBreakModeWordWrap];
		
		_LabelNum = [[UILabel alloc] initWithFrame:CGRectMake(16, 1, calcSize.width, pNumImg.size.height)];
		_LabelNum.textAlignment = UITextAlignmentCenter;
		_LabelNum.backgroundColor = [UIColor clearColor];
		_LabelNum.font = [UIFont fontWithName:FONT_NAME size:10];
		_LabelNum.textColor = [UIColor whiteColor];
		_LabelNum.text = [NSString stringWithFormat:@"%d",_count];
		[_LabelNum setFrame:CGRectMake(frame.size.width -  (calcSize.width + 8), 1, calcSize.width, pNumImg.size.height)];
		[_LabelNum setHidden:YES];
		
		
		_NumBg = [[UIImageView alloc] initWithImage:pNumImg];
		[_NumBg setFrame:CGRectMake(frame.size.width -  (calcSize.width + 8) - 4, 1, calcSize.width + 8, pNumImg.size.height)];
		[_NumBg setHidden:YES];
		
		[self addSubview:_NumBg];
		
		[self addSubview:_LabelNum];
		
		
		
    }
    return self;
}

- (void)SetHidden:(BOOL)pHidden
{
	[_SelectBg setHidden:pHidden];
	[_NumBg    setHidden:pHidden];
	[_LabelNum setHidden:pHidden];
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
