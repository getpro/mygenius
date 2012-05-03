//
//  LoginLayer.h
//  Yeung
//
//  Created by Peteo on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface LoginLayer : CCLayer 
{
	UIDatePicker * datePickerView;
	
	NSInteger      m_nWrongNum;
	
	BOOL           m_bIsRight;
}

+(CCScene *) scene;

@end
