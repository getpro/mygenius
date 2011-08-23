//
//  ChoiceRoom.m
//  punchball
//
//  Created by Peteo on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChoiceRoom.h"

@implementation ChoiceRoom

-(void) room1: (id) sender
{	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room1];
	}
}

-(void) room2: (id) sender
{	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room2];
	}
}

-(void) room3: (id) sender
{	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room3];
	}
}

-(void) room4: (id) sender
{	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room4];
	}
}

-(void) refresh: (id) sender
{
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_ReFresh];
	}
}

-(void) Return: (id) sender
{	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Return];
	}
}

-(void) sendDate: (id) sender
{	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_SendChat];
	}
}

- (id) init: (id<ChoiceRoomDelegate>) _delegate 
{
	[super init];
	
	delegate = _delegate;
	
	CGSize size = [[Director sharedDirector] winSize];
	
	//4个房间的Item
	
	MenuItemImage *vm1 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room1:)];
	Label *label1 = [Label labelWithString:@"ROOM1(0)" fontName:@"Marker Felt" fontSize:26];
	item1 = [MenuItemLabel itemWithLabel:label1 target:nil selector:nil];
	Menu *vmm1 = [Menu menuWithItems: vm1,item1,nil];
	vmm1.position = ccp(size.width / 3, 2 * size.height / 3);
	[self addChild:vmm1 z:1];
	
	
	MenuItemImage *vm2 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room2:)];
	Label *label2 = [Label labelWithString:@"ROOM2(0)" fontName:@"Marker Felt" fontSize:26];
	item2 = [MenuItemLabel itemWithLabel:label2 target:nil selector:nil];
	Menu *vmm2 = [Menu menuWithItems: vm2,item2,nil];
	vmm2.position = ccp(2 * size.width / 3, 2 * size.height / 3);
	[self addChild:vmm2 z:1];
	
	MenuItemImage *vm3 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room3:)];
	Label *label3 = [Label labelWithString:@"ROOM3(0)" fontName:@"Marker Felt" fontSize:26];
	item3 = [MenuItemLabel itemWithLabel:label3 target:nil selector:nil];
	Menu *vmm3 = [Menu menuWithItems: vm3,item3,nil];
	vmm3.position = ccp(size.width / 3, size.height / 3);
	[self addChild:vmm3 z:1];
	
	MenuItemImage *vm4 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room4:)];
	Label *label4 = [Label labelWithString:@"ROOM4(0)" fontName:@"Marker Felt" fontSize:26];
	item4 = [MenuItemLabel itemWithLabel:label4 target:nil selector:nil];
	Menu *vmm4 = [Menu menuWithItems: vm4,item4,nil];
	vmm4.position = ccp(2 * size.width / 3, size.height / 3);
	[self addChild:vmm4 z:1];
	
	
	Label * refresh = [Label labelWithString:@"刷新" fontName:@"Marker Felt" fontSize:32];
	MenuItemLabel * refreshItem = [MenuItemLabel itemWithLabel:refresh target:self selector:@selector(refresh:)];
	Menu *vmmrefresh = [Menu menuWithItems: refreshItem,nil];
	vmmrefresh.position = ccp([refreshItem rect].size.width/2,[refreshItem rect].size.height/2);
	[self addChild:vmmrefresh z:1];
	
	//返回按钮
	MenuItemImage * returnImg = [MenuItemImage itemFromNormalImage:@"b_back.png" selectedImage:@"b_back_s.png" target:self selector:@selector(Return:)];
	CGRect pReturnImgRect = [returnImg rect];
	Menu * returnMenu = [Menu menuWithItems: returnImg, nil];
	returnMenu.position = cpv(0 + pReturnImgRect.size.width / 2, size.height - pReturnImgRect.size.height / 2);
	[self addChild:returnMenu z:1];
	
	//发送数据
	Label * pSendDate = [Label labelWithString:@"发送" fontName:@"Marker Felt" fontSize:32];
	MenuItemLabel * SendDateItem = [MenuItemLabel itemWithLabel:pSendDate target:self selector:@selector(sendDate:)];
	Menu *vmmSendDate = [Menu menuWithItems: SendDateItem,nil];
	vmmSendDate.position = ccp(200 + [SendDateItem rect].size.width/2,[SendDateItem rect].size.height/2);
	[self addChild:vmmSendDate z:1];
	
	return self;
}

- (void)layerReplaced
{
	
}

-(void) UpDateRoom:(nByte)eventCode :(NSDictionary*)photonEvent
{
	if(eventCode == 1 || eventCode == 2)
	{
		NSDictionary* eventData = nil;
		
		if(!(eventData = [photonEvent objectForKey:[KeyObject withByteValue:P_DATA]]))
			return;
		
		if([eventData count] > 0)
		{
			NSString * pRet = nil;
			
			pRet = (NSString*)[eventData objectForKey:[KeyObject withStringValue:@"demo_photon_game_room1"]];
			if(pRet)
			{
				NSLog(@"room1[%@]",pRet);
				m_nRoom1 = [pRet intValue];
			}
			else
			{
				m_nRoom1 = 0;
			}
			
			pRet = (NSString*)[eventData objectForKey:[KeyObject withStringValue:@"demo_photon_game_room2"]];
			if(pRet)
			{
				NSLog(@"room2[%@]",pRet);
				m_nRoom2 = [pRet intValue];
			}
			else
			{
				m_nRoom2 = 0;
			}
			
			pRet = (NSString*)[eventData objectForKey:[KeyObject withStringValue:@"demo_photon_game_room3"]];
			if(pRet)
			{
				NSLog(@"room3[%@]",pRet);
				m_nRoom3 = [pRet intValue];
			}
			else
			{
				m_nRoom3 = 0;
			}
			
			pRet = (NSString*)[eventData objectForKey:[KeyObject withStringValue:@"demo_photon_game_room4"]];
			if(pRet)
			{
				NSLog(@"room4[%@]",pRet);
				m_nRoom4 = [pRet intValue];
			}
			else
			{
				m_nRoom4 = 0;
			}
			
			[self UpDateRoomNum];
		}
	}
}

- (void) UpDateRoomNum
{
	[item1 setString:[NSString stringWithFormat:@"ROOM1(%d)",m_nRoom1]];
	[item2 setString:[NSString stringWithFormat:@"ROOM2(%d)",m_nRoom2]];
	[item3 setString:[NSString stringWithFormat:@"ROOM3(%d)",m_nRoom3]];
	[item4 setString:[NSString stringWithFormat:@"ROOM4(%d)",m_nRoom4]];
}

@end
