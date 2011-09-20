//
//  AddressEdit.h
//  AddressBook
//
//  Created by Peteo on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface AddressBaseInfoVC : ABPersonViewController < ABPersonViewControllerDelegate >
{
	UISegmentedControl       * m_pSegmentedControl;
	
	UINavigationController   * aBPersonNav;
}

@property (retain,nonatomic) UINavigationController *aBPersonNav;

-(IBAction)cancelItemBtn:(id)sender;
-(IBAction)doneItemBtn:  (id)sender;

@end
