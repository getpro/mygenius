//
//  CAttributeMemo.m
//  AddressBook
//
//  Created by Peteo on 11-9-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CAttributeMemo.h"

@implementation CAttributeMemo

@synthesize stringValue;

- (NSString*)type
{
	return @"Memo";
}

- (id)initWithString:(NSString*)inputString 
{
	self = [super initWithString:inputString];
	if (self)
		self.stringValue = inputString;
	
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    self = [super initWithCoder:decoder];
	
	if (self)
		self.stringValue = [decoder decodeObjectForKey:@"stringValue"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [super encodeWithCoder:encoder];
    [encoder encodeObject:stringValue forKey:@"stringValue"];	
}

- (void)dealloc 
{
	[stringValue release];
	
	[super dealloc];
}

/*
- (UITableViewCell*)cellForTableView:(UITableView *)tableView 
{
	static NSString* cellIdentifier = @"CAttributeMemoCell";
	EditableCell* cell = (EditableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[EditableCell class]]) 
	{
		cell = [[[EditableCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
	}
	
	if (cell != nil)
	{
		cell.textLabel.text = self.label;
		[cell setTarget:self withKey:@"stringValue"];
		//cell.textField.placeholder = @"...";
	}
	
	return cell;
}
*/
 
@end
