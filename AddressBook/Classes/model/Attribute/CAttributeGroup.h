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
	NSArray * m_pDateArry;
	
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;

@end
