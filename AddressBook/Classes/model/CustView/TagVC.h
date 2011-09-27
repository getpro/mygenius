//
//  TagVC.h
//  AddressBook
//
//  Created by Peteo on 11-9-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  标签

#import <UIKit/UIKit.h>

#import "PublicData.h"

@interface TagVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	
	IBOutlet UIBarButtonItem * m_pRightDone;        //编辑
	IBOutlet UIBarButtonItem * m_pRightEdit;        //完成
	
	Tag_Type				   m_nType;
	NSArray                  * m_pDateArry;
	
	id  Target;
	SEL Selector;
}

@property (nonatomic,retain) IBOutlet UITableView     * m_pTableView_IB;
@property (nonatomic,retain) IBOutlet UIBarButtonItem * m_pRightDone;
@property (nonatomic,retain) IBOutlet UIBarButtonItem * m_pRightEdit;
@property (nonatomic,assign) Tag_Type				    m_nType;
@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;


@end
