//
//  AddressInfoVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// 查看联系人

#import <UIKit/UIKit.h>

#import "ABContact.h"
#import "CAttributeContainer.h"

@interface AddressPreInfoVC : UIViewController < ABPersonViewControllerDelegate >
{
	IBOutlet UITableView      * m_pTableView_IB;    //信息表
	IBOutlet UIBarButtonItem  * m_pRightAdd;        //更多信息
	IBOutlet UIImageView      * m_pHead_IB;         //头像
	
	IBOutlet UILabel          * m_pName_IB;			//姓名
	IBOutlet UILabel          * m_pJobAndDep_IB;	//职位和部门
	IBOutlet UILabel          * m_pOrganization_IB;	//公司
	
	ABContact * m_pContact;
	
	CAttributeContainer * m_pContainer;
	NSMutableArray      * m_pData;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem  * m_pRightAdd;
@property (retain,nonatomic) IBOutlet UIImageView      * m_pHead_IB;
@property (retain,nonatomic) IBOutlet UILabel          * m_pName_IB;
@property (retain,nonatomic) IBOutlet UILabel          * m_pJobAndDep_IB;
@property (retain,nonatomic) IBOutlet UILabel          * m_pOrganization_IB;


@property (retain,nonatomic) ABContact * m_pContact;
@property (retain,nonatomic) CAttributeContainer * m_pContainer;
@property (retain,nonatomic) NSMutableArray      * m_pData;

-(IBAction)MoreInfoBtn: (id)sender;

@end
