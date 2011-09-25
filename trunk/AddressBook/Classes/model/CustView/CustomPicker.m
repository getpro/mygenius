//
//  CustomPicker.m
//  AddressBook
//
//  Created by Peteo on 11-9-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomPicker.h"
#import "PublicData.h"

@implementation CustomPicker

@synthesize pickerSheet;
@synthesize picker;
@synthesize sourceArray;
@synthesize Target;
@synthesize Selector;

- (id)initWithFrame:(CGRect)frame
{    
    self = [super initWithFrame:frame];
    if (self)
	{
        // Initialization code.
		//黑色背景阴影
		UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
		
		[view setBackgroundColor:[UIColor blackColor]];
		//[view setTag:LOAD_BACKGROUND];
		[view setAlpha:0.6f];
		[self addSubview:view];
		
		//sourceArray = [[NSArray alloc]initWithObjects: @"iOS应用软件开发", @"iOS企业OA开发",@"iOS定制应用", @"iOS游戏开发", nil];
		
		CGRect pFrame = CGRectMake(0, 200, SCREEN_W, SCREEN_H - 200);
		pickerSheet = [[UIActionSheet alloc] initWithFrame:pFrame];
		pickerSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
		
		
		CGRect btnFrame = CGRectMake(10, 5, 60, 30);
		UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[cancelButton awakeFromNib];
		[cancelButton addTarget:self action:@selector(pickerHideCancel) forControlEvents:UIControlEventTouchUpInside];
		[cancelButton setFrame:btnFrame];
		cancelButton.backgroundColor = [UIColor clearColor];
		[cancelButton setTitle:@"取消" forState:UIControlStateNormal];
		[pickerSheet addSubview:cancelButton];
		
		CGRect btnOKFrame = CGRectMake(250, 5, 60, 30);
		UIButton* okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[okButton awakeFromNib];
		[okButton addTarget:self action:@selector(pickerHideOK) forControlEvents:UIControlEventTouchUpInside];
		[okButton setFrame:btnOKFrame];
		okButton.backgroundColor = [UIColor clearColor];
		[okButton setTitle:@"完成" forState:UIControlStateNormal];
		[pickerSheet addSubview:okButton];
		
		
		CGRect pickerFrame = CGRectMake(0, 40, SCREEN_W, 222);
		picker=[ [UIPickerView alloc] initWithFrame:pickerFrame]; 
		picker.autoresizingMask=UIViewAutoresizingFlexibleWidth;
		picker.showsSelectionIndicator = YES;
		picker.delegate   = self; 
		picker.dataSource = self;
		[pickerSheet addSubview:picker];
		
		[self addSubview:pickerSheet];
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

-(void)pickerShow
{
	/*
	if(!isPickerShow)
	{
		CGRect pickFrame = pickerSheet.frame;	
		[UIView beginAnimations:nil context:self];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.4f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerSheet superview] cache:YES];	
		pickFrame.origin.y -= pickFrame.size.height - 40;//应该根据应用动态计算需要的位置
		[pickerSheet setFrame:pickFrame];	
		[UIView commitAnimations];	
		isPickerShow = TRUE;
	}
	*/
}


-(void)pickerHideOK
{
	if (Target && Selector && [Target respondsToSelector:Selector]) 
	{
		[Target performSelector:Selector withObject:[NSString stringWithFormat:@"%d",[picker selectedRowInComponent:0]]];
	}
	
	[self removeFromSuperview];
}

-(void)pickerHideCancel
{
	[self removeFromSuperview];
}

- (void)dealloc 
{
	[sourceArray release];
    [picker		 release];
    [pickerSheet release];
	
    [super dealloc];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	return [self.sourceArray objectAtIndex:row];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.sourceArray count];
}


@end
