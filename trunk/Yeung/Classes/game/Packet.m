//
//  Packet.m
//  DrawSomething
//
//  Created by Huang Daxin on 4/4/12.
//  Copyright 2012 The9. All rights reserved.
//

#import "Packet.h"

@implementation EncodePacket

- (id)initWithBuffer:(char *)buffer
{
	if ((self = [super init])) 
	{
		mBuffer = buffer;
		//mLength = sizeof(_UINT32);
		mLength = 0;
	}
	return self;
}

- (void) putWord:(_UINT16)value
{
	*(_UINT16*)(mBuffer + mLength) = value;
	mLength += sizeof(_UINT16);
}

- (void) putString:(const char *)str
{
	*(_UINT16*)(mBuffer + mLength) = strlen(str);
	mLength += sizeof(_UINT16);
	memcpy(mBuffer + mLength, str, strlen(str));
	mLength += strlen(str);
}

- (void) putSize
{
	*(_UINT32*)(mBuffer) = mLength;
}

- (_UINT32) getSize
{
	return mLength;
}

- (void) putByte:(_UINT8)value
{
	*(char*)(mBuffer + mLength) = value;
	mLength += sizeof(_UINT8);
}

- (void) putUInt32:(_UINT32)value
{
	*(_UINT32*)(mBuffer + mLength) = value;
	mLength += sizeof(_UINT32);
}

- (void) putUInt64:(_UINT64)value
{
	*(_UINT64*)(mBuffer + mLength) = value;
	mLength += sizeof(_UINT64);
}

- (void) putFloat:(_FLOAT)value
{
	*(_FLOAT*)(mBuffer + mLength) = value;
	mLength += sizeof(_FLOAT);
}

- (void) putData:(const void *)pData :(_UINT32)length
{
	memcpy(mBuffer + mLength, pData, length);
	mLength += length;
}

@end


@implementation DecodePacket

- (id)initWithData:(NSData*)data
{
	if ((self = [super init])) 
	{
		mBuffer = (char *)[data bytes];
		mLength = 0;
	}
	return self;
}

- (id)initWithBytes:(const char*)data
{
	if ((self = [super init])) 
	{
		mBuffer = (char*)data;
		mLength = 0;
	}
	return self;
}

- (_UINT16)	getWord
{
	_UINT16 value = (*(_UINT16*)(mBuffer+mLength));
	mLength += sizeof(_UINT16);
	return value;
}

- (void)	getString:(char *)str
{
	_UINT16 bufferLength;
	bufferLength = *(_UINT16*)(mBuffer+mLength);
	mLength += sizeof(_UINT16);
	
	memcpy( str, (char*)(mBuffer+mLength), bufferLength);
	mLength += bufferLength;
}

- (_UINT32)  getSize
{
	return *(_UINT32*)(mBuffer);
}

- (_UINT8)	getByte
{
	_UINT8 value = *(_UINT8*)(mBuffer+mLength);
	mLength += sizeof(_UINT8);
	return value;
}

- (_UINT32) getUInt32
{
	_UINT32 value = (*(_UINT32*)(mBuffer+mLength));
	mLength += sizeof(_UINT32);
	return value;
}

- (_UINT64) getUInt64
{
	_UINT64 value = (*(_UINT64*)(mBuffer+mLength));
	mLength += sizeof(_UINT64);
	return value;
}

- (_FLOAT)	getFloat
{
	_FLOAT value = *(_FLOAT*)(mBuffer + mLength);
	mLength += sizeof(_FLOAT);
	return value;
}

- (_UINT32)	getDecodeLength
{
	return mLength;
}

- (void)	getData:(void *)pDes :(_UINT32)length
{
	memcpy(pDes,mBuffer + mLength,length);
	mLength += length;
}

@end