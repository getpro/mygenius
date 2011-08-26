//
//  ChoiceRoom.m
//  punchball
//
//  Created by Peteo on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChoiceRoom.h"
#import "Common.h"
#import "AppController.h"

#include "LitePeer.h"

@implementation ChoiceRoom

-(void)SetUIControlHiden:(BOOL)pHiden
{
	if(m_pChatList)
	{
		[m_pChatList setHidden:pHiden];
	}
	if(nameField)
	{
		[nameField   setHidden:pHiden];
	}
}

-(void)onEnter
{
	// 节点调用init方法以后将会调用此方法
	// 如果使用了CCTransitionScene,将会在过渡效果开始以后调用此方法
	[super onEnter];
	NSLog(@"onEnter");
}

-(void)onEnterTransitionDidFinish
{
	// 调用onEnter以后将会调用此方法
	// 如果使用了CCTransitionScene,将会在过渡效果结束以后调用此方法
	[super onEnterTransitionDidFinish];
	NSLog(@"onEnterTransitionDidFinish");
	[self SetUIControlHiden:NO];
}

-(void)onExit
{
	// 节点调用dealloc方法之前将会调用此方法 
	// 如果使用了CCTransitionScene,将会在过渡效果结束以后调用此方法
	[super onExit];
	NSLog(@"onExit");
}

-(BOOL)checkConnected
{
	AppController * app = [[UIApplication sharedApplication] delegate];
	
	
	if(app.link.b_IsWaiting)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示！" message:@"正在连接中，请稍等!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		
		[alert show];
		
		[alert release];
		
		return NO;
	}
	else
	{
		return YES;
	}
	
}

-(void) room1: (id) sender
{	
	if(m_nRoom1 >= 2)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示！" message:@"该房间已满!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		
		[alert show];
		
		[alert release];
		
		return;
	}
	
	if(![self checkConnected])
	{
		return;
	}
	
	[self SetUIControlHiden:YES];
	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room1];
	}
}

-(void) room2: (id) sender
{	
	if(m_nRoom2 >= 2)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示！" message:@"该房间已满!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		
		[alert show];
		
		[alert release];
		
		return;
	}
	
	if(![self checkConnected])
	{
		return;
	}
	
	[self SetUIControlHiden:YES];
	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room2];
	}
}

-(void) room3: (id) sender
{	
	if(m_nRoom3 >= 2)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示！" message:@"该房间已满!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		
		[alert show];
		
		[alert release];
		
		return;
	}
	
	if(![self checkConnected])
	{
		return;
	}
	
	[self SetUIControlHiden:YES];
	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room3];
	}
}

-(void) room4: (id) sender
{	
	if(m_nRoom4 >= 2)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示！" message:@"该房间已满!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		
		[alert show];
		
		[alert release];
		
		return;
	}
	
	if(![self checkConnected])
	{
		return;
	}
	
	[self SetUIControlHiden:YES];
	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Room4];
	}
}

-(void) refresh: (id) sender
{
	if(![self checkConnected])
	{
		return;
	}
	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_ReFresh];
	}
}

-(void) Return: (id) sender
{	
	[self SetUIControlHiden:YES];
	
	if(delegate)
	{
		[delegate EnterRoom:EEnterRoomSelect_Return];
	}
}

-(void) sendDate: (id) sender
{	
	[nameField resignFirstResponder];
	
	if(![self checkConnected])
	{
		return;
	}
	
	if(nameField.text && ![nameField.text isEqual:@""])
	{
		[self AddChatList:nameField.text];
		
		if(delegate)
		{
			[delegate EnterRoomSendDate:nameField.text];
		}
	}
}

- (id) init: (id<ChoiceRoomDelegate>) _delegate window:(UIWindow*)_window
{
	[super init];
	
	delegate = _delegate;
	
	CGSize size = [[Director sharedDirector] winSize];
	
	//4个房间的Item
	
	MenuItemImage *vm1 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room1:)];
	Label *label1 = [Label labelWithString:@"ROOM1(0)" fontName:@"Marker Felt" fontSize:26];
	item1 = [MenuItemLabel itemWithLabel:label1 target:nil selector:nil];
	Menu *vmm1 = [Menu menuWithItems: vm1,item1,nil];
	vmm1.position = ccp(size.width / 3 - 80, 2 * size.height / 3);
	[self addChild:vmm1 z:1];
	
	
	MenuItemImage *vm2 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room2:)];
	Label *label2 = [Label labelWithString:@"ROOM2(0)" fontName:@"Marker Felt" fontSize:26];
	item2 = [MenuItemLabel itemWithLabel:label2 target:nil selector:nil];
	Menu *vmm2 = [Menu menuWithItems: vm2,item2,nil];
	vmm2.position = ccp(2 * size.width / 3 - 80, 2 * size.height / 3);
	[self addChild:vmm2 z:1];
	
	MenuItemImage *vm3 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room3:)];
	Label *label3 = [Label labelWithString:@"ROOM3(0)" fontName:@"Marker Felt" fontSize:26];
	item3 = [MenuItemLabel itemWithLabel:label3 target:nil selector:nil];
	Menu *vmm3 = [Menu menuWithItems: vm3,item3,nil];
	vmm3.position = ccp(size.width / 3 - 80, size.height / 3);
	[self addChild:vmm3 z:1];
	
	MenuItemImage *vm4 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room4:)];
	Label *label4 = [Label labelWithString:@"ROOM4(0)" fontName:@"Marker Felt" fontSize:26];
	item4 = [MenuItemLabel itemWithLabel:label4 target:nil selector:nil];
	Menu *vmm4 = [Menu menuWithItems: vm4,item4,nil];
	vmm4.position = ccp(2 * size.width / 3 - 80, size.height / 3);
	[self addChild:vmm4 z:1];
	
	
	Label * refresh = [Label labelWithString:@"刷新" fontName:@"Marker Felt" fontSize:32];
	MenuItemLabel * refreshItem = [MenuItemLabel itemWithLabel:refresh target:self selector:@selector(refresh:)];
	Menu *vmmrefresh = [Menu menuWithItems: refreshItem,nil];
	vmmrefresh.position = ccp(200 + [refreshItem rect].size.width/2,[refreshItem rect].size.height/2 + 15);
	[self addChild:vmmrefresh z:1];
	
	//返回按钮
	MenuItemImage * returnImg = [MenuItemImage itemFromNormalImage:@"b_back.png" selectedImage:@"b_back_s.png" target:self selector:@selector(Return:)];
	CGRect pReturnImgRect = [returnImg rect];
	Menu * returnMenu = [Menu menuWithItems: returnImg, nil];
	returnMenu.position = cpv(0 + pReturnImgRect.size.width / 2, pReturnImgRect.size.height / 2);
	[self addChild:returnMenu z:1];
	
	//发送数据
	Label * pSendDate = [Label labelWithString:@"发送" fontName:@"Marker Felt" fontSize:32];
	MenuItemLabel * SendDateItem = [MenuItemLabel itemWithLabel:pSendDate target:self selector:@selector(sendDate:)];
	Menu *vmmSendDate = [Menu menuWithItems: SendDateItem,nil];
	vmmSendDate.position = ccp(240 + [SendDateItem rect].size.width/2,size.height - [SendDateItem rect].size.height/2 - 15);
	[self addChild:vmmSendDate z:1];
	
	window = _window;
	
	//输入框
	nameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 230, 30)];
	nameField.font = [UIFont fontWithName:@"Marker Felt" size:24];
	nameField.transform = CGAffineTransformMakeRotation(90 * M_PI /180.0f);
	nameField.frame = CGRectMake(275,5,30,230);
	nameField.borderStyle = UITextBorderStyleLine;
	nameField.returnKeyType = UIReturnKeyDone;
	nameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
	nameField.autocorrectionType = UITextAutocorrectionTypeNo;
	nameField.keyboardType = UIKeyboardTypeAlphabet;
	nameField.textColor = [UIColor whiteColor];
	nameField.delegate = self;
	nameField.tag = 1001;
	[window addSubview:nameField];
	
	
	//聊天滚动内容
	m_pChatList = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,160.0f,320.0f)];
	m_pChatList.backgroundColor = [UIColor clearColor];
	
	//m_pChatList.transform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(90.0f),0.0, 0.0);
	m_pChatList.transform = CGAffineTransformMakeRotation(90 * M_PI /180.0f);
	
	m_pChatList.frame = CGRectMake(0, 320, 320, 160);
	
	//NSLog(@"[%f][%f][%f][%f]",m_pChatList.frame.origin.x,m_pChatList.frame.origin.y,m_pChatList.frame.size.width,m_pChatList.frame.size.height);
	
	//m_pChatList.delegate = self;
	m_pChatList.tag = 1002;
	[window addSubview:m_pChatList];
	
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
	else if(eventCode == EV_CHATDATA)
	{
		NSDictionary * eventData = nil;
		
		if(!(eventData=[photonEvent objectForKey:[KeyObject withByteValue:P_DATA]]))
			return;
		
		NSLog(@"get_string[%@]",[eventData objectForKey:[KeyObject withStringValue:@"NSString"]]);
		
		[self AddChatList:[eventData objectForKey:[KeyObject withStringValue:@"NSString"]]];
		
	}
}

- (void) UpDateRoomNum
{
	[item1 setString:[NSString stringWithFormat:@"ROOM1(%d)",m_nRoom1]];
	[item2 setString:[NSString stringWithFormat:@"ROOM2(%d)",m_nRoom2]];
	[item3 setString:[NSString stringWithFormat:@"ROOM3(%d)",m_nRoom3]];
	[item4 setString:[NSString stringWithFormat:@"ROOM4(%d)",m_nRoom4]];
}

- (void) dealloc
{
	[m_pChatList removeFromSuperview];
	[nameField   removeFromSuperview];
	
	[m_pChatList release];
	[nameField   release];
	
	[super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
	[nameField resignFirstResponder];
	return YES;
}

- (void) AddChatList:(NSString*)pStr
{
	if(pStr == nil)
	{
		return;
	}
		
	UILabel * pUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, m_pChatList.contentSize.height, 160, 24)];
	pUILabel.backgroundColor = [UIColor clearColor];
	pUILabel.font = [UIFont fontWithName:@"Marker Felt" size:24];
	pUILabel.textColor = [UIColor whiteColor];
	pUILabel.text	   = pStr;
	pUILabel.numberOfLines = 0;
	
	//多行处理
	CGRect frame = CGRectMake(0.0,0.0,pUILabel.frame.size.width, 1000.0);
	CGSize calcSize = [pStr sizeWithFont:pUILabel.font
					   constrainedToSize:frame.size
						   lineBreakMode:UILineBreakModeWordWrap];
	
	//NSLog(@"calcSize[%f][%f]",calcSize.width,calcSize.height);
	
	pUILabel.frame  = CGRectMake(0,m_pChatList.contentSize.height, 160,calcSize.height);
	
	[m_pChatList addSubview:pUILabel];
	
	[m_pChatList setContentSize:CGSizeMake(m_pChatList.contentSize.width,
										   m_pChatList.contentSize.height + pUILabel.frame.size.height)];
	
	
	
	if(m_pChatList.contentSize.height > 320)
	{
		[m_pChatList setContentOffset:CGPointMake(0, m_pChatList.contentSize.height - 180)];
	}
	
	
	
	[pUILabel release];
}

@end
