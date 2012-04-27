//
//  CCPopup.h
//  DrawSomeThing
//
//  Created by Peteo on 12-4-3.
//  Copyright 2012 The9. All rights reserved.
//

#import "cocos2d.h"
#import "CCRadioMenu.h"

#define MAX_POPUP_ITEM (10)

@interface CCPopup : CCLayer 
{
	CCRadioMenu * m_pMenu;
	
	BOOL     m_bIsExpanded;
	
	SEL      m_pCB;
	id       m_pTarget;
	int      m_nIndex;
	
	CGPoint  m_pPosArr[MAX_POPUP_ITEM];
}

@property (nonatomic,assign) SEL m_pCB;
@property (nonatomic,assign) id  m_pTarget;

-(void) menuCallback:(id) pSender;

//延时回调
-(void) menuDelayedCallback:(ccTime)dt;

/** 点击主菜单 */
-(void) ClickMainMenu;

/** 展开菜单 */
-(void) ExpandMenu;

/** 闭合菜单 */
-(void) ShrinkMenu;

@end
