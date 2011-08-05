/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _BASE_H
#define _BASE_H

#include "BaseListener.h"

@interface Base : NSObject
{
}

+ (void) setListener:(id<BaseListener>) baseListener;
+ (void) debugReturn:(NSString*) string;

@end
#endif