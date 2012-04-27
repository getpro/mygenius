//
//  CCPlayWordLayer.h
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//
//  点单词，播放单词的基类Layer

#import "cocos2d.h"
#import "Word.h"
#import "GuessData.h"

#define WORD_POS      ccp(200.0f,20.0f)
#define WORD_OFFSET	  ccp( 15.0f,15.0f)

#define ANSWER_POS    ccp( 80.0f,215.0f)
#define ANSWER_OFFSET ccp( 20.0f, 20.0f)

#define CHOICE_NUM (12)

//炸弹一次炸掉的数量
#define BOMB_COUNT (4)

#define FILE_SUFFIX @".png"

#define MAX_11 98
#define MAX_12 296

#define MAX_21 113
#define MAX_22 184

#define MAX_3  186

#define MAX_WORD_INTERVAL (1.0f)

@interface CCPlayWordLayer : CCLayer 
{
	BOOL m_bIsPingYin;					  //拼音模式
	
	BOOL m_bHaveUseBomb;				  //是否使用过炸弹
	
	BOOL m_bIsWrong;				      //答错状态（红色背景）
	
	bool m_bIsMoving;					  //Move一段距离后，视为Moving
	
	bool m_bIsCollision;				  //是否碰撞
	int  m_nCollisionIndex;				  //碰撞的索引
	
	Word * m_pSelectedItem;				  //点击选中的单词
	int  m_nMovingSelected;			      //点击选中的单词的索引
	
	int  m_nLastMovingSelected;			  //上次被移动选中的索引
	
	CFTimeInterval m_LastTime;
	
	int m_nAnswerCount;					  //答案个数
	
	int m_nCurTurn;						  //当前轮数
	int m_nTotalTurn;					  //总轮数
	
	NSMutableArray * m_pAnswerName;		  //答案的中文
	
	NSMutableArray * m_pWordArr;		  //选单词和答案
	
	//拼音
	NSMutableArray * m_pChoiceArr1;		  //12个选择答案(Array嵌套Array)
	NSMutableArray * m_pAnswerArr1;		  //答案(Array嵌套Array)
	
	//部首
	NSMutableArray * m_pChoiceArr2;		  //12个选择答案(Array嵌套Array)
	NSMutableArray * m_pAnswerArr2;		  //答案(Array嵌套Array)
	
	NSMutableArray * m_pTempAnswerArr;	  //部首选择的临时答案(最多2个)
	BOOL             m_bIsCheckAnswer;	  //检测答案，不响应点击
	
	NSMutableArray * m_pReplayListArr;    //单词播放动作的列表
	BOOL             m_bImmediateShow;	  //立刻显示
	BOOL             m_bIsReplay;		  //回放模式
}

@property (nonatomic,retain) NSMutableArray   * m_pWordArr;
@property (nonatomic,retain) Word			  * m_pSelectedItem;

-(void) NotifiySuccess;		      //通知子类对题成功
-(void) NotifiyPass;		      //通知子类对题失败
-(void) NotifiyBomb;		      //通知子类炸弹
-(void) NotifiyChangeMode;		  //通知子类切换模式

-(void) InitAnswerArea;	          //初始化答案区域
-(void) InitWordArea;	          //选择单词区域

-(void) InitWordPlay;
-(void) InitWordRePlay;

-(void) LoadWordPlay;			  //加载单词点击过程

-(void) DoReplayEvent:(OC_Guess_Event*) pEvent;	 //执行回放事件

/* 动作 */
-(void) oneClick:(int) pDeleteIndex     :(int) pAddIndex;	     //一次点击，删除后和再添加

-(void) oneReplage:(int) pSelectedIndex :(int) pCollisionIndex;  //一次交换

-(void) oneClickBuShou:(int) pIndex;							 //点击部首

-(void) ReOrderChoice;										     //对选词区域重新排序

-(void) RemoveAnswer;											 //移除答案重现选择

-(void) UseBomb;												 //使用炸弹

-(void) Pass;													 //跳过（没有猜出来）

-(void) Success;												 //猜对

-(void) ChangeMode;												 //模式改变

@end
