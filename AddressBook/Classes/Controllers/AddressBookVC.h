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
	IBOutlet UIBarButtonItem  * m_pRightAdd;
	
	NSMutableArray		*filteredArray;
	NSMutableArray		*contactNameArray;   //所有联系人的名字
	NSMutableDictionary *contactNameDic;     //名字对应和对应的第一个字母
	NSMutableArray		*sectionArray;       //成员是27个NSMutableArray,每一个NSMutableArray包含了对应ABContact
	NSArray				*contacts;           //ContactData系统通讯录的数组的索引(成员是ABContact)
	NSString			*sectionName;
	
	BOOL isSearch, isEdit, isGroup;
}

@property (retain,nonatomic) UISearchDisplayController * m_pSearchDC;
@property (retain,nonatomic) UISearchBar			   * m_pSearchBar;
@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) IBOutlet UIScrollView     * m_pScrollView_IB;
@property (retain,nonatomic) IBOutlet UIImageView      * m_pImageView_IB;
@property (retain,nonatomic) IBOutlet UIBarButtonItem  * m_pRightAdd;

@property (retain,nonatomic) NSMutableArray *filteredArray;
@property (retain,nonatomic) NSMutableArray *contactNameArray;
@property (retain,nonatomic) NSMutableDictionary *contactNameDic;
@property (retain,nonatomic) NSMutableArray *sectionArray;

-(IBAction)editItemBtn:(id)sender;
-(IBAction)addItemBtn: (id)sender;

//初始化数据
-(void)initData:(NSInteger)pIndex;

//加载分组信息
-(void)LoadGroup;

@end
