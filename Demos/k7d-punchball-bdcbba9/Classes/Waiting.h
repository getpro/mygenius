//
//  Waiting.h
//  punchball
//
//  Created by Peteo on 11-8-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "chipmunk.h"
#import  "cocos2d.h"

@protocol WaitReturnDelegate

-(void) WaitReturn;

@end

@interface Waiting : Layer 
{
	id<WaitReturnDelegate> delegate;
}

@property (nonatomic,assign) id<WaitReturnDelegate> delegate;

+(Scene *) scene :(id<WaitReturnDelegate>) _delegate;

@end
