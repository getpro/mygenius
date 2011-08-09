//
//  demo_iPhone_photon_objcAppDelegate.m
//  demo_iPhone_photon_objc
//
//  Created by Pedro Galystyan on 9/3/08.
//  Copyright home 2008. All rights reserved.
//

#import "demo_iPhone_Photon_objCAppDelegate.h"
#import "demo_iPhone_Photon_objCViewController.h"

@implementation demo_iPhone_photon_objcAppDelegate

@synthesize window;
@synthesize viewController;


- (void) action
{
	if(bRun)
	{
		[m_PhotonLib Stop];
		bRun = false;
	}
}

- (void) onTime:(NSTimer*)Timer
{
	[m_PhotonLib Run];
}

- (void)applicationDidFinishLaunching:(UIApplication*)application
{	
	/*
	//test
	int	uniqueID = 2;
	
	static unsigned char networkPacket[MAX_PACKET_SIZE];
	const unsigned int packetHeaderSize = 3 * sizeof(int); // we have two "ints" for our header	
	
	if(4 < (MAX_PACKET_SIZE - packetHeaderSize)) 
	{
		int *pIntData = (int *)&networkPacket[0];
		// header info
		pIntData[0] = 1;
		pIntData[1] = 1;
		pIntData[2] = 1;
		
		// copy data in after the header
		memcpy( &networkPacket[packetHeaderSize], &uniqueID, 4 );
		
		NSData * packet = [NSData dataWithBytes: networkPacket length: (4+packetHeaderSize)];
		
		
		NSString * pStr = [[NSString alloc]  initWithBytes:[packet bytes] 
													length:[packet length] encoding: NSUTF8StringEncoding]; 
		
		
		//NSString * pStr = [NSString stringWithUTF8String:[packet bytes]];
		
		int pLength = [pStr length];
		
		char * p = [pStr UTF8String];
		
		NSLog(@"[%d]",pLength);

	}
	
	*/
	
	
	
	
	
	
	
	UIButton* button1 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
	button1.frame = CGRectMake(0, 0, 320, 24);
	[button1 setTitle:@"Stop" forState:UIControlStateNormal];
	[button1 addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
	[viewController.view addSubview:button1];

	textView = [[iTestTextView alloc] initWithFrame:CGRectMake(0, 24, 320, 480 - 24)];
	[viewController.view addSubview:textView];

	m_PhotonLib = [CPhotonLib alloc];
	[m_PhotonLib InitCPhotonLib :textView];
	l = [Listener alloc];
	[l InitListener:m_PhotonLib :textView];
	[m_PhotonLib InitLib:l];

	m_timer=[[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTime:) userInfo:nil repeats:YES]retain];

	[textView writeToTextView:@"- -Pres any key for quit- ------------------"];

	// Override point for customization after app launch
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];

	bRun = true;
}


- (void)dealloc
{
    [viewController release];
	[window release];
	[super dealloc];
}


@end