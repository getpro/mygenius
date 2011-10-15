//
//  serviceListVC.h
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface serviceListVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	
	IBOutlet UIBarButtonItem * m_pButtonItemEdit;        //编辑
	IBOutlet UIBarButtonItem * m_pButtonItemDone;        //完成
	IBOutlet UIBarButtonItem * m_pButtonItemCancel;      //取消
	
	NSMutableArray			 * m_arrRule;				 //运营商规则
	
	
}

@property (retain,nonatomic) IBOutlet UITableView     * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemEdit;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemDone;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemCancel;

-(IBAction)doneItemBtn:    (id)sender;
-(IBAction)cancelItemBtn:  (id)sender;
-(IBAction)editItemBtn:    (id)sender;

-(void)LoadRule;

@end
