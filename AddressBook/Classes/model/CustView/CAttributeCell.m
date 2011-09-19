//
//  CAttributeCell.m
//  Pulp Dossier
//
//  Created by Courtney Holmes on 6/7/11.
//  Copyright 2011 CJ Holmes. All rights reserved.
//

#import "CAttributeCell.h"


@implementation CAttributeCell

@synthesize dataTarget;
@synthesize dataKey;
@synthesize controller;


- (void)dealloc
{
	
	[self setTarget:nil withKey:nil];	// takes care of release and unregisters us as observer
    [super dealloc];
}

- (void)setTarget:(id)target withKey:(NSString*)key 
{
	// unregister any old observers
	if (dataTarget) 
	{
		[dataTarget removeObserver:self forKeyPath:dataKey];
		[dataTarget release];
		[dataKey    release];
	}
	
	dataTarget = [target retain];
	dataKey    = [key retain];
	
	// register as an observer of our target object
	if (dataTarget) 
	{
		[dataTarget addObserver:self 
					 forKeyPath:key 
						options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial 
						context:nil];
	}
}

- (void)prepareForReuse 
{
	[self setTarget:nil withKey:nil];
	controller = nil;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{
	NSString *newText = [change valueForKey:NSKeyValueChangeNewKey];
	
	if ([newText isKindOfClass:[NSString class]]) 
	{
		self.detailTextLabel.text = newText;
		[self setNeedsLayout];
	}
}

@end
