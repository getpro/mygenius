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
	
	IBOutlet UIButton * button1;
	IBOutlet UIButton * button2;
	IBOutlet UIButton * button3;
	IBOutlet UIButton * button4;
	
	NSInteger m_nRoom1;
	NSInteger m_nRoom2;
	NSInteger m_nRoom3;
	NSInteger m_nRoom4;
}

@property (nonatomic,retain) IBOutlet UIButton * button1;

@property (nonatomic,retain) IBOutlet UIButton * button2;

@property (nonatomic,retain) IBOutlet UIButton * button3;

@property (nonatomic,retain) IBOutlet UIButton * button4;

-(IBAction) room1;
-(IBAction) room2;
-(IBAction) room3;
-(IBAction) room4;

-(IBAction) reFresh;

-(void) UpDateRoomNum;

@end
