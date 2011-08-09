#include "LitePeer.h"
#import "iTestTextView.h"

#define MAX_PACKET_SIZE 1024

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
	Disconnecting,
	Disconnected,
} States;

@interface CPhotonLib : NSObject
{
	States m_currentState;
	LitePeer* m_pLitePeer;
	iTestTextView* textView;
}
- (void) InitCPhotonLib:(iTestTextView*) txtView;
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