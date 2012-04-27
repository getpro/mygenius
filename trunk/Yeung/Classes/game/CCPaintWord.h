//
//  CCPaintWord.h
//  DrawSomeThing
//
//  Created by Peteo on 12-3-31.
//  Copyright 2012 The9. All rights reserved.
//
//  画单词界面

#import "cocos2d.h"

#import "PacketDefine.h"
#import "ColorButton.h"

#define COLOR_SCROLL_WIDTH  (275)
#define COLOR_SCROLL_HEIGTH (35)

@interface CCPaintWord : CCLayer
{
	_UINT32 m_nPenColor;
	int		m_nPenSize;
	
	UIScrollView * m_pColorScrollView;
	
	BOOL m_bIsWaiting;
	
	ColorButton  * LastColorButton;
}

+(CCScene *) scene;

-(void) LoadColor;
-(void) colorButtonCallback:(id)pSender;

//完成
-(void) menuDoneCallback:(id) pSender;

//重新画
-(void) menuRecycleCallback:(id) pSender;

//更多颜色
-(void) menuMoreColorCallback:(id) pSender;

-(void) buyColorCallback;

-(void) menuPenPopUpCallback:(id)	 pSender;
-(void) menuEraserPopUpCallback:(id) pSender;

//选择画笔大小
-(void) menuPenCallback:(id)    pSender;

//选择橡皮大小
-(void) menuEraserCallback:(id) pSender;

@end
