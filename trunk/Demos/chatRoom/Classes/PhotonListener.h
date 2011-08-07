#include "PhotonDemo.h"


@protocol MyListener

- (void) MyListenerEventAction:(nByte)eventCode :(NSDictionary*)photonEvent;

- (void) MyListenerStatus:(int)statusCode;

- (void) MyListenerOperationResult:(nByte)opCode :(int)returnCode :(NSDictionary*)returnValues :(short)invocID;

@end




@interface Listener : NSObject <PhotonListener>
{
    id <MyListener> delegate;
	
@private
	CPhotonLib * current;
	
}

@property (nonatomic, assign) id <MyListener> delegate;

- (void) InitListener:(CPhotonLib*)lib;

@end
