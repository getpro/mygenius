/*
 *  common.h
 *  DrawSomeThing
 *
 *  Created by Peteo on 12-4-6.
 *  Copyright 2012 The9. All rights reserved.
 *
 *  画和猜的过程记录(iOS和Android通用)
 */

#ifndef _COMMON_H
#define	_COMMON_H

#include "PacketDefine.h"

//画的数据
typedef struct _Draw_Data
{
	_FLOAT m_fX;
	_FLOAT m_fY;
	_FLOAT m_fTime;
} Draw_Data;

//画的事件

typedef enum PaintTool_Type_tag
{
	PaintTool_Type_Pen = 0,
	PaintTool_Type_Eraser,
	PaintTool_Type_Clear,
	PaintTool_Type_Count
}PaintTool_Type_tag;

typedef struct _Draw_Event
{
	_UINT8  m_nSize;	//粗细
	_UINT32 m_nColor;	//颜色
	_UINT8  m_nTool;	//工具:0:笔   1:橡皮   2:垃圾桶
	_UINT   m_nIndex;	//哪个点发生的动作
} Draw_Event;

//猜的事件

typedef enum Guess_Event_Type
{
	Guess_Event_Type_Delete = 0,	//删除
	Guess_Event_Type_Replace,		//交换
	Guess_Event_Type_ClickBuShou,	//点击部首
	Guess_Event_Type_NextTurn,		//下一个单词
	Guess_Event_Type_ChangeMode,	//交换部首和拼音模式
	Guess_Event_Type_Bomb,			//炸弹
	Guess_Event_Type_Pass,			//跳过（没有猜出来）
	Guess_Event_Type_Success,		//猜对
	Guess_Event_Type_Count
} Guess_Event_Type;

typedef struct _Guess_Event
{
	_UINT8  m_nType;	//事件类型
	_UINT8  m_nIndex;	//选中的位置
	_UINT8  m_nChange;	//交换的位置
	_FLOAT  m_fTime;	//时间
} Guess_Event;

#endif