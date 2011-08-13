//
//  CustomButtonView.h
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomButtonView : UIView 
{
	UILabel     * m_pTitle;				//标签
	UILabel     * m_pLabelContent;		//内容
	
	UIButton    * m_pButton;	        //响应点击事件
}

@property (nonatomic, retain) UILabel     * m_pTitle;
@property (nonatomic, retain) UILabel     * m_pLabelContent;
@property (nonatomic, retain) UIButton    * m_pButton;


- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;

@end
