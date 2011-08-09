#include "PhotonDemo.h"
#import "iTestTextView.h"

@interface Listener : NSObject <PhotonListener>
{
@private
	CPhotonLib* current;
	iTestTextView* textView;
}

- (void) InitListener:(CPhotonLib*)lib :(iTestTextView*)txtView;

@end
