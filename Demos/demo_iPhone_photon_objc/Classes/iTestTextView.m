/**
 * iTestTextView.m - Exit Games Neutron "basic Photon iPhone demo"
 * Copyright (C) 2008 Exit Games GmbH
 * http://www.exitgames.com
 *
 * @author developer@exitgames.com
 */




// this class cares just about the user interface - see AppDelegate for the sample code

#import "iTestTextView.h"
#define MAX_LENGTH 1000

@implementation iTestTextView


- (id)initWithFrame:(CGRect)frame
{
	ary = [[NSMutableArray arrayWithCapacity:NEUTRON_STRING_AMOUNT] retain];
	for(int i=0; i<NEUTRON_STRING_AMOUNT; i++)
		[ary addObject:@""];
	initialized = true;
	
	if (self = [super initWithFrame:frame])
	{
		self.font = [UIFont fontWithName:@"Arial" size:10];
		self.textColor = [UIColor blackColor];
		self.editable = false;
		self.frame = CGRectMake(0, 24, 320, 480);
	}
	return self;
}

-(void) writeToTextView:(NSString*) txt
{
	if(initialized)
	{
		NSString* newTxt = [[NSString stringWithFormat:@""] retain];
		NSString* temp = txt;
		
		for(int i=NEUTRON_STRING_AMOUNT-1; i>0; i--)
			[ary replaceObjectAtIndex:i withObject:[ary objectAtIndex:i-1]];
		if([temp length] > MAX_LENGTH)
			temp = [temp substringToIndex:MAX_LENGTH];
		[ary replaceObjectAtIndex:0 withObject:temp];
		
		for(int i=0; i<NEUTRON_STRING_AMOUNT; i++)
			newTxt = [newTxt stringByAppendingString:[[ary objectAtIndex:i] stringByAppendingString:@"\n"]];
		self.text = newTxt;
	}
}

- (void)dealloc
{
	[super dealloc];
}


@end