//
//  CAttributeString.m
//

#import "CAttributeString.h"
#import "EditableCell.h"
#import "TagVC.h"

@implementation CAttributeString

@synthesize stringValue;
@synthesize nvController;
@synthesize m_nType;

- (NSString*)type 
{
	return @"string";
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
	static NSString* cellIdentifier = @"CAttributeStringCell";
	EditableCell* cell = (EditableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[EditableCell class]]) 
	{
		cell = [[[EditableCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
	}
	
	if (cell != nil)
	{
		cell.textLabel.text = self.label;
		[cell setTarget:self withLabel:@"label" withkey:@"stringValue"];
		cell.Target   = self;
		cell.Selector = @selector(getTagClick);
		//cell.textField.placeholder = @"...";
	}
	
	return cell;
}

@end
