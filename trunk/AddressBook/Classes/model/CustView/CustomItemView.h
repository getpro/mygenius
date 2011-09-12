//
//  CustomItemView.h
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  通讯录信息的一个条目（包括标签，内容，背景框）

#import <Foundation/Foundation.h>


@interface CustomItemView : UIView < UITextFieldDelegate >
{
	UIImageView * m_pBorder; //边框
	UILabel     * m_pTitle;  //标签
	
	BOOL          b_IsEdit;  //是否可编辑
	
	UILabel     * m_pLabelContent;		//内容 b_IsEdit:NO
	UITextField * m_pTextFieldContent;  //标签 b_IsEdit:YES
}

@property (nonatomic, retain) UIImageView * m_pBorder;
@property (nonatomic, retain) UILabel     * m_pTitle;
@property (nonatomic, retain) UILabel     * m_pLabelContent;
@property (nonatomic, retain) UITextField * m_pTextFieldContent;

@property BOOL b_IsEdit;

- (id)initWithFrame:(CGRect)frame IsEdit:(BOOL)pIsEdit;

@end
