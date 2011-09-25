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
	NSArray					 * m_pSource;
}

@property (retain,nonatomic) IBOutlet UITableView * m_pTableView_IB;

@end
