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

-(void)CheckCallBack:(NSDate*)pStartData :(NSDate*)pEndData :(ABContact*)pABContact;

@end

@interface statisticsCheckVC : UIViewController 
{
	IBOutlet UITableView      * m_pTableView_IB;
	
	ABContact * m_pABContact;
	NSDate    * m_pStartDate;
	NSDate    * m_pEndDate;
	
	id <CheckDelegate> delegate;
}

@property (retain,nonatomic) IBOutlet UITableView      * m_pTableView_IB;
@property (retain,nonatomic) ABContact * m_pABContact;
@property (retain,nonatomic) NSDate    * m_pStartDate;
@property (retain,nonatomic) NSDate    * m_pEndDate;
@property (nonatomic, assign) id <CheckDelegate> delegate;

-(IBAction)search:(id)sender;

@end
