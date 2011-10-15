//
//  serviceInfo.h
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface serviceInfo : UIViewController <UITextViewDelegate>
{
	NSString  * m_strTitle;   //运营商名字
	NSString  * m_strRule;    //规则
	NSInteger   m_nSection;   //ServiceList中的索引
	
	IBOutlet UITextView   * m_pTextView;
	IBOutlet UITextField  * m_pTextField;
	
	IBOutlet UIBarButtonItem * m_pButtonItemDone;        //完成
	
	id  Target;
	SEL Selector;
}

@property (retain,nonatomic) NSString * m_strTitle;
@property (retain,nonatomic) NSString * m_strRule;
@property (assign,nonatomic) NSInteger  m_nSection;

@property (retain,nonatomic) IBOutlet UIBarButtonItem * m_pButtonItemDone;
@property (retain,nonatomic) IBOutlet UITextView      * m_pTextView;
@property (retain,nonatomic) IBOutlet UITextField     * m_pTextField;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(IBAction)doneItemBtn:    (id)sender;

@end
