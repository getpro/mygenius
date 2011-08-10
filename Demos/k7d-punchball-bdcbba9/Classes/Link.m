/*
 Copyright 2009 Kaspars Dancis
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "Link.h"
#import "MultiPlayerGame.h"


typedef enum {
	StateDisconnected,
	StatePicker,
	StateReset,
	StateCointoss,
	StateConnected,
	StateReconnect
} LinkStates;

@implementation Link

@synthesize state, role, name, sessionID, peerID, peerName, connectionAlert, dataReceiver, uniqueID, peerUniqueID;



- (id)initWithID:(NSString*)_sessionID name:(NSString*)_name delegate:(id<LinkDelegate>)_delegate {
	[super init];
	
	self.sessionID = _sessionID;
	self.name = _name;
	
	delegate = _delegate;
	
	role = RoleServer;
	packetNumber = 0;
	//session = nil;
	peerID = nil;
	
	NSString *uid = [[UIDevice currentDevice] uniqueIdentifier];
	uniqueID = [uid hash];
	
	self.state = StateDisconnected;
	
	
	//Photon
	
	m_pLitePeer    = [[LitePeer alloc] init:self];
	m_currentState = statePhotonPeerCreated;
	
	
	return self;
}



- (void)dealloc 
{
	if(self.connectionAlert && self.connectionAlert.visible) 
	{
		[self.connectionAlert dismissWithClickedButtonIndex:-1 animated:NO];
	}
	self.connectionAlert = nil;
	
	[self invalidateSession];
	
	self.peerName = nil;	
	self.peerID = nil;
	self.name = nil;
	self.sessionID = nil;
	
	//Photon
	[m_pLitePeer release];
	[m_timer     release];
	
	[super dealloc];
}



- (void)invalidateSession 
{
	/*
	if(session != nil) 
	{
		self.dataReceiver = nil;
		[session disconnectFromAllPeers]; 
		session.available = NO; 
		[session setDataReceiveHandler: nil withContext: NULL]; 
		session.delegate = nil; 
		self.session = nil;
	}
	*/
}



- (void)setGameState:(NSInteger)newState 
{
	if(newState == StateDisconnected) 
	{
		/*
		if(self.session) 
		{
			// invalidate session and release it.
			[self invalidateSession];
		}
		*/
	}
	
	state = newState;
}

-(void) onTime:(NSTimer*)Timer
{
	[self Run];
}

-(void)startPicker 
{
	self.state = StatePicker;
	
	NSLog(@"startPicker");
	
	m_timer = [[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTime:) userInfo:nil repeats:YES]retain];
	
}


/*
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker 
{ 
	NSLog(@" >>> peerPickerControllerDidCancel");

	// Peer Picker automatically dismisses on user cancel. No need to programmatically dismiss.
    
	// autorelease the picker. 
	picker.delegate = nil;
    [picker autorelease]; 
	
	// invalidate and release game session if one is around.
	if(self.session != nil)	{
		[self invalidateSession];
	}

	state = StateDisconnected;
	[delegate linkDisconnected];
} 
*/




- (void)cointoss 
{
	NSLog(@" >>> cointoss");
	
	[self sendPacket:PACKET_COINTOSS objectIndex:0 data:&uniqueID length:sizeof(int) reliable:YES];
}



- (void)reset {
	self.dataReceiver = nil;
	self.state = StateReset;
}



- (void)resync 
{
	[self cointoss];
	
	if (self.state == StateReset) 
	{
		//NSString *message = [NSString stringWithFormat:@"Waiting for %@.", [session displayNameForPeer:peerID]];
		
		NSString    *message = [NSString stringWithFormat:@"Waiting for"];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Replay" message:message delegate:self cancelButtonTitle:@"End Game" otherButtonTitles:nil];
		
		self.connectionAlert = alert;
		[alert show];
		[alert release];
		state = StateCointoss;	
	}
	else 
	{
		// cointoss packet already received
		[delegate linkConnected:role];
	}
	
}


- (void)sendPacket:(int)packetID objectIndex:(int)objectIndex data:(void *)data length:(int)length reliable:(bool)howtosend 
{	
	// the packet we'll send is resued
	//static unsigned char networkPacket[MAX_PACKET_SIZE];
	const unsigned int packetHeaderSize = 3 * sizeof(int); // we have two "ints" for our header	
	
	if(length < (MAX_PACKET_SIZE - packetHeaderSize)) 
	{ 
		// our networkPacket buffer size minus the size of the header info
		//int *pIntData = (int *)&networkPacket[0];
		
		// header info
		//pIntData[0] = packetNumber++;
		//pIntData[1] = packetID;
		//pIntData[2] = objectIndex;
		
		int pIntData_packetNumber = packetNumber++;
		int pIntData_packetID	  = packetID;
		int pIntData_objectIndex  = objectIndex;
		
		NSDictionary* pHash = nil;
		
		switch( packetID ) 
		{
			case PACKET_COINTOSS:
			{
				int * puniqueID = (int*)data;
				
				pHash = [NSDictionary dictionaryWithObjectsAndKeys:
						 
						 [NSValue valueWithBytes:&pIntData_packetNumber objCType:@encode(int)], [KeyObject withByteValue:POS_PacketNumber],
						 [NSValue valueWithBytes:&pIntData_packetID objCType:@encode(int)], [KeyObject withByteValue:POS_PacketID],
						 [NSValue valueWithBytes:&pIntData_objectIndex objCType:@encode(int)], [KeyObject withByteValue:POS_ObjectIndex],
						 
						 [NSValue valueWithBytes:puniqueID objCType:@encode(int)], [KeyObject withByteValue:POS_PACKET_COINTOSS],
						 
						 nil];
				
				break;
			}
			case NETWORK_PUNCH: 
			{
				CGPoint *aim = (CGPoint*)data;
				
				float aim_x = (*aim).x;
				float aim_y = (*aim).y;
				
				NSDictionary* pAimHash = [NSDictionary dictionaryWithObjectsAndKeys:
									   
									   [NSValue valueWithBytes:&aim_x objCType:@encode(float)], [KeyObject withByteValue:POS_CGPoint_X],
									   [NSValue valueWithBytes:&aim_y objCType:@encode(float)], [KeyObject withByteValue:POS_CGPoint_Y],
									   
									   nil];
				
				pHash = [NSDictionary dictionaryWithObjectsAndKeys:
						 
						 [NSValue valueWithBytes:&pIntData_packetNumber objCType:@encode(int)], [KeyObject withByteValue:POS_PacketNumber],
						 [NSValue valueWithBytes:&pIntData_packetID objCType:@encode(int)], [KeyObject withByteValue:POS_PacketID],
						 [NSValue valueWithBytes:&pIntData_objectIndex objCType:@encode(int)], [KeyObject withByteValue:POS_ObjectIndex],
						 
						 pAimHash,[KeyObject withByteValue:POS_NETWORK_PUNCH],
						 
						 nil];
				
				break;
			}
			case NETWORK_TURN: 
			{
				CGPoint *aim = (CGPoint*)data;
				
				float aim_x = (*aim).x;
				float aim_y = (*aim).y;
				
				NSDictionary* pAimHash = [NSDictionary dictionaryWithObjectsAndKeys:
										  
										  [NSValue valueWithBytes:&aim_x objCType:@encode(float)], [KeyObject withByteValue:POS_CGPoint_X],
										  [NSValue valueWithBytes:&aim_y objCType:@encode(float)], [KeyObject withByteValue:POS_CGPoint_Y],
										  
										  nil];
				
				pHash = [NSDictionary dictionaryWithObjectsAndKeys:
						 
						 [NSValue valueWithBytes:&pIntData_packetNumber objCType:@encode(int)], [KeyObject withByteValue:POS_PacketNumber],
						 [NSValue valueWithBytes:&pIntData_packetID objCType:@encode(int)], [KeyObject withByteValue:POS_PacketID],
						 [NSValue valueWithBytes:&pIntData_objectIndex objCType:@encode(int)], [KeyObject withByteValue:POS_ObjectIndex],
						 
						 pAimHash,[KeyObject withByteValue:POS_NETWORK_TURN],
						 
						 nil];
				
				break;
			}
			case NETWORK_POS: 
			{
				PlayerInfo *pi = (PlayerInfo*)data;
				
				float playerInfo_headP_X = pi->headP.x;
				float playerInfo_headP_Y = pi->headP.y;
				
				float playerInfo_headV_X = pi->headV.x;
				float playerInfo_headV_Y = pi->headV.y;
				
				float playerInfo_headA	 = pi->headA;
				
				float playerInfo_gloveV_X= pi->gloveV.x;
				float playerInfo_gloveV_Y= pi->gloveV.y;
				
				float playerInfo_opponentHealth = pi->opponentHealth;
				
				NSDictionary* pPlayerInfoHash = [NSDictionary dictionaryWithObjectsAndKeys:
										  
										  [NSValue valueWithBytes:&playerInfo_headP_X objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_headP_X],
										  [NSValue valueWithBytes:&playerInfo_headP_Y objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_headP_Y],
												 
										  [NSValue valueWithBytes:&playerInfo_headV_X objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_headV_X],
										  [NSValue valueWithBytes:&playerInfo_headV_Y objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_headV_Y],
												 
										  [NSValue valueWithBytes:&playerInfo_headA objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_headA],
												 
										  [NSValue valueWithBytes:&playerInfo_gloveV_X objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_gloveV_X],
										  [NSValue valueWithBytes:&playerInfo_gloveV_Y objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_gloveV_Y],
												 
									      [NSValue valueWithBytes:&playerInfo_opponentHealth objCType:@encode(float)], [KeyObject withByteValue:POS_PlayerInfo_opponentHealth],
										
										  nil];
				


				pHash = [NSDictionary dictionaryWithObjectsAndKeys:
						 
						 [NSValue valueWithBytes:&pIntData_packetNumber objCType:@encode(int)], [KeyObject withByteValue:POS_PacketNumber],
						 [NSValue valueWithBytes:&pIntData_packetID objCType:@encode(int)], [KeyObject withByteValue:POS_PacketID],
						 [NSValue valueWithBytes:&pIntData_objectIndex objCType:@encode(int)], [KeyObject withByteValue:POS_ObjectIndex],
						 
						 pPlayerInfoHash,[KeyObject withByteValue:POS_NETWORK_POS],
						 
						 nil];
				
				break;
			}
				
			case NETWORK_SLIDE: 
			{
				SlideInfo *slideInfo = (SlideInfo*)data;
				
				float slideToX = slideInfo->slideTo.x;
				float slideToY = slideInfo->slideTo.y;
				bool  pfinalSlide = slideInfo->finalSlide;
				
				NSDictionary* pslideInfoHash = [NSDictionary dictionaryWithObjectsAndKeys:
										  
										  [NSValue valueWithBytes:&slideToX    objCType:@encode(float)], [KeyObject withByteValue:POS_SlideTo_X],
										  [NSValue valueWithBytes:&slideToY    objCType:@encode(float)], [KeyObject withByteValue:POS_SlideTo_Y],
										  [NSValue valueWithBytes:&pfinalSlide objCType:@encode(bool)],  [KeyObject withByteValue:POS_SlideTo_FinalSlide],
												
										  nil];
				
				pHash = [NSDictionary dictionaryWithObjectsAndKeys:
						 
						 [NSValue valueWithBytes:&pIntData_packetNumber objCType:@encode(int)], [KeyObject withByteValue:POS_PacketNumber],
						 [NSValue valueWithBytes:&pIntData_packetID objCType:@encode(int)], [KeyObject withByteValue:POS_PacketID],
						 [NSValue valueWithBytes:&pIntData_objectIndex objCType:@encode(int)], [KeyObject withByteValue:POS_ObjectIndex],
						 
						 pslideInfoHash,[KeyObject withByteValue:POS_NETWORK_SLIDE],
						 
						 nil];
				
				break;
			}
				
			default:
				break;
		}
		
		
		// copy data in after the header
		//memcpy( &networkPacket[packetHeaderSize], data, length ); 
		
		//NSData * packet = [NSData dataWithBytes: networkPacket length: (length+packetHeaderSize)];
		
		//NSString * pStr = [NSString stringWithUTF8String:[packet bytes]];
		
		NSMutableDictionary * ev = [[NSMutableDictionary alloc] init];
		
		if(pHash)
		{
			[ev setObject: pHash forKey:[KeyObject withByteValue:STATUS_DATA]];
		}
		
		if(howtosend == YES)
		{
			//[session sendDataToAllPeers:packet withDataMode:GKSendDataReliable error:nil];			
			[m_pLitePeer opRaiseEvent :true  :ev :EV_DATA];
		} 
		else 
		{
			//[session sendDataToAllPeers:packet withDataMode:GKSendDataUnreliable error:nil];
			[m_pLitePeer opRaiseEvent :false :ev :EV_DATA];
		}
		
		[ev   release];
		
	}
}


// Called when an alert button is tapped.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	// 0 index is "End Game" button
	if(buttonIndex == 0) 
	{
		if (self.state == StateCointoss) 
		{
			[delegate linkDisconnected];
		}
		self.state = StateDisconnected;
	}
}


//Photon
//Methods

- (void) PhotonPeerOperationResult:(nByte)opCode :(int)returnCode :(NSMutableDictionary*)returnValues :(short)invocID
{ 
	NSLog(@"OperationResult called, opCode = [%d] , returnCode = [%d] invocID = [%d]",opCode, returnCode, invocID);
	
	NSLog(@"%@", [Utils hashToString:returnValues :true]);
	
	switch(opCode)
	{
		case OPC_RT_JOIN:
			m_currentState = stateJoined;
			break;
		case OPC_RT_LEAVE:
			m_currentState = stateLeft;
			break;
		case OPC_RT_RAISE_EV:
			break;
		case OPC_RT_EXCHANGEKEYSFORENCRYPTION:
			[m_pLitePeer deriveSharedKey:(nByte*)((EGArray*)[returnValues objectForKey:[KeyObject withByteValue:P_SERVER_KEY]]).CArray];
			m_currentState = stateKeysExchanged;
			break;
		default:
			break;
	}
}

- (void) PhotonPeerStatus:(int)statusCode
{
	switch(statusCode)
	{
		case SC_CONNECT:
			m_currentState = stateConnected;
			NSLog(@"-------CONNECTED-------");
			break;
		case SC_DISCONNECT:
			m_currentState = stateDisconnected;
			NSLog(@"-------DISCONNECTED-------");
			
			if(self.state == StatePicker) {
				return;				// only do stuff if we're in multiplayer, otherwise it is probably for Picker
			}
			
			//if(_state == GKPeerStateDisconnected) 
			{
				// We've been disconnected from the other peer.
				
				// Update user alert or throw alert if it isn't already up
				
				NSString *message = [NSString stringWithFormat:@"The peer has disconnected." /* , [_session displayNameForPeer:_peerID] */ ];
				if ((self.state == StateCointoss) && self.connectionAlert && self.connectionAlert.visible) 
				{
					self.connectionAlert.message = message;
				}
				else 
				{
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lost Connection" message:message delegate:self cancelButtonTitle:@"End Game" otherButtonTitles:nil];
					self.connectionAlert = alert;
					[alert show];
					[alert release];
				}
				
				self.state = StateDisconnected;
				
				[delegate linkDisconnected];
			}
			
			
			break;
		case SC_EXCEPTION:
			break;
		default:
			break;
	}
}

- (void) PhotonPeerEventAction:(nByte)eventCode :(NSMutableDictionary*)photonEvent
{
	NSLog(@"-----Listener::EventAction called, eventCode = %d", eventCode);
	
	// you do not receive your own events, so you must start 2 clients, to receive the events, you sent
	
	if(!photonEvent)
		return;
	
	NSLog(@"%@", [Utils hashToString:photonEvent :true]);
	
	NSMutableDictionary * eventData = nil;
	
	/*
	if(eventCode == EV_MOVE)
	{
		receivedCount++;
		int n = 0;
		[(NSValue*)[photonEvent objectForKey:[KeyObject withByteValue:P_ACTORNR]] getValue:&n];
		char x = 0;
		[(NSValue*)[eventData objectForKey:[KeyObject withByteValue:STATUS_PLAYER_POS_X]] getValue:&x];
		char y = 0;
		[(NSValue*)[eventData objectForKey:[KeyObject withByteValue:STATUS_PLAYER_POS_Y]] getValue:&y];
		
		for(int i=0; i<MAXPLAYERS; i++)
			if(mPlayer[i].Number == n)
				[mPlayer[i] move :x :y];
	}
	else if(eventCode == EV_PLAYER_INFO)
	{
		int n = 0;
		[(NSValue*)[photonEvent objectForKey:[KeyObject withByteValue:P_ACTORNR]] getValue:&n];
		NSString* name = (NSString*)[eventData objectForKey:[KeyObject withByteValue:STATUS_PLAYER_NAME]];
		int color = 0;
		[(NSValue*)[eventData objectForKey:[KeyObject withByteValue:STATUS_PLAYER_COLOR]] getValue:&color];
		
		for(int i=0; i<MAXPLAYERS; i++)
			if(mPlayer[i].Number == n)
				[mPlayer[i] setInfo :name :color];
	}
	else
	
	*/
	 
	if(eventCode == EV_RT_JOIN)
	{
		int n = 0;
		
		[(NSValue*)[photonEvent objectForKey:[KeyObject withByteValue:P_ACTORNR]] getValue:&n];
		
		NSArray* actors = (NSArray*)[photonEvent objectForKey:[KeyObject withByteValue:P_ACTORS]];
		
		//int amountOfActors = [actors count];
		
		NSLog(@"P_ACTORNR[%d]",n);
		
		if(n == 1)
		{
			//自己创建房间
			
		}
		else if(n == 2)
		{
			int pPeerID = 0;
			
			[(NSValue*)[actors objectAtIndex:1] getValue:&pPeerID];
			
			//peer加入
			// Remember the current peer.
			self.peerID = [NSString stringWithFormat:@"%d",pPeerID];
			
			self.peerName = @"Peer";
			
			// Start Multiplayer game by entering a cointoss state to determine who is server/client.
			self.state = StateCointoss;
			[NSTimer scheduledTimerWithTimeInterval:0.033 target:self selector:@selector(cointoss) userInfo:nil repeats:NO];
		}
		
		
		
		
		/*
		if(mPlayer[0].Number == -1) // if local player is the joining player
		{
			mPlayer[0].Number = n;
			for(int i=0; i<amountOfActors; i++)
			{
				int temp;
				[[actors objectAtIndex:i] getValue:&temp];
				if (temp != mPlayer[0].Number) // for every existing player except local player
				{
					mPlayer[mGame.CurrentPlayers].Number = temp;
					[mGame increaseCurrentPlayers];
				}
			}
		}
		else
		{
			mPlayer[mGame.CurrentPlayers].Number = n;
			[mGame increaseCurrentPlayers];
		}
		[self sendPlayerInfo:true :mPlayer[0].Name :mPlayer[0].Color];
		 
		*/
		
	}
	else if(eventCode == EV_RT_LEAVE)
	{
		int n = 0;
		[(NSValue*)[photonEvent objectForKey:[KeyObject withByteValue:P_ACTORNR]] getValue:&n];
		
		/*
		int current = mGame.CurrentPlayers;
		for(int i=0; i<current; i++)
		{
			if (mPlayer[i].Number == n)
			{
				if(i != current-1)
					mPlayer[i] = mPlayer[current-1];
				[mGame decreaseCurrentPlayers];
				current = 0;
			}
		}
		*/
	}
	else if(eventCode == EV_DATA)
	{
		// custom event dat is inside an inner hash
		if(!(eventData = [photonEvent objectForKey:[KeyObject withByteValue:P_DATA]]))
			return;
		
		//const unsigned int packetHeaderSize = 3 * sizeof(int); // we have two "ints" for our header	
		
		static int lastPacketTime     = -1;
		
		//NSString * pStr = (NSString * )[eventData objectForKey:[KeyObject withByteValue:STATUS_DATA]];
		
		//NSData * pData =[pStr dataUsingEncoding:NSUTF8StringEncoding];
		
		//unsigned char *incomingPacket = (unsigned char *)[pData bytes];
		
		//int *pIntData = (int *)&incomingPacket[0];
		
		// check the network time and make sure packers are in order
		//int packetTime  = pIntData[0];
		//int packetID    = pIntData[1];
		//int objectIndex = pIntData[2];
		
		int packetTime  = 0;
		int packetID    = 0; 
		int objectIndex = 0;
		
		NSDictionary * pHash = nil;
		
		pHash = [eventData objectForKey:[KeyObject withByteValue:STATUS_DATA]];
		
		if(pHash == nil)
			return;
		
		[((NSValue*)[pHash objectForKey:[KeyObject withByteValue:POS_PacketNumber]])getValue:&packetTime];
		[((NSValue*)[pHash objectForKey:[KeyObject withByteValue:POS_PacketID]])getValue:&packetID];
		[((NSValue*)[pHash objectForKey:[KeyObject withByteValue:POS_ObjectIndex]])getValue:&objectIndex];
		
		lastPacketTime = packetTime;
		
		switch( packetID ) 
		{
			case PACKET_COINTOSS:
			{
				// coin toss to determine roles of the two players
				//peerUniqueID = pIntData[3];
				
				[((NSValue*)[pHash objectForKey:[KeyObject withByteValue:POS_PACKET_COINTOSS]])getValue:&peerUniqueID];
				
				// if other player's coin is higher than ours then that player is the server
				if(peerUniqueID > uniqueID) 
				{
					self.role = RoleClient;
				}
				
				if (self.state == StateCointoss) 
				{
					if(self.connectionAlert && self.connectionAlert.visible) 
					{
						[self.connectionAlert dismissWithClickedButtonIndex:-1 animated:NO];
					}
					
					[delegate linkConnected: self.role];
				}
				
				self.state = StateConnected;
			}
				break;	
			default:
				if (dataReceiver) 
				{
					[dataReceiver receivePacket:packetID objectIndex:objectIndex data:eventData];
				}
				else
				{
					NSLog(@" !!! receiveData PACKET BEFORE COINTOSS: %d", packetID);
				}
		}
		
	}
}

-(void) PhotonPeerDebugReturn:(PhotonPeer_DebugLevel)debugLevel :(NSString*)string
{
	char* lvlstr;
	switch(debugLevel)
	{
		case DEBUG_LEVEL_OFF:
			lvlstr = "FATAL ERROR: ";
			break;
		case DEBUG_LEVEL_ERRORS:
			lvlstr = "ERROR: ";
			break;
		case DEBUG_LEVEL_WARNINGS:
			lvlstr = "WARNING: ";
			break;
		case DEBUG_LEVEL_INFO:
			lvlstr = "INFO: ";
			break;
		case DEBUG_LEVEL_ALL:
			lvlstr = "DEBUG: ";
			break;
		default:
			lvlstr = "";
			break;
	}
	printf("%s%s\n", lvlstr, [string UTF8String]);
}

-(void) Run
{
	[m_pLitePeer service:true];
	
	switch (m_currentState)
	{
		case statePhotonPeerCreated:
			[self CreateConnection];
			break;
		case stateConnecting:
			// Waiting callback function
			break;
		case stateConnected:
			// exchanging keys
			[self ExchangeKeys];
			m_currentState = stateKeysExchanging;
			break;
		case stateKeysExchanging:
			// Waiting for callback
			break;
		case stateKeysExchanged:
			[m_pLitePeer opCustom:OPC_RT_JOIN :[NSDictionary dictionaryWithObject:sessionID forKey:[KeyObject withByteValue:P_GAMEID]] :true :0 :true];
			isInGame = true;
			m_currentState = stateReceiving;
			break;
		case stateLeaving:
			[m_pLitePeer opLeave:sessionID];
			break;
		case stateDisconnecting:
			[self CloseConnection];
			break;
		case stateDisconnected:
			isInGame = false;
			break;
		case stateErrorConnecting:
			isInGame = false;
			break;
		default:
			break;
	}
}


-(void) CreateConnection
{
	char* server = "udp.exitgames.com:5055";
	
	[m_pLitePeer Connect:[NSString stringWithUTF8String:server]];
	
	m_currentState = stateConnecting;
}


-(void) CloseConnection
{
	[m_pLitePeer Disconnect];
}

-(void) ExchangeKeys
{
	[m_pLitePeer opExchangeKeysForEncryption];
}

-(void) leaveGame
{
	// if user closes application, leave current game and close connection to server
	if(m_currentState == stateJoined)
	{
		m_currentState = stateLeaving;
		
		[self Run];
		
		while(m_currentState == stateLeaving)
			[m_pLitePeer service];
	}
	
	m_currentState = stateDisconnecting;
	
	[self Run];
	
	while(m_currentState == stateDisconnecting)
		[m_pLitePeer service];
}

@end
