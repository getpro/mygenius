//
//  DrawData.h
//  DrawSomeThing
//
//  Created by Peteo on 12-4-9.
//  Copyright 2012 The9. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Common.h"
//////////////////////////////////
//OC定义的Common中的类型

@interface OC_Draw_Data : NSObject
{
	_FLOAT m_fX;
	_FLOAT m_fY;
	_FLOAT m_fTime;
	
	BOOL   m_bHaveAction;
}

@property (nonatomic,assign) _FLOAT m_fX;
@property (nonatomic,assign) _FLOAT m_fY;
@property (nonatomic,assign) _FLOAT m_fTime;
@property (nonatomic,assign) BOOL   m_bHaveAction;

+(id) DrawDataWithItems:(_FLOAT)pX :(_FLOAT)pY :(_FLOAT)pTime;
-(id) InitDrawData:		(_FLOAT)pX :(_FLOAT)pY :(_FLOAT)pTime;

@end

@interface OC_Draw_Event : NSObject
{
	_UINT8  m_nSize;	//粗细
	_UINT32 m_nColor;	//颜色
	_UINT8  m_nTool;	//工具:0:笔   1:橡皮   2:垃圾桶
	_UINT   m_nIndex;	//哪个点发生的动作
}

@property (nonatomic,assign) _UINT8  m_nSize;
@property (nonatomic,assign) _UINT32 m_nColor;
@property (nonatomic,assign) _UINT8  m_nTool;
@property (nonatomic,assign) _UINT   m_nIndex;

+(id) DrawEventWithItems:(_UINT8)pSize :(_UINT32)pColor :(_UINT8)pTool :(_UINT)pIndex;
-(id) InitDrawEvent:	 (_UINT8)pSize :(_UINT32)pColor :(_UINT8)pTool :(_UINT)pIndex;

@end
//////////////////////////////////
