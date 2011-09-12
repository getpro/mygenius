//
//  AddressBookVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  通讯录首页

#import <UIKit/UIKit.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "GroupItemView.h"

@interface AddressBookVC : UIViewController  
< 
UISearchBarDelegate,
UITableViewDelegate, 
UITableViewDataSource,
ABNewPersonViewControllerDelegate,
UIActionSheetDelegate,
GroupItemViewDelegate
>
{
	UISearchDisplayController * m_pSearchDC;
	UISearchBar				  * m_pSearchBar;
	
	IBOutlet UITableView      * m_pTableView_IB;
	IBOutlet UIScrollView     * m_pScrollView_IB;
	IBOutlet UIImageView      * m_pImageView_IB;
}

@property (retain,nonatomic) UISearchDisplayController * m_pSearchDC;
@property (retain,nonatomic) UISearchBar			   * m_pSearchBar;
@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIScrollView     * m_pScrollView_IB;
@property (retain,nonatomic) IBOutlet UIImageView      * m_pImageView_IB;

-(IBAction)editItemBtn:(id)sender;
-(IBAction)addItemBtn: (id)sender;

@end
