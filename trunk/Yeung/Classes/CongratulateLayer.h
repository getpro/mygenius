//
//  CongratulateLayer.h
//  Yeung
//
//  Created by Peteo on 12-5-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CongratulateLayer : CCLayer 
{
	NSMutableArray * m_pDrawTrackArr;	  //点数据
    
    CFTimeInterval   m_LastTime;
    
    int replaycurpoint;
}

+(CCScene *) scene;

@end
