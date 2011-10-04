//
//  CAttributeMemo.m
//  AddressBook
//
//  Created by Peteo on 11-9-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CAttributeMemo.h"
#import "Memo.h"
#import "TagVC.h"

@implementation CAttributeMemo

@synthesize stringValue;
@synthesize nvController;
@synthesize m_nType;
@synthesize m_pDate;
@synthesize m_nRemindIndex;

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
	[m_pDate     release];
	
	[super dealloc];
}

-(void)getTagContent:(id)str
{
	NSString * pStr = (NSString *)str;
	if(pStr)
	{
		self.label = pStr;
		NSLog(@"getTagContent[%@]",pStr);
	}
}

-(void)getTagClick
{
	//标签被点击
	if(nvController)
	{
		TagVC * pVc = [[TagVC alloc] init];
		pVc.m_nType  = m_nType;
		pVc.Target   = self;
		pVc.Selector = @selector(getTagContent:);
		[nvController pushViewController:pVc animated:YES];
		
		[pVc release];
	}
}

- (UITableViewCell*)cellForTableView:(UITableView *)tableView 
{
	static NSString* cellIdentifier = @"CAttributeMemoCell";
	TagCell* cell = (TagCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[TagCell class]]) 
	{
		cell = [[[TagCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	if (cell != nil)
	{
		cell.textLabel.text = self.label;
		[cell setTarget:self withLabel:@"label" withkey:@"stringValue"];
		cell.Target   = self;
		cell.Selector = @selector(getTagClick);
		//cell.textField.placeholder = @"...";
	}
	
	//m_pCell = cell;
	
	return cell;
}

-(void)getContentResult:(id)data :(id)index
{
	NSDate * pDate = (NSDate*)data;
	
	NSString * pStr = (NSString*)index;
	
	if(pDate)
	{
		self.m_pDate = pDate;
		
		if(pStr)
		{
			m_nRemindIndex = [pStr intValue];
		}
		else
		{
			m_nRemindIndex = 0;
		}
	}
}


- (UIViewController*) detailViewController:(BOOL)editing 
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	Memo *tvc = [[[Memo alloc] init] autorelease];
	tvc.Target   = self;
	tvc.Selector = @selector(getContentResult::);
	
	return (UIViewController*)tvc;
}


- (void) Show :(id) pVc
{
	Memo *tvc = (Memo*) pVc;
	
	[nvController pushViewController:tvc animated:YES];
}
 
@end
