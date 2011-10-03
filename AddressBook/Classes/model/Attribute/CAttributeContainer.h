//
// CAttributeContainer.h
//
// Cell属性的容器

#import <Foundation/Foundation.h>

#import "CAttribute.h"
#import "CAttributeString.h"
#import "CAttributeGroup.h"
#import "CAttributeBlood.h"
#import "CAttributeConstellation.h"
#import "CAttributeRecommend.h"
#import "CAttributeMemo.h"

/*	
	Characters and all kinds of resources (aspects, skills, etc) are all 
	attribute containers, obviously because they "have" attributes.  When
	appropriate, we want the attributes to behave like properties, and we
	also want to be able to access the attributes property like the array
	that it is.
 
	This class is mainly just about the key-value coding required to support
	the syntactical sugar at the higher levels of code, and to get all of the
	other goodness that KV-compliant coding gives us (observability, etc).
*/
@interface CAttributeContainer : NSObject <NSCoding> 
{
	NSString *type;
	NSString *uuid;
	NSMutableArray *attributes;
}

@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *uuid;
@property (nonatomic,retain) NSMutableArray *attributes;

/*	Retrieves the first attribute whose label is equal to the key.  If the
	labeled CAttribute does not exist, nil is returned.
 */
- (id)valueForUndefinedKey:(NSString *)key;

/*	You can use any key you like to store CAttribute objects.  Doing so causes
	the CAttribute's label property to be set to key.
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (NSUInteger)countOfAttributes;
- (id)objectInAttributesAtIndex:(NSUInteger)index;
- (void)insertObject:(id)anObject inAttributesAtIndex:(NSUInteger)index;
- (void)removeObjectFromAttributesAtIndex:(NSUInteger)index;
- (void)removeAllObject;
- (void)replaceObjectInAttributesAtIndex:(NSUInteger)index withObject:(id)anObject; 

@end
