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

#import <Foundation/Foundation.h>

//#import <GameKit/GameKit.h>

#include "LitePeer.h"

#define MAX_PACKET_SIZE 1024

#define  EV_DATA ((char)101)

#define  STATUS_DATA ((char)43)


#define  POS_PacketNumber ((nByte)102)
#define  POS_PacketID     ((nByte)103)
#define  POS_ObjectIndex  ((nByte)104)

#define  POS_PACKET_COINTOSS      ((nByte)105)
#define  POS_NETWORK_UPDATE_DIR   ((nByte)106)
#define  POS_NETWORK_PUNCH		  ((nByte)107)
#define  POS_NETWORK_SLIDE		  ((nByte)108)
#define  POS_NETWORK_TURN		  ((nByte)109)
#define  POS_NETWORK_POS		  ((nByte)110)
#define  POS_NETWORK_PAUSE		  ((nByte)111)
#define  POS_NETWORK_RESUME	      ((nByte)112)

#define  POS_CGPoint_X			  ((nByte)113)
#define  POS_CGPoint_Y			  ((nByte)114)

#define  POS_SlideTo_X			  ((nByte)115)
#define  POS_SlideTo_Y			  ((nByte)116)
#define  POS_SlideTo_FinalSlide	  ((nByte)117)


#define  POS_PlayerInfo_headP_X			((nByte)118)
#define  POS_PlayerInfo_headP_Y			((nByte)119)
#define  POS_PlayerInfo_headV_X			((nByte)120)
#define  POS_PlayerInfo_headV_Y			((nByte)121)
#define  POS_PlayerInfo_headA			((nByte)122)
#define  POS_PlayerInfo_gloveV_X		((nByte)123)
#define  POS_PlayerInfo_gloveV_Y		((nByte)124)
#define  POS_PlayerInfo_opponentHealth	((nByte)125)


typedef enum 
{
	RoleServer,
	RoleClient
}LinkRole;


//Photon
typedef enum States
{
	statePhotonPeerCreated,
	
	stateConnecting,
	stateConnected,
	stateErrorConnecting,
	
	stateKeysExchanging,
	stateKeysExchanged,
	
	stateJoining,
	stateErrorJoining,
	stateJoined,
	
	stateLeaving,
	stateErrorLeaving,
	stateLeft,
	
	stateReceiving,
	stateDisconnecting,
	stateDisconnected,
	
	stateEnterLobbying,
	stateEnterLobbyed
	
}States;



#define PACKET_COINTOSS -1				// decide who is going to be the server



@protocol DataReceiver

- (void)receivePacket:(int)packetID objectIndex:(int)objectIndex data:(NSDictionary*)returnValues;

@end



@protocol LinkDelegate

-(void) linkConnected: (LinkRole) role;
-(void) linkDisconnected;

@end

@protocol UpDateRoomDelegate

-(void) UpDateRoom:(nByte)eventCode :(NSDictionary*)photonEvent;

@end

@interface Link : NSObject  < PhotonListener >  /* <GKPeerPickerControllerDelegate,GKSessionDelegate> */
{
	id<LinkDelegate> delegate;
	id<DataReceiver> dataReceiver;
	id<UpDateRoomDelegate> upDateRoomdelegate;
	
	NSString	*sessionID; //相当于Photon中的GameID
	NSString	*name;
	
	//GKSession	*session;
	UIAlertView	*connectionAlert;
	NSInteger	state;
	NSInteger	role;
	
	int			uniqueID;
	int			peerUniqueID;
	int			packetNumber;
	
	NSString	*peerID;
	NSString	*peerName;
	
	//Photon
	LitePeer    *m_pLitePeer;
	States       m_currentState;
	BOOL		 b_IsWaiting;
	
	NSTimer		*m_timer;
	BOOL         b_TimerIsRunning;
	
	NSString    *m_strRoomID;
}

@property BOOL		 b_IsWaiting;

@property(nonatomic) NSInteger					state;

@property(nonatomic, copy)	 NSString			*name;
@property(nonatomic) NSInteger					role;
@property(nonatomic) NSInteger					uniqueID;
@property(nonatomic, copy)	 NSString			*sessionID;
@property(nonatomic, copy)	 NSString			*m_strRoomID;
//@property(nonatomic, retain) GKSession			*session;

// remote peer
@property(nonatomic, copy)	 NSString			*peerID;
@property(nonatomic) NSInteger					peerUniqueID;
@property(nonatomic, copy)	 NSString			*peerName;

@property(nonatomic, retain) UIAlertView		*connectionAlert;

@property(nonatomic, retain) id<DataReceiver>	dataReceiver;
@property(nonatomic, retain) id<UpDateRoomDelegate> upDateRoomdelegate;

- (id)initWithID:(NSString*)_sessionID name:(NSString*)_name delegate:(id<LinkDelegate>)_delegate;

- (void)startPicker;
- (void)reset;
- (void)resync;
- (void)sendPacket:(int)packetID objectIndex:(int)objectIndex data:(void *)data length:(int)length reliable:(bool)howtosend;

- (void)invalidateSession;


//Photon
-(void) Run;
-(void) CreateConnection;
-(void) CloseConnection;
-(void) leaveGame;
-(void) ExchangeKeys;

-(void) EnterLobby;
-(void) LeaveLobby;

-(void) EnterRoom;
-(void) LeaveRoom;

-(short) Join: (NSString*)gameId;
-(short) Leave:(NSString*)gameId;

-(void) JoinIntoRoom:(NSString *) pRoomNo;



@end
