//
//  TagCell.h
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CAttributeCell.h"

@interface TagCell : CAttributeCell 
{
	UIButton    *button;
	BOOL         bIsLabel_Click; //标签是否能点击
	
	id  Target;
	SEL Selector;
}

@property (nonatomic, assign) BOOL bIsLabel_Click;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

@end
