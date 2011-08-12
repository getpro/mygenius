#include "PhotonDemo.h"
#import  "Utils+Internal.h"

@implementation CPhotonLib

@synthesize m_strRoomID;

- (void) InitCPhotonLib
{
	m_currentState = SampleStarted;
	m_pLitePeer    = NULL;
}

- (void) dealloc
{
	if (m_pLitePeer)
		[m_pLitePeer release];
	
	[m_strRoomID release];
	
	[super dealloc];
}

- (int) InitLib:(id<PhotonListener>)listener
{
	NSLog(@"Initialize EG library");
	
	m_pLitePeer = [[LitePeer alloc] init:listener];
	
	m_currentState = PhotonPeerCreated;
	
	
	
	return SUCCESS;
}

#define URL_TEST_SERVER					L"172.18.66.36:5055"

#define URL_TEST_LITELOBBY_SERVER		L"172.18.66.36:4530"

- (int) CreateConnection
{
	//char* server = "udp.exitgames.com:5055";
	
	nByte * pAppName = (nByte *)"LiteLobby";
	
	//[m_pLitePeer Connect:[NSString stringWithUTF32String:URL_TEST_SERVER]];
	
	//BOOL pRet = [m_pLitePeer Connect:[NSString stringWithUTF8String:server]];
	
	[m_pLitePeer Connect:[NSString stringWithUTF32String:URL_TEST_SERVER]:pAppName];
	
	m_currentState = Connecting;
	
	return 0;
}

- (int) CloseConnection
{
	[m_pLitePeer Disconnect];
	m_currentState = Disconnecting;
	return 0;
}

-(void) ExchangeKeys
{
	[m_pLitePeer opExchangeKeysForEncryption];
}

- (void) DeriveSharedKey :(nByte*)serverPublicKey
{
	[m_pLitePeer deriveSharedKey:serverPublicKey];
}

- (short) Join:(NSString*)gameId
{
	
	//return [m_pLitePeer opJoin:gameId];
	
	//return [m_pLitePeer opJoin:@"chat_lobby"];
	
	//加入room
	
	NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:
						   
						   gameId ,[KeyObject withByteValue:P_GAMEID],
						   @"chat_lobby" ,[KeyObject withByteValue:((nByte)5)],
						   
						   
						   nil];
	
	return [m_pLitePeer opCustom:OPC_RT_JOIN : pDic :true];
	
}

- (void) EnterLobby
{
	//加入一个lobby
	
	NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:
						   
						   @"chat_lobby" ,[KeyObject withByteValue:P_GAMEID],
						   
						   nil];
	
	[m_pLitePeer opCustom:OPC_RT_JOIN : pDic :true];
	
}

- (void) EnterRoom
{
	
	if(m_strRoomID != nil)
	{
		short pJoinID = 0;
		pJoinID = [self Join:m_strRoomID];
		
		NSLog(@"pJoinID[%d]",pJoinID);
		
		if ( pJoinID == -1)
		{
			m_currentState = ErrorJoining;
		}
		
		NSLog(@"RoomID[%@]",m_strRoomID);
	}
	else
	{
		if ([self Join:[NSString stringWithUTF8String:"demo_photon_game"]] == -1)
			m_currentState = ErrorJoining;
		
		NSLog(@"RoomID[demo_photon_game]");
	}
	
	
}

- (short) Leave:(NSString*)gameId
{
	return [m_pLitePeer opLeave:gameId];
}

- (int) Run
{
	//char gameId[] = "demo_photon_game";
	//static short pRet;

	[m_pLitePeer service];
	switch (m_currentState)
	{
		case PhotonPeerCreated:
			NSLog(@"-------Connection-------");
			[self CreateConnection];
			break;
		case Connecting:
			// Waiting for callback function
			break;
		case ErrorConnecting:
			// Stop run cycle
			NSLog(@"ErrorConnecting");
			return -1;
			break;
		case Connected:
			NSLog(@"-------Connected-------");
			[self ExchangeKeys];
			m_currentState = KeysExchanging;
			break;
		case KeysExchanging:
			break;
		case KeysExchanged:
			NSLog(@"-------KeysExchanged-------");
			[self EnterLobby];
			m_currentState = EnterLobbying;
			break;
			
		case EnterLobbying:
			break;
			
		case EnterLobbyed:
			break;
			
		case Joining :
			// Waiting for callback function
			break;
		
		case GetProperying:
			break;

		case ErrorJoining:
			// Stop run cycle
			return -1;
			NSLog(@"ErrorJoining");
			break;
		case Joined :
			m_currentState = Joined;
			
			//NSLog(@"-------Joined-------");
			//通知当前的界面已经加入成功
			
			
			break;
		case Receiving:
			[self sendData];
			m_currentState = Sended;
			break;
		case Leaving:
			// Waiting for callback function
			break;
		case ErrorLeaving:
			// Stop run cycle
			return -1;
			NSLog(@"ErrorLeaving");
			break;
		case Left :
			m_currentState = Disconnecting;
			NSLog(@"-------DISCONNECTING-------");
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

- (void) sendData:(NSString*)pStr
{
	NSMutableDictionary* ev = [[NSMutableDictionary alloc] init];
	
	[ev setObject:pStr forKey:[KeyObject withStringValue:@"NSString"]];
	NSLog(@"send_string[%@]",pStr);
	
	[m_pLitePeer opRaiseEvent :true :ev :101];
	
	[ev release];
}


- (void) sendData
{
	NSMutableDictionary* ev = [[NSMutableDictionary alloc] init];

	// nByte key and int value:
	/*
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
	
	//int
	/*
	nByte POS_X = 101;
	int       x = 10;
	[ev setObject:[NSValue valueWithBytes:&x objCType:@encode(int)] forKey:[KeyObject withByteValue:POS_X]];
	NSLog(@"send_int[%d]",x);
	*/
	
	//float	
	//float x = 0.001f;
	//[ev setObject:[NSValue valueWithBytes:&x objCType:@encode(float)] forKey:[KeyObject withStringValue:@"float"]];
	//NSLog(@"send_float[%f]",x);
	
	//string
	NSString * x = @"测试9C";
	[ev setObject:x forKey:[KeyObject withStringValue:@"NSString"]];
	NSLog(@"send_string[%@]",x);
	
	
	[m_pLitePeer opRaiseEvent :false :ev :101];
	
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
	NSLog(@"-------LEAVING-------");
	if([self Leave:[NSString stringWithUTF8String:gameId]] == -1)
		m_currentState = ErrorLeaving;
}

- (void) GetProperties
{
	[m_pLitePeer opGetProperties];
}

@end