/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _UTILS_INTERNAL_H_
#define _UTILS_INTERNAL_H_

#include "Utils.h"

@interface Utils (Internal)

+ (EG_HashTable*) newEGHashTableFromNSDictionary:(NSDictionary*)origHash;
+ (EG_HashTable*) newEGHashTableFromNSDictionary:(NSDictionary*)origHash :(EG_HashTable*)convHash;
+ (EG_Vector*) newEGVectorFromNSMutableArray:(NSMutableArray*)origVec;
+ (NSDictionary*) NSDictionaryFromEGHashTable:(EG_HashTable*)origHash;
+ (NSMutableArray*) NSMutableArrayFromEGVector:(EG_Vector*)origVec;

@end

#endif