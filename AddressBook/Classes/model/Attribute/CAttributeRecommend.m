//
//  CAttributeRecommend.m
//  AddressBook
//
//  Created by Peteo on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CAttributeRecommend.h"
#import "RecommendVC.h"


@implementation CAttributeRecommend

@synthesize stringValue;
@synthesize nvController;
@synthesize m_pABContact;

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
	[stringValue  release];
	[m_pABContact release];
	
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
