//
//  MemoCheckBox.h
//  AddressBook
//
//  Created by Peteo on 11-10-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  备忘录长按弹出框

#import <UIKit/UIKit.h>

@interface MemoCheckBox : UIView 
{
	id  Target;
	SEL Selector;
}

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

@end
