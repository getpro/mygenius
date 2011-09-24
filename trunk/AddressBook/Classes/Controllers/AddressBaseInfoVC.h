//
//  AddressEdit.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// 查看联系人－基本信息

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "ABContact.h"

@interface AddressBaseInfoVC : ABPersonViewController < ABPersonViewControllerDelegate >
{
	UISegmentedControl       * m_pSegmentedControl;
	
	UINavigationController   * aBPersonNav;
	
	ABContact * m_pContact;
}

@property (retain,nonatomic) UINavigationController *aBPersonNav;
@property (retain,nonatomic) ABContact * m_pContact;

-(IBAction)cancelItemBtn:(id)sender;
-(IBAction)doneItemBtn:  (id)sender;

@end
