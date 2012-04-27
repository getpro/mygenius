//
//  CCRadioMenu.h
//  DrawSomeThing
//
//  Created by Peteo on 12-4-3.
//  Copyright 2012 The9. All rights reserved.
//

#import "cocos2d.h"

@interface CCRadioMenu : CCMenu 
{
	CCMenuItem *_curHighlighted;
}

-(void)setSelectedRadioItem:(CCMenuItem*)item;

+ (id) radioMenuWithItems:(CCMenuItem*) item, ... NS_REQUIRES_NIL_TERMINATION;

@end
