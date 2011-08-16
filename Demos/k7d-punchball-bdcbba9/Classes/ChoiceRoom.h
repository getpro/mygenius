//
//  ChoiceRoom.h
//  punchball
//
//  Created by Peteo on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "chipmunk.h"
#include "cocos2d.h"
#include "ReplaceLayerAction.h"

@protocol ChoiceRoomDelegate

-(void) EnterRoom:(NSInteger) pIndex;

@end

@interface ChoiceRoom : Layer  <ReplaceLayerActionDelegate>
{
	id<ChoiceRoomDelegate> delegate;
	
	MenuItemLabel *item1;
	MenuItemLabel *item2;
	MenuItemLabel *item3;
	MenuItemLabel *item4;
	
}

- (id) init: (id<ChoiceRoomDelegate>) _delegate;

@end
