//
//  ContactCell.h
//  AddressBook
//
//  Created by Peteo on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *KContactCell_ID;

@interface ContactCell : UITableViewCell 
{
	NSInteger m_nOffSet; //长按时，偏移14个像素
	
	UIImageView * m_pHead; //头像
	
	UILabel     * m_pName; //名字
	
	UIImageView * m_pMove;
	UIImageView * m_pCheckSelect;
	UIImageView * m_pCheck;
	
	BOOL m_IsSelect;
}

@property (nonatomic,assign) NSInteger m_nOffSet;
@property (nonatomic,assign) BOOL m_IsSelect;

@property (nonatomic,retain) UIImageView * m_pHead;
@property (nonatomic,retain) UILabel     * m_pName;

- (void) setOffSet:(BOOL)pHasOffSet;
- (void) setSelect:(BOOL)pSelect;

@end
