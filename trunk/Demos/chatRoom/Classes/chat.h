//
//  chat.h
//  chatRoom
//
//  Created by Peteo on 11-8-7.
//  Copyright 2011 The9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotonListener.h"

@interface ChatContent : NSObject
{
	NSUInteger  direction;//1:left(自己) rect 0:right（别人） rect
	NSString  * labelText;
}

@property NSUInteger direction;
@property(retain,nonatomic) NSString *labelText;

@end


@interface chat : UIViewController < MyListener,UITextFieldDelegate>
{
	IBOutlet UITableView * advTable;
	
	NSMutableArray * m_pAdArr;
}

@end
