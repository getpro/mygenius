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
	UIActionSheet * pickerSheet;
	UIPickerView  * picker;
    NSArray		  * sourceArray;
}

@property(nonatomic, retain)UIActionSheet* pickerSheet;
@property(nonatomic, retain)UIPickerView* picker;
@property(nonatomic, retain)NSArray* sourceArray;

-(void)pickerHideOK;
-(void)pickerHideCancel;

@end
