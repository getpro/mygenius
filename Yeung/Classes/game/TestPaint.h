//
//  TestPaint.h
//  Yeung
//
//  Created by Peteo on 12-4-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TestPaint : CCLayer 
{
	CCRenderTexture* target;
	CCSprite* brush;
}

+(CCScene *) scene;

@end
