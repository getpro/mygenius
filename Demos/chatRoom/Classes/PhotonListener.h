#include "PhotonDemo.h"

@interface Listener : NSObject <PhotonListener>
{
@private
	CPhotonLib * current;
}

- (void) InitListener:(CPhotonLib*)lib;

@end
