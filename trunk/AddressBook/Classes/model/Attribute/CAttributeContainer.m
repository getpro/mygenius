//
//  CAttributeContainer.m
//

#import "CAttributeContainer.h"


@implementation CAttributeContainer

@synthesize type;
@synthesize uuid;
@synthesize attributes;


-(id)init 
{
	self = [super init];
	if (self) 
	{
		self.attributes = [NSMutableArray array];
		
		CFUUIDRef guid = CFUUIDCreate(NULL);
		if (guid) 
		{
			NSString *tempUuid = [NSString stringWithString: (NSString*)CFUUIDCreateString(NULL, guid)];
			self.uuid = tempUuid;
			CFRelease(guid);
		}
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder 
{
	self.type = [decoder decodeObjectForKey:@"type"];
	self.uuid = [decoder decodeObjectForKey:@"uuid"];
	self.attributes = [decoder decodeObjectForKey:@"attributes"];
	if (self.attributes == nil) 
	{
		self.attributes = [NSArray array];
	}

	if (!self.uuid) 
	{
		CFUUIDRef guid = CFUUIDCreate(NULL);
		if (guid) 
		{
			NSString *tempUuid = [NSString stringWithString: (NSString*)CFUUIDCreateString(NULL, guid)];
			self.uuid = tempUuid;
			CFRelease(guid);
		}
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder 
{
	[encoder encodeObject:type forKey:@"type"];
	[encoder encodeObject:uuid forKey:@"uuid"];
	[encoder encodeObject:attributes forKey:@"attributes"];
}

- (void)dealloc 
{
	[type       release];
	[uuid		release];
	[attributes release];
	
	[super dealloc];
}

- (id)valueForUndefinedKey:(NSString *)key 
{
	id retval = nil;
	
	NSPredicate *labelPredicate = [NSPredicate predicateWithFormat:@"label like %@", key];
	NSArray *foundItems = [self.attributes filteredArrayUsingPredicate:labelPredicate];
	if (foundItems && [foundItems count])
		retval = [foundItems objectAtIndex:0];
	
	return retval;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key 
{
	id oldValue;
	
	if ([value isKindOfClass:[CAttribute class]]) 
	{
		CAttribute *attr = value;
		attr.label = key;

		/*
		oldValue = [self valueForUndefinedKey:key];
		if (oldValue)
		{
			NSInteger index = [self.attributes indexOfObject:oldValue];
			[self.attributes replaceObjectAtIndex:index withObject:attr];
		}
		else
		*/
		
		{
			[self.attributes addObject:attr];
		}
	} 
	else if (value == nil) 
	{
		oldValue = [self valueForUndefinedKey:key];
		if (oldValue)
			[self.attributes removeObject:oldValue];
	}
}

-(NSUInteger)countOfAttributes {
	return [self.attributes count];
}

-(id)objectInAttributesAtIndex:(NSUInteger)index {
	return [self.attributes objectAtIndex:index];
}

- (void)insertObject:(id)anObject inAttributesAtIndex:(NSUInteger)index {
	[self.attributes insertObject:anObject atIndex:index];
}

- (void)removeObjectFromAttributesAtIndex:(NSUInteger)index {
	[self.attributes removeObjectAtIndex:index];
}

-(void)replaceObjectInAttributesAtIndex:(NSUInteger)index withObject:(id)anObject {
	[self.attributes replaceObjectAtIndex:index withObject:anObject];
}

@end
