//
//  CAttributeRelate.m
//  AddressBook
//
//  Created by Peteo on 11-10-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CAttributeRelate.h"
#import "RecommendVC.h"
#import "TagVC.h"

@implementation CAttributeRelate

@synthesize stringValue;
@synthesize nvController;
@synthesize m_pABContact;
@synthesize m_nType;

- (NSString*)type
{
	return @"Relate";
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
	[stringValue  release];
	[m_pABContact release];
	
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
	static NSString* cellIdentifier = @"CAttributeRelateCell";
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

-(void)getContentResult:(id)index
{
	ABContact * pABContact = (ABContact*)index;
	
	if(pABContact)
	{
		self.stringValue  = pABContact.contactName;
		self.m_pABContact = pABContact;
	}
}


- (UIViewController*) detailViewController:(BOOL)editing 
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	RecommendVC *tvc = [[[RecommendVC alloc] init] autorelease];
	tvc.Target   = self;
	tvc.Selector = @selector(getContentResult:);
	
	return (UIViewController*)tvc;
}


- (void) Show :(id) pVc
{
	RecommendVC *tvc = (RecommendVC*) pVc;
	
	[nvController pushViewController:tvc animated:YES];
}

@end
