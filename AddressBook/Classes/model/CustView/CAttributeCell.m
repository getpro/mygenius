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
@synthesize dataLabel;

- (void)dealloc
{
	// takes care of release and unregisters us as observer
	[self setTarget:nil withLabel:nil withkey:nil];
	
    [super dealloc];
}

- (void)setTarget:(id)target withLabel:(NSString*)label withkey:(NSString*)key
{
	// unregister any old observers
	if (dataTarget)
	{
		[dataTarget removeObserver:self forKeyPath:dataKey];
		[dataTarget removeObserver:self forKeyPath:dataLabel];
		
		[dataTarget release];
		[dataKey    release];
		[dataLabel  release];
	}
	
	dataTarget = [target retain];
	dataKey    = [key    retain];
	dataLabel  = [label  retain];
	
	// register as an observer of our target object
	if (dataTarget)
	{
		
		[dataTarget addObserver:self 
					 forKeyPath:key 
						options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial 
						context:nil];
		
		
		[dataTarget addObserver:self
					 forKeyPath:label
						options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
						context:nil];
	}
}

- (void)prepareForReuse 
{
	[self setTarget:nil withLabel:nil withkey:nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{
	NSString *newText = [change valueForKey:NSKeyValueChangeNewKey];
	
	if ([newText isKindOfClass:[NSString class]]) 
	{
		if([keyPath isEqual:@"stringValue"])
		{
			self.detailTextLabel.text = newText;
		}
		else if([keyPath isEqual:@"label"])
		{
			self.textLabel.text = newText;
		}
		[self setNeedsLayout];
	}
}

@end
