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
	
	bool isPickerShow;
}

@property(nonatomic, retain)UIActionSheet* pickerSheet;
@property(nonatomic, retain)UIPickerView* picker;
@property(nonatomic) bool isPickerShow;
@property(nonatomic, retain) NSArray* sourceArray;

-(void)pickerShow;
-(void)pickerHideOK;
-(void)pickerHideCancel;

@end
