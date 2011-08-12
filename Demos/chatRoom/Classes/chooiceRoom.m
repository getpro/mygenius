    //
//  chooiceRoom.m
//  chatRoom
//
//  Created by Peteo on 11-8-7.
//  Copyright 2011 The9. All rights reserved.
//

#import "chooiceRoom.h"

#import "chatRoomAppDelegate.h"
#import "PhotonDemo.h"
#import "chat.h"

@implementation chooiceRoom

@synthesize button1,button2,button3,button4;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[chatRoomAppDelegate getAppDelegate].l.delegate = self;
	
	m_nRoom1 = 0;
	m_nRoom2 = 0;
	m_nRoom3 = 0;
	m_nRoom4 = 0;
	
	[self UpDateRoomNum];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pActivity release];
	
	[button1 release];
	[button2 release];
	[button3 release];
	[button4 release];
	
    [super dealloc];
}

-(void) JoinIntoRoom:(NSString *) pRoomNo
{
	States pStates = [[chatRoomAppDelegate getAppDelegate].m_PhotonLib GetState];
	
	if( pStates == Leaving || pStates == Connecting || pStates == Joining || pStates == EnterLobbying || pStates == KeysExchanging)
	{
		return;
	}
	
	[chatRoomAppDelegate getAppDelegate].m_PhotonLib.m_strRoomID = pRoomNo;
	
	[[chatRoomAppDelegate getAppDelegate].m_PhotonLib SetState:Joining];
	
	[[chatRoomAppDelegate getAppDelegate].m_PhotonLib EnterRoom];
	
	//连接和加入中⋯⋯⋯⋯⋯⋯
	UIView * pWaitView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
	
	[pWaitView setBackgroundColor:[UIColor blackColor]];
	[pWaitView setTag:1001];
	[pWaitView setAlpha:0.8f];
	
	[self.view addSubview:pWaitView];
	
	if(m_pActivity == nil)
	{
		m_pActivity = [[UIActivityIndicatorView alloc] 
							  initWithFrame:CGRectMake( 0, 0, 32.0f , 32.0f )] ;
	}
	
	[self.view addSubview:m_pActivity];
	
	m_pActivity.center = self.view.center;

	[m_pActivity startAnimating];
	
	[pWaitView release];
	
}

-(IBAction) room1
{
	[self JoinIntoRoom:@"demo_photon_game_room1"];
}

-(IBAction) room2
{
	[self JoinIntoRoom:@"demo_photon_game_room2"];
}

-(IBAction) room3
{
	[self JoinIntoRoom:@"demo_photon_game_room3"];
}

-(IBAction) room4
{
	[self JoinIntoRoom:@"demo_photon_game_room4"];
}

- (void) MyListenerEventAction:(nByte)eventCode :(NSDictionary*)photonEvent
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

- (void) MyListenerStatus:(int)statusCode
{
	
}

- (void) MyListenerOperationResult:(nByte)opCode :(int)returnCode :(NSDictionary*)returnValues :(short)invocID
{
	if(opCode == OPC_RT_JOIN) 
	{
		//推出wait界面
		[m_pActivity stopAnimating];
		
		UIView * temp = [self.view viewWithTag:1001];
		[temp removeFromSuperview];
		
		
		//进入聊天室
		//chat * pchat = [[chat alloc] init];
		
		//[self.navigationController pushViewController:[chatRoomAppDelegate getAppDelegate].m_pchat animated:YES];
		
		[chatRoomAppDelegate getAppDelegate].l.delegate = [chatRoomAppDelegate getAppDelegate].m_pchat;
		
		[[chatRoomAppDelegate getAppDelegate].window addSubview:[chatRoomAppDelegate getAppDelegate].m_pchat.view];
		
		//[pchat release];
		
	}
	else if(opCode == OPC_RT_LEAVE)
	{
		
	}
	
	else if(opCode == OPC_RT_GETPROPERTIES)
	{
		NSDictionary* eventData = nil;
		
		if(!(eventData = [returnValues objectForKey:[KeyObject withByteValue:P_DATA]]))
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

- (void) StartConnect
{
	//连接和加入中⋯⋯⋯⋯⋯⋯
	UIView * pWaitView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
	
	[pWaitView setBackgroundColor:[UIColor blackColor]];
	[pWaitView setTag:1001];
	[pWaitView setAlpha:0.8f];
	
	[self.view addSubview:pWaitView];
	
	if(m_pActivity == nil)
	{
		m_pActivity = [[UIActivityIndicatorView alloc] 
					   initWithFrame:CGRectMake( 0, 0, 32.0f , 32.0f )] ;
	}
	
	[self.view addSubview:m_pActivity];
	
	m_pActivity.center = self.view.center;
	
	[m_pActivity startAnimating];
	
	[pWaitView release];
}

- (void) FinishConnect
{
	//推出wait界面
	[m_pActivity stopAnimating];
	
	UIView * temp = [self.view viewWithTag:1001];
	[temp removeFromSuperview];
}


-(void) UpDateRoomNum
{
	[button1 setTitle:[NSString stringWithFormat:@"房间一(%d)",m_nRoom1] forState:UIControlStateNormal];
	[button2 setTitle:[NSString stringWithFormat:@"房间二(%d)",m_nRoom2] forState:UIControlStateNormal];
	[button3 setTitle:[NSString stringWithFormat:@"房间三(%d)",m_nRoom3] forState:UIControlStateNormal];
	[button4 setTitle:[NSString stringWithFormat:@"房间四(%d)",m_nRoom4] forState:UIControlStateNormal];
	
}

-(IBAction) reFresh
{
	NSLog(@"reFresh");
	
	//[[chatRoomAppDelegate getAppDelegate].m_PhotonLib GetProperties];
	
	[[chatRoomAppDelegate getAppDelegate].m_PhotonLib EnterLobby];
	
}

@end
