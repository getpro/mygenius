//
//  statisticsVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  统计

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

#import "checkDateButton.h"
#import "statisticsCheckVC.h"
#import "MemoCell.h"

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
	NSDate          *m_pStartDate;   //开始时间
	NSDate          *m_pEndDate;     //结束时间
	checkDateButton *m_pDateButton;
	NSInteger        m_nTypeIndex;//@"全部",@"生日",@"纪念日",@"其他"
	
	NSMutableArray  *eventsList;   //所有事件
	NSMutableArray	*sectionArray; //成员是NSMutableArray,每一个NSMutableArray包含了对应Event
	NSMutableArray	*sectionTitle;
	NSMutableArray  *filteredArray;//搜索数组
}

@property (retain,nonatomic) UISearchDisplayController * m_pSearchDC;
@property (retain,nonatomic) UISearchBar			   * m_pSearchBar;
@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;


@property (nonatomic, retain) NSMutableArray *eventsList;
@property (nonatomic, retain) NSMutableArray *sectionArray;
@property (nonatomic, retain) NSMutableArray *sectionTitle;
@property (nonatomic, retain) NSMutableArray *filteredArray;

@property (nonatomic, retain) NSDate *m_pStartDate;
@property (nonatomic, retain) NSDate *m_pEndDate;
@property (nonatomic, retain) ABContact *m_pABContact;

-(void) checkType:(NSString*)pStr :(MemoCell*)pCell;

-(void) fetchEvents;

@end
