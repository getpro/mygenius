/**
 * iTestTextView.h - Exit Games Neutron "basic Photon iPhone demo"
 * Copyright (C) 2008 Exit Games GmbH
 * http://www.exitgames.com
 *
 * @author developer@exitgames.com
 */



// this class cares just about the user interface - see AppDelegate for the sample code
// attention: textoutput through this class is not very performant on device for huge amounts of texts, so do not choose MAX_LENGTH or NEUTRON_STRING_AMOUNT to big

#import <UIKit/UIKit.h>

#define NEUTRON_STRING_AMOUNT 5

@interface iTestTextView : UITextView<UIAlertViewDelegate>
{
	id app;
	bool initialized;
	NSMutableArray* ary;
}

-(void) writeToTextView:(NSString*) txt;

@end
