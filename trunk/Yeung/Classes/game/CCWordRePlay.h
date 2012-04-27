//
//  CCWordRePlay.h
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//

#import "cocos2d.h"
#import "CCPlayWordLayer.h"

@interface CCWordRePlay : CCPlayWordLayer 
{
	CCSprite * m_pWord_Zhadan;
	CCSprite * m_pWord_Mode;
}

+(CCScene *) scene;

-(void) NotifiySuccess;
-(void) NotifiyPass;
-(void) NotifiyBomb;
-(void) NotifiyChangeMode;

//炸弹
-(void) menuZhaDanCallback:(id) pSender;

//删除答案
-(void) menuDelAnswerCallback:(id) pSender;

//返回
-(void) menuCallback:(id) pSender;

-(void) menuSkipCallback:(id) pSender;

//Timer
-(void) gameLoop:		  (ccTime) dt;
-(void) gameImmediateLoop;

@end
