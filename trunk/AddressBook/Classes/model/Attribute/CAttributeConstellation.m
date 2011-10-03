//
//  CAttributeConstellation.m
//  AddressBook
//
//  Created by Peteo on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CAttributeConstellation.h"
#import "CustomPicker.h"
#import "PublicData.h"
#import "AddressBookAppDelegate.h"

@implementation CAttributeConstellation

@synthesize stringValue;

- (NSString*)type
{
	return @"Constellation";
}

- (id)init
{
    if ((self = [super init]))
	{
		m_pDateArry = [NSArray arrayWithObjects:@"水平座",@"双鱼座",@"牡羊座",@"金牛座",
												@"双子座",@"巨蟹座",@"狮子座",@"处女座",
												@"天秤座",@"天蝎座",@"射手座",@"摩羯座",nil];
		[m_pDateArry retain];
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
	[m_pDateArry release];
	
	[super dealloc];
}

- (UITableViewCell*)cellForTableView:(UITableView *)tableView 
{
	static NSString* cellIdentifier = @"CAttributeConstellationCell";
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
	NSString * pIndex = (NSString*)index;
	NSString * pStr = [m_pDateArry objectAtIndex:[pIndex intValue]];
	
	if(pStr)
	{
		self.stringValue = pStr;
	}
}

- (UIViewController*) detailViewController:(BOOL)editing 
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	CustomPicker *tvc = [[[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)] autorelease];
	tvc.sourceArray = m_pDateArry;
	tvc.Target   = self;
	tvc.Selector = @selector(getContentResult:);
	
	return (UIViewController*)tvc;
}

- (void) Show :(id) pVc
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	CustomPicker *tvc = (CustomPicker*) pVc;
	
	[app.window addSubview:tvc];
}

@end
