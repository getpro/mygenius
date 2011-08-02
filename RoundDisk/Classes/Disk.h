//
//  Disk.h
//  RoundDisk
//
//  Created by msh on 11-6-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Disk : CCLayer 
{
	CCSprite * roundDisk;
	CCSprite * Bg;
	
	CGFloat diskRotation;
	CGFloat angleBeforeTouchesEnd;//最后一次调用touchesMoved roundDisk 旋转的角度
}

+(CCScene*)scene;

@end
