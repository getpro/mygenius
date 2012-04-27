//
//  ColorButton.m
//  GuessWhat
//
//  Created by Peteo on 12-4-11.
//  Copyright 2012 The9. All rights reserved.
//

#import "ColorButton.h"
#import "UIImageSet.h"

@implementation ColorButton

@synthesize m_pCB;
@synthesize m_pTarget;

- (id)initWithFrame:(CGRect)frame Color:(UIColor *)theColor
{
    if ((self = [super initWithFrame:frame]))
	{
		[self setBackgroundColor:[UIColor clearColor]];
		
		UIImageView * pImg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"file_drawing_color1.png"]];
		[pImg1 setFrame:CGRectMake(4,0,pImg1.frame.size.width,pImg1.frame.size.height)];
		[self addSubview:pImg1];
		[pImg1 release];
		
		
		UIImage * pColorImg = 
		[ImageSet colorizeImage:[UIImage imageNamed:@"file_drawing_color2.png"] 
					  withColor:theColor];
		
		UIImageView * pColor_bg = [[UIImageView alloc] initWithImage:pColorImg];
		[pColor_bg setFrame:CGRectMake(4,0,pColor_bg.frame.size.width,pColor_bg.frame.size.height)];
		[self addSubview:pColor_bg];
		
		[self setFrame:CGRectMake(0, 0, pColor_bg.frame.size.width + 8, 
								        pColor_bg.frame.size.height)];
		
		[pColor_bg release];
		
		//[self setBackgroundImage:BackgroundImage forState:UIControlStateNormal];
		//[self setBackgroundImage:BackgroundImage forState:UIControlStateSelected];
		
		[self addTarget:self action:@selector(btnPressed:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		UIImageView * pImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"file_drawing_colorLight2.png"]];
		[pImg setFrame:CGRectMake(4,0,pImg.frame.size.width,pImg.frame.size.height)];
		[self addSubview:pImg];
		[pImg release];
    }
    return self;
}

- (void)dealloc
{
	
    [super dealloc];
}

//响应按钮事件
-(void)btnPressed:(id)sender
{
	//NSLog(@"Color_Pressed");
	
	ColorButton *Btn   = (ColorButton *)sender;
	NSInteger index = Btn.tag;
	
	//Btn.transform = CGAffineTransformMakeScale(1.3f,1.3f);
	
	if(m_pCB && m_pTarget && [m_pTarget respondsToSelector:m_pCB])
	{
		[m_pTarget performSelector:m_pCB withObject:[NSNumber numberWithInt:index]];
	}
}

@end
