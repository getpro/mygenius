/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _BASE_LISTENER_H_
#define _BASE_LISTENER_H_

#include <Foundation/NSString.h>

@protocol BaseListener

-(void)debugReturn:(NSString*) string;

@end

#endif