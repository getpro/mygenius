/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _WRAPPER_DEFINES_H_
#define _WRAPPER_DEFINES_H_

#import <Foundation/NSString.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSArray.h>

#include "porting.h"
#include "constants.h"

#define DELETE_ARRAY_IF(p){if(p){delete[] (p);p=NULL;}}
#define DELETE_IF(p){if(p){delete (p);p=NULL;}}
#ifndef SAFE_DELETE
#define SAFE_DELETE(__p){if(__p){delete (__p);__p=NULL;}}
#endif

#define MEMSET2(p, val, num) for (int xyz = 0; xyz < num; xyz++) \
							 {									 \
							 p[xyz]=val;						 \
							 }		
#endif