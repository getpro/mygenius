//
//  CCWordPlay.h
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//
//  猜单词

#import "cocos2d.h"
#import "CCPlayWordLayer.h"

@interface CCWordPlay : CCPlayWordLayer <UIAlertViewDelegate>
{
	BOOL m_bIsWaiting;
	
	BOOL        isWin;             //输赢标志
	
	CCLabelTTF *  bombsCountLabel;
    CCSprite   *  bombBGSprite;
}

+(CCScene *) scene;

-(void) NotifiySuccess;
-(void) NotifiyPass;

//Pass
-(void) menuPassCallback:(id) pSender;

//炸弹
-(void) menuZhaDanCallback:(id) pSender;

//删除答案
-(void) menuDelAnswerCallback:(id) pSender;

//模式转换
-(void) menuChangeCallback:(id) pSender;

//回放
-(void) menuReplayCallback:(id) pSender;

//重排
-(void) menuReOrderCallback:(id) pSender;

@end
