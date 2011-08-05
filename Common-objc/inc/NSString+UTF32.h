/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _NSSTRING_UTF32_EXTENSION_H
#define _NSSTRING_UTF32_EXTENSION_H

#include "data_structures.h"
#include <Foundation/NSString.h>

@interface NSString (UTF32)

+ (NSString*) stringWithUTF32String:(const EG_CHAR* const)str;
- (NSString*) initWithUTF32String:(const EG_CHAR* const)str;
- (const EG_CHAR* const) UTF32String;
- (EG_CHAR*) mallocedUTF32String; // you are responsible for freeing the returnvalue of this method!

@end

#endif