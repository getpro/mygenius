//
//  AddressAddMoreVC.h
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//添加联系人－高级信息

#import <UIKit/UIKit.h>

#import "ABContact.h"
#import "CAttributeContainer.h"

@interface AddressAddSeniorVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	IBOutlet UIBarButtonItem * m_pRightDone;        //完成
	
	ABContact * m_pContact;
	
	//CAttributeContainer * m_pContainer;
	CAttributeContainer      * m_pContainer;					//单项
	
	CAttributeContainer      * m_pMemoContainer;				//多项
	CAttributeContainer      * m_pIMContainer;
	CAttributeContainer      * m_pAccountsContainer;
	CAttributeContainer      * m_pCertificateContainer;
}

@property (retain,nonatomic) IBOutlet UITableView * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pRightDone;
@property (retain,nonatomic) ABContact * m_pContact;

-(IBAction)doneItemBtn:  (id)sender;

@end
