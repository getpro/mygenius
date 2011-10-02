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
#import "CAttributeContainer.h"

@interface AddressSeniorInfoVC : UIViewController
{
	IBOutlet UITableView     * m_pTableView_IB;
	
	IBOutlet UIBarButtonItem * m_pButtonItemEdit;        //编辑
	IBOutlet UIBarButtonItem * m_pButtonItemDone;        //完成
	IBOutlet UIBarButtonItem * m_pButtonItemCancel;      //取消
	
	UIBarButtonItem * m_pButtonItemReturn;      //返回
	
	UISegmentedControl       * m_pSegmentedControl;
	
	UINavigationController   * aBPersonNav;
	
	ABContact * m_pContact;
	
	CAttributeContainer      * m_pContainer;					//单项
	CAttributeContainer      * m_pMemoContainer;				//多项
	CAttributeContainer      * m_pAccountsContainer;
	CAttributeContainer      * m_pCertificateContainer;
}

@property (retain,nonatomic) IBOutlet UITableView * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemEdit;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemDone;
//@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemReturn;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemCancel;

@property (retain,nonatomic) UINavigationController *aBPersonNav;
@property (retain,nonatomic) ABContact * m_pContact;

-(IBAction)doneItemBtn:    (id)sender;
-(IBAction)cancelItemBtn:  (id)sender;
-(IBAction)editItemBtn:    (id)sender;

//加载数据
-(void)LoadAttribute;

@end
