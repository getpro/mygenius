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
#import  "Link.h"

@protocol ChoiceRoomDelegate

-(void) EnterRoom:(NSInteger) pIndex;

@end

@interface ChoiceRoom : Layer  <ReplaceLayerActionDelegate , UpDateRoomDelegate>
{
	id<ChoiceRoomDelegate> delegate;
	
	MenuItemLabel *item1;
	MenuItemLabel *item2;
	MenuItemLabel *item3;
	MenuItemLabel *item4;
	
	NSInteger m_nRoom1;
	NSInteger m_nRoom2;
	NSInteger m_nRoom3;
	NSInteger m_nRoom4;
	
}

- (id) init: (id<ChoiceRoomDelegate>) _delegate;

- (void) UpDateRoomNum;

@end
