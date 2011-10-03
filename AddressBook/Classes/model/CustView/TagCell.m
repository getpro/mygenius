//
//  TagCell.m
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell

@synthesize bIsLabel_Click;
@synthesize Target;
@synthesize Selector;

//响应标签按钮事件
-(void)btnPressed:(id)sender
{
	NSLog(@"btnPressed");
	if(bIsLabel_Click)
	{
		if (Target && Selector && [Target respondsToSelector:Selector]) 
		{
			[Target performSelector:Selector];
		}
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		//在textLabel上面添加一层Button,相应切换标签事件
		bIsLabel_Click = NO;
		
		button = [[UIButton alloc] initWithFrame:CGRectZero];
		[button setBackgroundColor:[UIColor clearColor]];
	    [button addTarget:self action:@selector(btnPressed:)
		 forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:button];
    }
    return self;
}

- (void)dealloc
{
	[button    release];
	
    [super dealloc];
}

/**
 *	The technique here is to let the superclass do all the math for us.  Then we just hide the detailTextLabel,
 *	and steal its frame, font size, color, etc. for our textField object.
 */
- (void)layoutSubviews 
{
	[super layoutSubviews];
	
	if (self.editing)
	{
		bIsLabel_Click    = YES;
		button.frame = CGRectMake(40, 0, 80, 40);
	}
	else
	{
		bIsLabel_Click    = NO;
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state.
}

/**
 *	Why not do these things in doneWithKeyboard?  Because a user can stop editing in a couple of ways
 *	besides touching the "Done" key, like touching a different cell.  So, when a cell goes out of 
 *	editing mode we record the text changes.
 *
 *	By doing this before the state change instead of after, we avoid a slight flicker in the label text.
 */
- (void)willTransitionToState:(UITableViewCellStateMask)state 
{
	[super willTransitionToState:state];
	
	if (state ==  UITableViewCellSeparatorStyleNone) 
	{
		//NSObject *obj = dataTarget;
		// self.textLabel.text = textField.text;	// update the label to the value of our edited text
		//[obj setValue:textField.text forKey:dataKey];	// update the model
		//[self.textField resignFirstResponder];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{
	NSString *newText = [change valueForKey:NSKeyValueChangeNewKey];
	
	if ([newText isKindOfClass:[NSString class]]) 
	{
		if([keyPath isEqual:@"label"])
		{
			self.textLabel.text = newText;
		}
		else if([keyPath isEqual:@"stringValue"])
		{
			self.detailTextLabel.text = newText;
		}
		[self setNeedsLayout];
	}
}

@end
