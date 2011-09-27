//
//  CAttributeRecommend.m
//  AddressBook
//
//  Created by Peteo on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CAttributeRecommend.h"

@implementation CAttributeRecommend

@synthesize stringValue;

- (NSString*)type
{
	return @"Recommend";
}

- (id)init
{
    if ((self = [super init]))
	{
		
	}
	return self;
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

- (UITableViewCell*)cellForTableView:(UITableView *)tableView 
{
	static NSString* cellIdentifier = @"CAttributeRecommendCell";
	CAttributeCell* cell = (CAttributeCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[CAttributeCell class]]) 
	{
		cell = [[[CAttributeCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if (cell != nil)
	{
		cell.textLabel.text = self.label;
		[cell setTarget:self withLabel:@"label" withkey:@"stringValue"];
		//cell.textField.placeholder = @"...";
	}
	
	return cell;
}

-(void)getContentResult:(id)index
{
	/*
	NSString * pIndex = (NSString*)index;
	NSString * pStr = [m_pDateArry objectAtIndex:[pIndex intValue]];
	
	if(pStr)
	{
		self.stringValue = pStr;
	}
	*/
}

/*
- (UIViewController*) detailViewController:(BOOL)editing 
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	CustomPicker *tvc = [[[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)] autorelease];
	tvc.sourceArray = m_pDateArry;
	tvc.Target   = self;
	tvc.Selector = @selector(getContentResult:);
	
	return (UIViewController*)tvc;
}
*/
 
- (void) Show :(id) pVc
{
	/*
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	CustomPicker *tvc = (CustomPicker*) pVc;
	
	[app.window addSubview:tvc];
	*/
}

@end
