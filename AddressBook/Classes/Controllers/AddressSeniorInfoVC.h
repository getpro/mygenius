//
//  AddressAddMoreVC.h
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddressSeniorInfoVC : UIViewController 
{
	IBOutlet UITableView      * m_pTableView_IB;
}

@property (retain,nonatomic) IBOutlet UITableView * m_pTableView_IB;


-(IBAction)doneItemBtn:  (id)sender;

@end
