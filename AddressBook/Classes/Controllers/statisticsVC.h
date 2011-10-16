//
//  statisticsVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  统计

#import <UIKit/UIKit.h>

#import "checkDateButton.h"
#import "statisticsCheckVC.h"

@interface statisticsVC : UIViewController
<
UISearchBarDelegate,
UITableViewDelegate, 
UITableViewDataSource,
CheckDelegate
>
{
	UISearchDisplayController * m_pSearchDC;
	UISearchBar				  * m_pSearchBar;
	
	IBOutlet UITableView      * m_pTableView_IB;
	
	ABContact       *m_pABContact;
	NSDate          *m_pStartDate;
	NSDate          *m_pEndDate;
	checkDateButton *m_pDateButton;
}

@property (retain,nonatomic) UISearchDisplayController * m_pSearchDC;
@property (retain,nonatomic) UISearchBar			   * m_pSearchBar;
@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (nonatomic, retain) NSDate *m_pStartDate;
@property (nonatomic, retain) NSDate *m_pEndDate;
@property (nonatomic, retain) ABContact *m_pABContact;

@end
