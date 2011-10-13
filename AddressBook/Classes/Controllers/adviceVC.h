//
//  adviceVC.h
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  意见反馈

#import <UIKit/UIKit.h>


@interface adviceVC : UIViewController  <UITextViewDelegate>
{
	IBOutlet UITextView * m_pTextPhone;
	IBOutlet UITextView * m_pTextContent;
}

@property (retain,nonatomic) IBOutlet UITextView      * m_pTextPhone;
@property (retain,nonatomic) IBOutlet UITextView      * m_pTextContent;

@end
