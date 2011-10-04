//
//  RecommendVC.h
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecommendVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	IBOutlet UIBarButtonItem * m_pReturn;        //返回
	
	id  Target;
	SEL Selector;
}

@property (nonatomic,retain) IBOutlet UITableView       * m_pTableView_IB;
@property (nonatomic,retain) IBOutlet UIBarButtonItem   * m_pReturn;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(IBAction)ReturnItemBtn:  (id)sender;

@end
