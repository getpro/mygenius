//
//  CCPaint.h
//  DrawSomeThing
//
//  Created by Peteo on 12-3-31.
//  Copyright 2012 The9. All rights reserved.
//

#import "cocos2d.h"
#import "PacketDefine.h"

//#define PAINT_SIZE_W (768.0f)
//#define PAINT_SIZE_H (802.0f)

#define PAINT_SIZE_W (640.0f)
#define PAINT_SIZE_H (668.0f)

#define PAINT_SIZE_H_SMALL (285.0f)

#define PAINT_POS_X  (0.0f)
#define PAINT_POS_Y  (0.0f)

#define MAX_PAINT_INTERVAL ( 3.0f)

@interface CCPaint : CCLayer
{
	EAGLView       *GLview;
    UIView         *tmpView;
	
	CCRenderTexture * strokesTexture;
	
	CCSprite* brush;
	
	BOOL             m_bIsRecycling;	  //正在翻页
	
	NSMutableArray * m_pDrawTrackArr;	  //点数据
	NSMutableArray * m_pDrawActionArr;	  //画的动作
	BOOL             m_bImmediateShow;	  //立刻显示
	
	CFTimeInterval   m_LastTime;
	
	int  replaycurpoint;
	bool isreplaying;
	bool isreplayingpaused;
}

@property (nonatomic,retain) NSMutableArray * m_pDrawTrackArr;
@property (nonatomic,retain) NSMutableArray * m_pDrawActionArr;

@property (nonatomic,assign) BOOL m_bIsRecycling;

+(id) nodeWithFlag:(BOOL)pIsSmall;
-(id) initWithFlag:(BOOL)pIsSmall;

//添加动作
- (void) AddPaintAction:(int) pToolType :(int) pColor :(int) pSize;

//设置画刷颜色
- (void) setPenColor :(_UINT32)pColor;

//设置画刷粗细
- (void) setPenSize  :(int)pSize;

//播放
- (void) replay :(BOOL)pSelf;

//回放时候检测动作
- (void) CheckAction;

//保存数据
- (void) saveplay;

//重画
- (void) RecyclePaint;

//在画布上画笔画
- (void) drawToStrokeTexture:(CGPoint)start end:(CGPoint)end remember:(bool)remember;

@end
