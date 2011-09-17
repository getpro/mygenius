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
	IBOutlet UIScrollView * m_pUIScrollView_IB;
}

@property (retain,nonatomic) IBOutlet UIScrollView * m_pUIScrollView_IB;

-(void)myInit;

-(IBAction)doneItemBtn:  (id)sender;

@end
