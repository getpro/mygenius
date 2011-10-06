//
//  DateButton.m
//  AddressBook
//
//  Created by Peteo on 11-10-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DateButton.h"

@implementation DateButton

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
		
		[self setImage:[UIImage imageNamed:@"data.png"]       forState:UIControlStateNormal];
		[self setImage:[UIImage imageNamed:@"data_hover.png"] forState:UIControlStateHighlighted];
		
		[self addTarget:self action:@selector(btnPressed:)forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (void)dealloc 
{	
    [super dealloc];
}

@end
