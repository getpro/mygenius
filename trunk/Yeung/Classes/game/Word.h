//
//  Word.h
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//

#import "cocos2d.h"

#define WORD_SELECT_COLOR  ccc3( 24,138,153)
#define WORD_ANSWER_COLOR  ccc3(255,200, 28)
#define WORD_WRONG_COLOR   ccc3(255,255,255)

typedef enum Word_State
{
	Word_State_Choice = 0,   //选词区域（淡蓝）
	Word_State_Answer,		 //答案区域（深蓝）
	Word_State_Wrong,		 //答错（红色）
	Word_State_Count
} Word_State;

@interface Word : CCNode
{
	bool m_bHaveWord;
	
	NSString   * m_strFileName;
	
	Word_State   m_eState;
	
	bool m_bMovingSelected;		//移动中被选中
}

@property (nonatomic,assign) bool m_bHaveWord;
@property (nonatomic,assign) Word_State m_eState;
@property (nonatomic,retain) NSString * m_strFileName;

-(void) initWordWithItems:(CCSprite *) pBgNone :(NSString *) pFileName;
+(id)		WordWithItems:(CCSprite *) pBgNone :(NSString *) pFileName;

-(void)		 setFileName:(NSString *) pStr;

-(NSString*) getFileName;

-(void)		 setState:(Word_State) pState;

-(CGRect) getTouchRect;

-(void) setMovingSelected:(bool)pIsSelected;   //移动被替换选中时候，放大效果

-(void) setTouchEndSelected:(bool)pIsSelected;

-(void) setBigAction:(bool)pIsBig;

-(void) setOneClickAction;					//单击以后，放大后缩小的效果

@end
