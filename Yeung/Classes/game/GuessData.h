//
//  GuessData.h
//  DrawSomeThing
//
//  Created by Peteo on 12-4-9.
//  Copyright 2012 The9. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Common.h"

@interface OC_Guess_Event : NSObject 
{
	_UINT8  m_nType;	//事件类型
	_UINT8  m_nIndex;	//选中的位置
	_UINT8  m_nChange;	//交换的位置
	_FLOAT  m_fTime;	//时间
}

@property (nonatomic,assign) _UINT8  m_nType;
@property (nonatomic,assign) _UINT8  m_nIndex;
@property (nonatomic,assign) _UINT8  m_nChange;
@property (nonatomic,assign) _FLOAT  m_fTime;

+(id) GuessEventWithItems:(_UINT8)pType :(_UINT8)pIndex :(_UINT8)pChange :(_FLOAT)pTime;
-(id) InitGuessEvent:	  (_UINT8)pType :(_UINT8)pIndex :(_UINT8)pChange :(_FLOAT)pTime;

@end
