/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _EG_TIME_H
#define _EG_TIME_H

#include "WrapperDefines.h"
#include "data_structures.h"
#include "Base.h"

@interface EGTime : Base
{
}

+(bool) Less:(int)firstTime:(int)secondTime;
+(bool) Greater:(int)firstTime:(int)secondTime;
+(bool) LessOrEqual:(int)firstTime:(int)secondTime;
+(bool) GreaterOrEqual:(int)firstTime:(int)secondTime;
+(int) Difference:(int)firstTime:(int)secondTime;

@end

#endif