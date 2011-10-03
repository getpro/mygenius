//
//  CustomPicker.h
//  AddressBook
//
//  Created by Peteo on 11-9-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPicker : UIView < UIPickerViewDelegate, UIPickerViewDataSource >
{
	UIPickerView  * picker;
    NSArray		  * sourceArray;
	
	id  Target;
	SEL Selector;
}

@property(nonatomic, retain)UIPickerView* picker;
@property(nonatomic, retain)NSArray* sourceArray;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(void)pickerHideOK;
-(void)pickerHideCancel;

@end
