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
	UILabel    *m_pStartDay;
	UILabel    *m_pEndDay;
}

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(NSString*) getMonthStr:(int)pIndex;

-(void) setButtonDate:(NSDate*)pStartDate :(NSDate*)pEndDate;

@end
