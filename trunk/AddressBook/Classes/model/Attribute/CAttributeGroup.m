//
//  CAttributeGroup.m
//

#import "CAttributeGroup.h"
#import "CustomPicker.h"
#import "PublicData.h"

@implementation CAttributeGroup

@synthesize stringValue;

- (NSString*)type
{
	return @"group";
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
	[self.stringValue release];
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
		[cell setTarget:self withKey:@"stringValue"];
		//cell.textField.placeholder = @"...";
	}
	
	return cell;
}

- (UIViewController*) detailViewController:(BOOL)editing 
{
	CustomPicker *tvc = [[[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)] autorelease];
	//tvc.track = self;
	return (UIViewController*)tvc;
}

- (void) Show :(id) pVc
{
	CustomPicker *tvc = (CustomPicker*) pVc;
	
}

@end
