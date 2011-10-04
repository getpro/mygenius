//
//  Memo.h
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Memo : UIViewController
{
	IBOutlet UITableView     * m_pTableView_IB;
	
	IBOutlet UIBarButtonItem * m_pReturn;        //返回
	IBOutlet UIBarButtonItem * m_pDone;          //完成
	
	NSString * m_pRemind;
	NSString * m_pTime;
	
	NSDate   * m_pDate;
	NSInteger  m_nRemindIndex;
	
    NSArray		  * sourceArray;
	
	id  Target;
	SEL Selector;
}

@property (nonatomic,retain) IBOutlet UITableView         * m_pTableView_IB;
@property (nonatomic,retain) IBOutlet UIBarButtonItem     * m_pReturn;
@property (nonatomic,retain) IBOutlet UIBarButtonItem     * m_pDone;
@property (nonatomic,retain) NSString * m_pRemind;
@property (nonatomic,retain) NSString * m_pTime;
@property (nonatomic,retain) NSDate   * m_pDate;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(IBAction)ReturnItemBtn:  (id)sender;
-(IBAction)DoneItemBtn:    (id)sender;

@end
