//
//  DateButton.h
//  AddressBook
//
//  Created by Peteo on 11-10-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  备忘录左上角的日期按钮

#import <Foundation/Foundation.h>


@interface DateButton : UIButton 
{
	id  Target;
	SEL Selector;
	
	UILabel    *m_pMonth;
	UILabel    *m_pDay;
	
	NSDate     *date;
}

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;
@property (nonatomic, retain) NSDate *date;

-(void) setButtonDate:(NSDate*)pDate;

@end
