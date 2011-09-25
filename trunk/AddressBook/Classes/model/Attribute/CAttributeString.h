//
//  CAttributeString.h
//
//  左边标签，右边编辑内容

#import <Foundation/Foundation.h>
#import "CAttribute.h"

/*	
 Attributes for short text strings. 
*/
@interface CAttributeString : CAttribute 
{
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;

@end
