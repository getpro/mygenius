//
//  AddressInfoVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABContact.h"

@interface AddressPreInfoVC : UIViewController < ABPersonViewControllerDelegate >
{
	IBOutlet UITableView      * m_pTableView_IB;
	IBOutlet UIBarButtonItem  * m_pRightAdd;
	
	ABContact * m_pContact;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem  * m_pRightAdd;
@property (retain,nonatomic) ABContact * m_pContact;

-(IBAction)MoreInfoBtn: (id)sender;

@end
