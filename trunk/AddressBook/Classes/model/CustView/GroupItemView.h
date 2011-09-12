//
//  GroupItemView.h
//  AddressBook
//
//  Created by Peteo on 11-9-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroupItemView : UIView 
{
	UIImageView * _SelectBg;
	UIImageView * _NumBg;
	UILabel		* _LabelNum;
}

- (id)initWithFrame:(CGRect)frame :(NSString*) pStr;

@end
