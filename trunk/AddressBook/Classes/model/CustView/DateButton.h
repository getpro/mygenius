//
//  DateButton.h
//  AddressBook
//
//  Created by Peteo on 11-10-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateButton : UIButton 
{
	id  Target;
	SEL Selector;
}

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

@end
