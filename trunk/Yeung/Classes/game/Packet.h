//
//  Packet.h
//  DrawSomething
//
//  Created by Huang Daxin on 4/4/12.
//  Copyright 2012 The9. All rights reserved.
//


#import "PacketDefine.h"

@interface EncodePacket : NSObject
{
	char*	mBuffer;
	_UINT32	mLength;
}

- (id)initWithBuffer:(char *)buffer;

- (void) putWord:(_UINT16)value;
- (void) putString:(const char *)str;
- (void) putSize;
- (void) putByte:(_UINT8)value;
- (void) putUInt32:(_UINT32)value;
- (void) putUInt64:(_UINT64)value;
- (void) putFloat:(_FLOAT)value;
- (void) putData:(const void *)pData :(_UINT32)length;

- (_UINT32) getSize;

@end


@interface DecodePacket : NSObject
{
	char*	mBuffer;
	_UINT32	mLength;
}

- (id)initWithData: (NSData*)data;
- (id)initWithBytes:(const char*)data;

- (_UINT16)	getWord;
- (void)	getString:(char *)str;
- (_UINT32) getSize;
- (_UINT8)	getByte;
- (_UINT32) getUInt32;
- (_UINT64) getUInt64;
- (_FLOAT)	getFloat;
- (_UINT32)	getDecodeLength;
- (void)	getData:(void *)pDes :(_UINT32)length;

@end


