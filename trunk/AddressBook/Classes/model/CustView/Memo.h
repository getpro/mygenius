//
//  Memo.h
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Memo : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
	IBOutlet UIBarButtonItem * m_pReturn;        //返回
	IBOutlet UIBarButtonItem * m_pDone;          //完成
	
	UIPickerView  * picker;
    NSArray		  * sourceArray;
	
	UIDatePicker  * datePickerView;

	id  Target;
	SEL Selector;
}

@property (nonatomic,retain) IBOutlet UIBarButtonItem     * m_pReturn;
@property (nonatomic,retain) IBOutlet UIBarButtonItem     * m_pDone;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

@end
