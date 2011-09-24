//
//  CAttributeGroup.h
//
//  分组

#import <Foundation/Foundation.h>

#import "CAttribute.h"

/*	
 Attributes for short text strings. 
*/
@interface CAttributeGroup : CAttribute 
{
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;


@end
