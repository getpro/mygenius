//
//  memoInfoVC.h
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CustomDatePicker.h"

@interface memoInfoVC : UIViewController 
{
	IBOutlet UIScrollView * m_pUIScrollView_IB;
	
	CustomDatePicker * m_pCustomDatePicker;
}

@property (retain,nonatomic) IBOutlet UIScrollView * m_pUIScrollView_IB;

@property (retain,nonatomic) CustomDatePicker * m_pCustomDatePicker;


/*
 * 设置时间，并实时显示时间
 * @param  nil
 * @return nil
 */
-(void)SetDat;

/*
 * 保存纪念日的信息
 * @param  nil
 * @return BOOL YES:保存成功 NO:保存未成功
 */
-(BOOL)SaveMemoInfo;


-(IBAction)returnItemBtn: (id)sender;
-(IBAction)editItemBtn:   (id)sender;



@end
