//
//  syncButtonCell.h
//  AddressBook
//
//  Created by Peteo on 11-9-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *KsyncButtonCell_ID;

typedef enum 
{
    ESyncButtonType_Sync,     //同步
	ESyncButtonType_BackUp,   //备份
	ESyncButtonType_Count
}ESyncButtonType;

@interface syncButtonCell : UITableViewCell 
{

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(ESyncButtonType)type;

@end
