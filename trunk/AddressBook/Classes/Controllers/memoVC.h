//
//  memoVC.h
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  备忘录

#import <UIKit/UIKit.h>
#import "baseVC.h"

@interface memoVC : baseVC <UIActionSheetDelegate>
{

}

-(IBAction)lookItemBtn:(id)sender;
-(IBAction)editItemBtn:(id)sender;

@end
