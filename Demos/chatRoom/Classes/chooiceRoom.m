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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[chatRoomAppDelegate getAppDelegate].l.delegate = self;
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
	
    [super dealloc];
}

-(void) JoinIntoRoom:(NSString *) pRoomNo
{
	
	if([[chatRoomAppDelegate getAppDelegate].m_PhotonLib GetState] != KeysExchanged)
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
		
		[[chatRoomAppDelegate getAppDelegate].window addSubview:[chatRoomAppDelegate getAppDelegate].m_pchat.view];
		
		//[pchat release];
		
	}
	else if(opCode == OPC_RT_LEAVE)
	{
		
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

@end
