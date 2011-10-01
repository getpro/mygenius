//
//  CAttributeGroup.m
//

#import "CAttributeGroup.h"
#import "CustomPicker.h"
#import "PublicData.h"
#import "AddressBookAppDelegate.h"

@implementation CAttributeGroup

@synthesize stringValue;

- (NSString*)type
{
	return @"group";
}

- (id)init
{
    if ((self = [super init]))
	{
		AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
		
		m_pDateArry = [[NSMutableArray alloc] initWithCapacity:10];
		
		for(int i = 0; i < [app.m_arrGroup count]; i++)
		{
			ABGroup * pGroup = [app.m_arrGroup objectAtIndex:(i)];
			[m_pDateArry addObject:pGroup.name];
		}
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
	static NSString* cellIdentifier = @"CAttributeGroupCell";
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
	tvc.Target   = self;
	tvc.Selector = @selector(getContentResult:);
	tvc.sourceArray = m_pDateArry;
	
	return (UIViewController*)tvc;
}

- (void) Show :(id) pVc
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	CustomPicker *tvc = (CustomPicker*) pVc;
	
	[app.window addSubview:tvc];
}

@end
