//
//  chooiceRoom.h
//  chatRoom
//
//  Created by Peteo on 11-8-7.
//  Copyright 2011 The9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotonListener.h"

@interface chooiceRoom : UIViewController  < MyListener >
{
	UIActivityIndicatorView * m_pActivity;
}

-(IBAction) room1;
-(IBAction) room2;
-(IBAction) room3;
-(IBAction) room4;


@end
