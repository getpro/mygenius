//
//  MemoCell.h
//  AddressBook
//
//  Created by Peteo on 11-10-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *KMemoCell_ID;

@interface MemoCell : UITableViewCell 
{
	NSInteger m_nOffSet; //长按时，偏移15个像素
	
	BOOL m_IsSelect;
	
	UIImageView * m_pCheckSelect;
	UIImageView * m_pCheck;
	
	UILabel     * m_pTime;		//全天
	UILabel     * m_pTitle;		//标题
	UILabel     * m_pLocate;    //位置
}

@property (nonatomic,retain) UILabel     * m_pTitle;
@property (nonatomic,retain) UILabel     * m_pLocate;
@property (nonatomic,retain) UILabel     * m_pTime;
@property (nonatomic,assign) NSInteger m_nOffSet;
@property (nonatomic,assign) BOOL m_IsSelect;

- (void) setOffSet:(BOOL)pHasOffSet;
- (void) setSelect:(BOOL)pSelect;

@end
