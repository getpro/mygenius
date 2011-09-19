//
//  AddressInfoVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABContact.h"
#import "CAttributeContainer.h"

@interface AddressPreInfoVC : UIViewController < ABPersonViewControllerDelegate >
{
	IBOutlet UITableView      * m_pTableView_IB;
	IBOutlet UIBarButtonItem  * m_pRightAdd;
	
	UINavigationController    * aBPersonNav;
	
	ABContact * m_pContact;
	
	CAttributeContainer * m_pContainer;
	NSMutableArray      * m_pData;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem  * m_pRightAdd;
@property (retain,nonatomic) ABContact * m_pContact;
@property (retain,nonatomic) UINavigationController *aBPersonNav;
@property (retain,nonatomic) CAttributeContainer * m_pContainer;
@property (retain,nonatomic) NSMutableArray      * m_pData;

-(IBAction)MoreInfoBtn: (id)sender;

@end
