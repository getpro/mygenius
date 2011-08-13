//
//  memoVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  备忘录

#import <UIKit/UIKit.h>

#import "baseVC.h"

@interface memoVC : baseVC < UIActionSheetDelegate,UISearchBarDelegate,
	UITableViewDelegate, UITableViewDataSource >
{
	UISearchDisplayController * m_pSearchDC;
	UISearchBar				  * m_pSearchBar;
	
	IBOutlet UITableView      * m_pTableView_IB;
}

@property (retain,nonatomic) UISearchDisplayController * m_pSearchDC;
@property (retain,nonatomic) UISearchBar			   * m_pSearchBar;
@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;

-(IBAction)addItemBtn:(id)sender;
-(IBAction)editItemBtn:(id)sender;

@end
