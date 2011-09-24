//
//  syncVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  同步备份

#import <UIKit/UIKit.h>

@interface syncVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	
	UIButton * m_pSyncAccountBtn;
}

@property (nonatomic,retain) IBOutlet UITableView  * m_pTableView_IB;

-(IBAction)sendBtn:(id)sender;

@end
