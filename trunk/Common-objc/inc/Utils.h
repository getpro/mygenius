/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _UTILS_H_
#define _UTILS_H_

#include "WrapperDefines.h"
#include "Base.h"
#include "constants.h"
#include "data_structures.h"
#include "KeyObject.h"
#include "EGTime.h"
#include "NSString+UTF32.h"
#include "EGArray.h"

@interface Utils : Base
{
}

+ (NSString*) hashToString:(NSDictionary*)hash; // = false
+ (NSString*) hashToString:(NSDictionary*)hash :(bool)withTypes;

@end

#endif