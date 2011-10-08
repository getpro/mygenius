//
//  checkDateButton.h
//  AddressBook
//
//  Created by Peteo on 11-10-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface checkDateButton : UIButton 
{
	id  Target;
	SEL Selector;
	
	UILabel    *m_pMonth;
	UILabel    *m_pDay;
}

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(void) setButtonDate:(NSDate*)pDate;

@end
