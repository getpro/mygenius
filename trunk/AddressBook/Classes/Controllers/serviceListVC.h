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
}

@property (retain,nonatomic) IBOutlet UITableView     * m_pTableView_IB;

@end
