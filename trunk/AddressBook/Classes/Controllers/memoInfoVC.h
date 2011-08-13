//
//  memoInfoVC.h
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface memoInfoVC : UIViewController 
{
	IBOutlet UIScrollView * m_pUIScrollView_IB;
	
	UIDatePicker * m_pDatePicker;
}

@property (retain,nonatomic) IBOutlet UIScrollView * m_pUIScrollView_IB;

@property (retain,nonatomic) UIDatePicker * m_pDatePicker;

-(void)myInit;

/*
 * 设置时间，并实时显示时间
 * @param  nil
 * @return nil
 */
-(void)SetDat;

-(IBAction)returnItemBtn: (id)sender;
-(IBAction)editItemBtn:   (id)sender;

/*
 * 点击空白处
 * @param  nil
 * @return nil
 */
-(IBAction)disappearKeyboard;

@end
