/* Exit Games Common - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _EGARRAY_H_
#define _EGARRAY_H_

#include "WrapperDefines.h"

#ifdef _EG_IPHONE_PLATFORM
	#define IOS_OSX(ios, osx) ios
#else
	#define IOS_OSX(ios, osx) osx
#endif

@interface EGArray : NSArray
{
@protected
	NSArray* mData;
	NSString* mType;
}

@property (readonly) NSArray* Data;
@property (readonly) NSString* Type;
@property (readonly) const char* const CType;
@property (readonly) const void* const CArray;

- (id) initWithType:(NSString*)type;
- (id) initWithCType:(const char* const)type;
+ (id) arrayWithCType:(const char* const)type;
+ (id) arrayWithType:(NSString*)type;
- (EGArray*) arrayByAddingObject:(id)anObject;
- (EGArray*) arrayByAddingObjectsFromArray:(NSArray*)otherArray;
+ (NSString*) getTypeFromObj:(id)obj;
+ (const char* const) getCTypeFromObj:(id)obj;

@end



@interface EGMutableArray : EGArray

@property (readwrite, copy) NSMutableArray* MutableData;

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)addObjectsFromArray:(NSArray*)otherArray;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeAllObjects;
- (void)removeObject:(id)anObject inRange:(NSRange)range;
- (void)removeObject:(id)anObject;
- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)removeObjectIdenticalTo:(id)anObject;
- (void)removeObjectsFromIndices:(NSUInteger*)indices numIndices:(NSUInteger)cnt IOS_OSX(NS_DEPRECATED(10_0, 10_6, 2_0, 4_0), DEPRECATED_IN_MAC_OS_X_VERSION_10_6_AND_LATER);
- (void)removeObjectsInArray:(NSArray*)otherArray;
- (void)removeObjectsInRange:(NSRange)range;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray*)otherArray range:(NSRange)otherRange;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray*)otherArray;
- (void)setArray:(NSArray*)otherArray;
- (void)sortUsingFunction:(NSInteger (*)(id, id, void*))compare context:(void*)context;
- (void)sortUsingSelector:(SEL)comparator;

- (void)insertObjects:(NSArray*)objects atIndexes:(NSIndexSet*)indexes IOS_OSX(NS_AVAILABLE(10_4, 2_0), AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER);
- (void)removeObjectsAtIndexes:(NSIndexSet*)indexes IOS_OSX(NS_AVAILABLE(10_4, 2_0), AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER);
- (void)replaceObjectsAtIndexes:(NSIndexSet*)indexes withObjects:(NSArray*)objects IOS_OSX(NS_AVAILABLE(10_4, 2_0), AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER);

#if NS_BLOCKS_AVAILABLE
- (void)sortUsingComparator:(NSComparator)cmptr IOS_OSX(NS_AVAILABLE(10_6, 4_0), AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER);
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr IOS_OSX(NS_AVAILABLE(10_6, 4_0), AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER);
#endif

+ (id)arrayWithCapacity:(NSUInteger)numItems :(NSString*)type;
- (id)initWithCapacity:(NSUInteger)numItems :(NSString*)type;

@end


/*@interface NSMutableArray (NSExtendedMutableArray)

- (void)addObjectsFromArray:(NSArray *)otherArray;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeAllObjects;
- (void)removeObject:(id)anObject inRange:(NSRange)range;
- (void)removeObject:(id)anObject;
- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)removeObjectIdenticalTo:(id)anObject;
- (void)removeObjectsFromIndices:(NSUInteger *)indices numIndices:(NSUInteger)cnt DEPRECATED_IN_MAC_OS_X_VERSION_10_6_AND_LATER;
- (void)removeObjectsInArray:(NSArray *)otherArray;
- (void)removeObjectsInRange:(NSRange)range;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
- (void)setArray:(NSArray *)otherArray;
- (void)sortUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortUsingSelector:(SEL)comparator;

- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER;
- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER;
- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER;

#if NS_BLOCKS_AVAILABLE
- (void)sortUsingComparator:(NSComparator)cmptr AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER;
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER;*/

#endif