#include "LitePeer.h"

typedef enum
{
	SampleStarted		= 0,
	PhotonPeerCreated,
	Connecting,
	Connected,
	Joining,
	ErrorJoining,
	Joined,
	Leaving,
	ErrorLeaving,
	Left,
	ErrorConnecting,
	Receiving,
	Sended,
	Disconnecting,
	Disconnected,
} States;

@interface CPhotonLib : NSObject
{
	States m_currentState;
	LitePeer* m_pLitePeer;
}

- (void) InitCPhotonLib;
- (int) InitLib:(id<PhotonListener>) listener;
- (int) Run;
- (int) CreateConnection;
- (int) CloseConnection;
- (short) Join:(NSString*)gameId;
- (short) Leave:(NSString*)gameId;
- (void) sendData;
- (void) SetState:(States) new_state;
- (States) GetState;
- (void) Stop;

@end