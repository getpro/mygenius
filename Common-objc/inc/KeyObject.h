/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#include "WrapperDefines.h"
#include "Base.h"

@interface KeyObject : Base <NSCopying>
{
@protected
	nByte type;
	NSObject* keyValue;
}

@property (readwrite) nByte Byte;
@property (readwrite) short Short;
@property (readwrite) int Int;
@property (readwrite) int64 Long;
@property (readwrite, retain) NSString* String;

+ (KeyObject*) withByteValue:(nByte)byteValue;
+ (KeyObject*) withShortValue:(short)shortValue;
+ (KeyObject*) withIntValue:(int)intValue;
+ (KeyObject*) withLongValue:(int64)longValue;
+ (KeyObject*) withStringValue:(NSString*)stringValue;

- (KeyObject*) initWithByteValue:(nByte)byteValue;
- (KeyObject*) initWithShortValue:(short)shortValue;
- (KeyObject*) initWithIntValue:(int)intValue;
- (KeyObject*) initWithLongValue:(int64)longValue;
- (KeyObject*) initWithStringValue:(NSString*)stringValue;

- (nByte) getType;

@end