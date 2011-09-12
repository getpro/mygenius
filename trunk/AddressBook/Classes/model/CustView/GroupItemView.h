//
//  GroupItemView.h
//  AddressBook
//
//  Created by Peteo on 11-9-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupItemViewDelegate

-(void) GroupItemViewSelect:(NSInteger)pIndex;

@end


@interface GroupItemView : UIView 
{
	id<GroupItemViewDelegate> _delegate;//回调给AddressBookVC
	
	UIImageView * _SelectBg; //选中背景
	UIImageView * _NumBg;    //数字背景
	UILabel		* _LabelNum; //数字显示
	
	NSInteger     _count;    //数字大小
}

@property (nonatomic,assign) id<GroupItemViewDelegate> delegate;
@property (nonatomic,assign) NSInteger count;

- (id)initWithFrame:(CGRect)frame :(NSString*) pStr :(NSInteger)pCount;

- (void)SetHidden:(BOOL)pHidden;

@end
