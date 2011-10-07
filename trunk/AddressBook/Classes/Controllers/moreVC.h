//
//  moreVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// 更多

#import <UIKit/UIKit.h>

@interface moreVC : UIViewController
<
UITableViewDelegate, 
UITableViewDataSource
>
{
	IBOutlet UITableView      * m_pTableView_IB;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;

@end
