//
//  baseVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicData.h"

@interface baseVC : UIViewController  <UITabBarDelegate>
{
	IBOutlet UITabBar * m_pUITabBar_IB;
	
	IBOutlet UITabBarItem * m_pUITabBarItem1_IB;
	IBOutlet UITabBarItem * m_pUITabBarItem2_IB;
	IBOutlet UITabBarItem * m_pUITabBarItem3_IB;
	IBOutlet UITabBarItem * m_pUITabBarItem4_IB;
	IBOutlet UITabBarItem * m_pUITabBarItem5_IB;
}

@property (nonatomic, retain) IBOutlet UITabBar * m_pUITabBar_IB;

@property (nonatomic, retain) UITabBarItem * m_pUITabBarItem1_IB;
@property (nonatomic, retain) UITabBarItem * m_pUITabBarItem2_IB;
@property (nonatomic, retain) UITabBarItem * m_pUITabBarItem3_IB;
@property (nonatomic, retain) UITabBarItem * m_pUITabBarItem4_IB;
@property (nonatomic, retain) UITabBarItem * m_pUITabBarItem5_IB;



@end
