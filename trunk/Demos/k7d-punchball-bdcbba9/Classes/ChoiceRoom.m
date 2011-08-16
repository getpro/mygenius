//
//  ChoiceRoom.m
//  punchball
//
//  Created by Peteo on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChoiceRoom.h"

@implementation ChoiceRoom

-(void) room1: (id) sender
{	
	[item1 setString:@"ROOM1(2)"];
}

-(void) room2: (id) sender
{	
	[item1 setString:@"ROOM1(2)"];
}

-(void) room3: (id) sender
{	
	[item1 setString:@"ROOM1(2)"];
}

-(void) room4: (id) sender
{	
	[item1 setString:@"ROOM1(2)"];
	
	MoveTo* move = [MoveTo actionWithDuration:3 position:CGPointMake(0.0f, 100.0f)]; 
	[item1 runAction:move];
}

- (id) init: (id<ChoiceRoomDelegate>) _delegate 
{
	[super init];
	
	delegate = _delegate;
	
	CGSize size = [[Director sharedDirector] winSize];
	
	//4个房间的Item
	
	MenuItemImage *vm1 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room1:)];
	Label *label1 = [Label labelWithString:@"ROOM1(0)" fontName:@"Marker Felt" fontSize:26];
	item1 = [MenuItemLabel itemWithLabel:label1 target:nil selector:nil];
	Menu *vmm1 = [Menu menuWithItems: vm1,item1,nil];
	vmm1.position = ccp(size.width / 3, 2 * size.height / 3);
	[self addChild:vmm1 z:1];
	
	
	MenuItemImage *vm2 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room2:)];
	Label *label2 = [Label labelWithString:@"ROOM2(0)" fontName:@"Marker Felt" fontSize:26];
	item2 = [MenuItemLabel itemWithLabel:label2 target:nil selector:nil];
	Menu *vmm2 = [Menu menuWithItems: vm2,item2,nil];
	vmm2.position = ccp(2 * size.width / 3, 2 * size.height / 3);
	[self addChild:vmm2 z:1];
	
	MenuItemImage *vm3 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room3:)];
	Label *label3 = [Label labelWithString:@"ROOM3(0)" fontName:@"Marker Felt" fontSize:26];
	item3 = [MenuItemLabel itemWithLabel:label3 target:nil selector:nil];
	Menu *vmm3 = [Menu menuWithItems: vm3,item3,nil];
	vmm3.position = ccp(size.width / 3, size.height / 3);
	[self addChild:vmm3 z:1];
	
	MenuItemImage *vm4 = [MenuItemImage itemFromNormalImage:@"room.png" selectedImage:@"room_s.png" target:self selector:@selector(room4:)];
	Label *label4 = [Label labelWithString:@"ROOM4(0)" fontName:@"Marker Felt" fontSize:26];
	item4 = [MenuItemLabel itemWithLabel:label4 target:nil selector:nil];
	Menu *vmm4 = [Menu menuWithItems: vm4,item4,nil];
	vmm4.position = ccp(2 * size.width / 3, size.height / 3);
	[self addChild:vmm4 z:1];
	
	return self;
}

- (void)layerReplaced
{
	
}

@end
