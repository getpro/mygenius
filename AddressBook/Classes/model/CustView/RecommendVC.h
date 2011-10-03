//
//  RecommendVC.h
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecommendVC : UIViewController 
{
	IBOutlet UITableView     * m_pTableView_IB;
	
	id  Target;
	SEL Selector;
}

@property (nonatomic,retain) IBOutlet UITableView     * m_pTableView_IB;

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

@end
