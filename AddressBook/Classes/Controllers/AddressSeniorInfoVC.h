//
//  AddressAddMoreVC.h
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// 查看联系人－高级信息

#import <UIKit/UIKit.h>

#import "ABContact.h"

@interface AddressSeniorInfoVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	IBOutlet UIBarButtonItem * m_pRightEdit;        //编辑
	
	UISegmentedControl       * m_pSegmentedControl;
	
	UINavigationController   * aBPersonNav;
	
	ABContact * m_pContact;
}

@property (retain,nonatomic) IBOutlet UITableView * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pRightEdit;
@property (retain,nonatomic) UINavigationController *aBPersonNav;
@property (retain,nonatomic) ABContact * m_pContact;

-(IBAction)doneItemBtn:  (id)sender;

@end
