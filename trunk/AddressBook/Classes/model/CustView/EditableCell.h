//
//  EditableCell.h
//  Pulp Dossier
//
//  Created by Courtney Holmes on 5/31/11.
//  Copyright 2011 CJ Holmes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CAttributeCell.h"

@interface EditableCell : CAttributeCell 
{
	UITextField *textField;
	UIButton    *button;
	BOOL         bIsLabel_Click; //标签是否能点击
}

@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, assign) BOOL bIsLabel_Click;

@end
