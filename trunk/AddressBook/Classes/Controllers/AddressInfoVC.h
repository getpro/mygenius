//
//  AddressInfoVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddressInfoVC : UIViewController 
{
	IBOutlet UIScrollView * m_pUIScrollView_IB;
}

@property (retain,nonatomic) IBOutlet UIScrollView * m_pUIScrollView_IB;

-(void)myInit;

@end
