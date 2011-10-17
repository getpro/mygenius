//
//  statisticsCheckVC.h
//  AddressBook
//
//  Created by Peteo on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  日常查询设置

#import <UIKit/UIKit.h>

#import "ABContact.h"

//点击搜索回调协议
@protocol CheckDelegate

@required

-(void)CheckCallBack:(NSDate*)pStartData :(NSDate*)pEndData :(ABContact*)pABContact:(NSInteger)pIndex;

@end

@interface statisticsCheckVC : UIViewController  < UITextFieldDelegate >
{
	IBOutlet UITableView      * m_pTableView_IB;
	UITextField               * m_pTextField;
	
	ABContact * m_pABContact;
	NSDate    * m_pStartDate;
	NSDate    * m_pEndDate;
	NSArray   * m_pTypeArr;
	NSInteger   m_nTypeIndex;
	
	id <CheckDelegate> delegate;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) ABContact * m_pABContact;
@property (retain,nonatomic) NSDate    * m_pStartDate;
@property (retain,nonatomic) NSDate    * m_pEndDate;

@property (nonatomic, assign) id <CheckDelegate> delegate;
@property (nonatomic, assign) NSInteger   m_nTypeIndex;

-(IBAction)search:(id)sender;

@end
