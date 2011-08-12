//
//  SwitchViewController.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "AddressBookVC.h"
#import "accountsVC.h"
#import "dateVC.h"
#import "memoVC.h"
#import "settingVC.h"

#import "AddressInfoVC.h"
#import "AddressEditVC.h"
#import "AddressAddMoreVC.h"

@interface SwitchViewController : UIViewController 
{
	AddressBookVC * m_pAddressBookVC;
	accountsVC    * m_paccountsVC;
	dateVC	      * m_pdateVC;
	memoVC		  * m_pmemoVC;
	settingVC     * m_psettingVC;
	
	AddressInfoVC	  * m_pAddressInfoVC;
	AddressEditVC	  * m_pAddressEditVC;
	AddressAddMoreVC  * m_pAddressAddMoreVC;
}

@property (nonatomic, retain) AddressBookVC * m_pAddressBookVC;
@property (nonatomic, retain) accountsVC    * m_paccountsVC;
@property (nonatomic, retain) dateVC	    * m_pdateVC;
@property (nonatomic, retain) memoVC		* m_pmemoVC;
@property (nonatomic, retain) settingVC     * m_psettingVC;

@property (nonatomic, retain) AddressInfoVC    * m_pAddressInfoVC;
@property (nonatomic, retain) AddressEditVC    * m_pAddressEditVC;
@property (nonatomic, retain) AddressAddMoreVC * m_pAddressAddMoreVC;

@end
