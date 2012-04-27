//
//  PacketDefine.h
//  DrawSomething
//
//  Created by Huang Daxin on 4/3/12.
//  Copyright 2012 The9. All rights reserved.
//

#ifndef PACKETDEFINE_H
#define	PACKETDEFINE_H

#define MAX_BUFFER_SIZE     (65536)		//64k

#include <stdio.h>

typedef unsigned char	_UCHAR;			//标准无符号CHAR
typedef char			_CHAR;			//标准CHAR
typedef unsigned int	_UINT;			//标准无符号INT
typedef int				_INT;			//标准INT
typedef signed char		_INT8;			//标准8位
typedef unsigned char	_UINT8;			//标准无符号8位
typedef	signed short	_INT16;			//标准16位
typedef	unsigned short	_UINT16;		//标准无符号16位
typedef	signed int		_INT32;			//标准32位
typedef	unsigned int	_UINT32;		//标准无符号32位
typedef long long			_INT64;		//标准64位
typedef unsigned long long  _UINT64;	//标准无符号64位
typedef unsigned short	_USHORT;		//标准无符号short
typedef short			_SHORT;			//标准short
typedef unsigned long	_ULONG;			//标准无符号LONG(不推荐使用)
typedef long			_LONG;			//标准LONG(不推荐使用)
typedef float			_FLOAT;			//标准float

typedef bool			_BOOL;
typedef _UCHAR			_BYTE;
typedef	unsigned short	_WORD;
typedef	unsigned long	_DWORD;
typedef	void			_VOID;
typedef	void*			_PVOID;

#define MAKE_RGB(r, g, b) (_UINT32) ( ((_UINT32)(r) << 8) + ((_UINT32)(g) << 16) + ((_UINT32)(b) << 24) )

#define	GET_RED(Color)		(((Color) >>  8) & 0xFF)
#define	GET_GREEN(Color)	(((Color) >> 16) & 0xFF)
#define	GET_BLUE(Color)		(((Color) >> 24) & 0xFF)

//清空内存内容
#ifndef ZEROMEMORY
#define	ZEROMEMORY(p, size)	memset(p, 0, size)
#endif
//根据指针值删除内存
#ifndef SAFE_DELETE
#define SAFE_DELETE(x)	if( (x)!=NULL ) { delete (x); (x)=NULL; }
#endif
//根据指针值删除数组类型内存
#ifndef SAFE_DELETE_ARRAY
#define SAFE_DELETE_ARRAY(x)	if( (x)!=NULL ) { delete[] (x); (x)=NULL; }
#endif
//根据指针调用free接口
#ifndef SAFE_FREE
#define SAFE_FREE(x)	if( (x)!=NULL ) { free(x); (x)=NULL; }
#endif
//根据指针调用Release接口
#ifndef SAFE_RELEASE
#define SAFE_RELEASE(x)	if( (x)!=NULL ) { (x)->Release(); (x)=NULL; }
#endif

#define	MakeUint32(a, b)	((_UINT32)(((_UINT16)(a)) | ((_UINT32)((_UINT16)(b))) << 16))
#define LoWord(l)			((_UINT16)(l))
#define HiWord(l)			((_UINT16)(((_UINT32)(l) >> 16) & 0xFFFF))

#endif