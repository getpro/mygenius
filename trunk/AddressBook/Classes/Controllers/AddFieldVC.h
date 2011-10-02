//
//  AddFieldVC.h
//  AddressBook
//
//  Created by Peteo on 11-9-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddFieldVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	IBOutlet UIBarButtonItem * m_pRightReturn;        //返回
	
	NSArray					 * m_pSource;
	
	id  Target;
	SEL Selector;
}

@property (retain,nonatomic) IBOutlet UITableView     * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pRightReturn;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(IBAction)ReturnItemBtn:  (id)sender;

@end
