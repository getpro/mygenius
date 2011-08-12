#include "LitePeer.h"

typedef enum
{
	SampleStarted		= 0,
	PhotonPeerCreated,
	
	Connecting,
	Connected,
	
	GetProperying,
	
	Joining,
	Joined,
	
	Leaving,
	Left,
	
	ErrorJoining,
	ErrorLeaving,
	ErrorConnecting,
	
	Receiving,
	Sended,
	
	Disconnecting,
	Disconnected,
	
	KeysExchanging,
	KeysExchanged,
	
	EnterLobbying,
	EnterLobbyed,
	
} States;

@interface CPhotonLib : NSObject
{
	States m_currentState;
	LitePeer * m_pLitePeer;
	
	NSString * m_strRoomID;
}

@property (nonatomic,retain) NSString * m_strRoomID;

- (void) InitCPhotonLib;
- (int) InitLib:(id<PhotonListener>) listener;
- (int) Run;
- (int) CreateConnection;
- (int) CloseConnection;
- (short) Join:(NSString*)gameId;
- (short) Leave:(NSString*)gameId;
- (void) sendData;
- (void) sendData:(NSString*)pStr;
- (void) SetState:(States) new_state;
- (States) GetState;
- (void) Stop;
- (void) ExchangeKeys;

- (void) DeriveSharedKey :(nByte*)serverPublicKey;

- (void) EnterLobby;

- (void) EnterRoom;
- (void) LeaveRoom;

- (void) GetProperties;

@end