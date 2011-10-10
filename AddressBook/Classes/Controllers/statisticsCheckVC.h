//
//  statisticsCheckVC.h
//  AddressBook
//
//  Created by Peteo on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  日常查询设置

#import <UIKit/UIKit.h>


@interface statisticsCheckVC : UIViewController 
{
	IBOutlet UITableView      * m_pTableView_IB;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;

@end
