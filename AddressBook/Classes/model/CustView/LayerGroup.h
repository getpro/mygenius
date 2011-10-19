//
//  LayerGroup.h
//  AddressBook
//
//  Created by Peteo on 11-10-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LayerGroup : UIView 
<
UITableViewDelegate, 
UITableViewDataSource
>
{
	UITableView * m_pTableView;
	UIImageView * m_pArrImg;
	UIImageView * m_pContentView;
	NSString    * m_pName;
	
	id  Target;
	SEL Selector;
}

@property (nonatomic, retain) UIImageView  * m_pArrImg;
@property (nonatomic, retain) NSString     * m_pName;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

-(void) setOffSet :(int)y;

@end
