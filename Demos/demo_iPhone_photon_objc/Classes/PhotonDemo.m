#include "PhotonDemo.h"
#import  "Utils+Internal.h"

@implementation CPhotonLib

- (void) InitCPhotonLib:(iTestTextView*)txtView
{
	textView = txtView;
	m_currentState = SampleStarted;
	m_pLitePeer = NULL;
}

- (void) dealloc
{
	if (m_pLitePeer)
		[m_pLitePeer release];
	[super dealloc];
}

- (int) InitLib:(id<PhotonListener>)listener
{
	[textView writeToTextView:@"Initialize EG library"];
	m_pLitePeer = [[LitePeer alloc] init:listener];
	m_currentState = PhotonPeerCreated;
	
	//m_pLitePeer.DebugOutputLevel = DEBUG_LEVEL_INFO;
	
	return SUCCESS;
}

#define URL_TEST_SERVER		L"172.18.66.36:5055"

- (int) CreateConnection
{
	//char* server = "udp.exitgames.com:5055";
	
	nByte * pAppName = (nByte *)"LiteLobby";
	
	//[m_pLitePeer Connect:[NSString stringWithUTF32String:URL_PHOTON_SERVER]];
	
	bool pRet = [m_pLitePeer Connect:[NSString stringWithUTF32String:URL_TEST_SERVER] : pAppName];
	
	m_currentState = Connecting;
	
	return 0;
}

- (int) CloseConnection
{
	[m_pLitePeer Disconnect];
	m_currentState = Disconnecting;
	return 0;
}

- (short) Join:(NSString*)gameId
{
	return [m_pLitePeer opJoin:gameId];
}

- (short) Leave:(NSString*)gameId
{
	return [m_pLitePeer opLeave:gameId];
}

- (int) Run
{
	//char gameId[] = "demo_photon_game";
	
	char gameId[] = "demo_the9_game_001";

	[m_pLitePeer service];
	switch (m_currentState)
	{
		case PhotonPeerCreated:
			[textView writeToTextView:@"-------CONNECTING-------"];
			[self CreateConnection];
			break;
		case Connecting:
			// Waiting for callback function
			break;
		case ErrorConnecting:
			// Stop run cycle
			[textView writeToTextView:@"ErrorConnecting"];
			return -1;
			break;
		case Connected:
			[textView writeToTextView:@"-------JOINING-------"];
			m_currentState = Joining;
			if ([self Join:[NSString stringWithUTF8String:gameId]] == -1)
				m_currentState = ErrorJoining;
			break;
		case Joining :
			// Waiting for callback function
			break;
		case ErrorJoining:
			// Stop run cycle
			return -1;
			[textView writeToTextView:@"ErrorJoining"];
			break;
		case Joined :
			m_currentState = Receiving;
			[textView writeToTextView:@"-------SENDING/RECEIVING DATA-------"];
			break;
		case Receiving:
			[self sendData];
			break;
		case Leaving:
			// Waiting for callback function
			break;
		case ErrorLeaving:
			// Stop run cycle
			return -1;
			[textView writeToTextView:@"ErrorLeaving"];
			break;
		case Left :
			m_currentState = Disconnecting;
			[textView writeToTextView:@"-------DISCONNECTING-------"];
			[self CloseConnection];
			break;
		case Disconnecting:
			// Waiting for callback function
			break;
		case Disconnected:
			// Stop run cycle
			return -1;
			break;
		default:
			break;
	}
	return 0;
}

- (void) SetState:(States) new_state
{
	m_currentState = new_state;
}

- (void) sendData
{
	NSMutableDictionary* ev = [[NSMutableDictionary alloc] init];

	/*
	// nByte key and int value:
	nByte POS_X = 101;
	int x = 10;
	[ev setObject:[NSValue valueWithBytes:&x objCType:@encode(int)] forKey:[KeyObject withByteValue:POS_X]];

	// NSString key and EGArray of float value:
	NSValue* valArray[10];
	float j=0.0f;
	for(int i=0; i<10; i++, j+=1.1f)
		valArray[i] = [NSValue valueWithBytes:&j objCType:@encode(float)];
	[ev setObject:[EGArray arrayWithObjects:valArray count:10] forKey:[KeyObject withStringValue:@"testKey"]];

	// nByte key and NSDictionary value:
	const nByte POS_Y = 102;
	const nByte key2 = 103;
	int y = 20;
	NSDictionary* testHash = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithBytes:&x objCType:@encode(int)], [KeyObject withByteValue:POS_X],
																		[NSValue valueWithBytes:&y objCType:@encode(int)], [KeyObject withByteValue:POS_Y],
																		nil];
	[ev setObject:testHash forKey:[KeyObject withByteValue:key2]];

	// NSString key and empty EGArray of int value:
	[ev setObject:[EGArray arrayWithCType:@encode(int)] forKey:[KeyObject withStringValue:@"emptyArray"]];

	// NSString key and multidimensional EGArray of NSDictionary*
    EGMutableArray* array = [EGMutableArray arrayWithType:NSStringFromClass([EGArray class])];
    for(int i=0; i<3; i++)
    {
		[array addObject:[EGMutableArray arrayWithType:NSStringFromClass([EGArray class])]];
		for(int j=0; j<3; j++)
		{
			[[array objectAtIndex:i] addObject:[EGMutableArray arrayWithType:NSStringFromClass([NSDictionary class])]];
			for(int k=0; k<3; k++)
				[[[array objectAtIndex:i] objectAtIndex:j] addObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", 100*i+10*j+k] forKey:[KeyObject withIntValue:100*i+10*j+k]]];
		}
    }
	[ev setObject:array forKey:[KeyObject withStringValue:@"array3d"]];
	
	//NSLog(@"%@",ev);

	*/
	
	//int	uniqueID = -225234623;
	
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
		
		//char * p = [pStr UTF8String];
		
		[ev setObject: pStr forKey:[KeyObject withByteValue:88]];
	}
	
	
	[m_pLitePeer opRaiseEvent :true :ev :101];
	
	[ev release];
}

- (States) GetState
{
	return m_currentState;
}

- (void) Stop
{
	char gameId[] = "demo_photon_game";
	m_currentState = Leaving;
	[textView writeToTextView:@"-------LEAVING-------"];
	if([self Leave:[NSString stringWithUTF8String:gameId]] == -1)
		m_currentState = ErrorLeaving;
}

@end