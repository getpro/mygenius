//
//  Word.m
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//

#import "Word.h"

#define WORD_ACTION_TIME (0.1f)
#define WORD_ACTION_BIG  (1.3f)

@interface Word (Private)
-(void) setAllBg:(BOOL)pVisible;
@end

@implementation Word

@synthesize m_bHaveWord;
@synthesize m_eState;
@synthesize m_strFileName;

typedef enum Word_Tag
{
	Word_Tag_Choice_Bg = 1,		//背景,有单词(选词区域)
	Word_Tag_Answer_Bg,			//背景,有单词(答案区域)
	Word_Tag_Wrong_Bg,			//背景,有单词(答错)
	
	Word_Tag_None_Bg,			//空背景，没有单词
	Word_Tag_Word_Sprite,		//单词图片
	
	Word_Tag_Count	
} Word_Tag;

- (void) dealloc
{
	[m_strFileName release];
    
	[super  dealloc];
}

- (id)init
{
	if ((self = [super init]))
    {
		m_strFileName     = nil;
		
		m_bHaveWord       = false;
		m_bMovingSelected = false;
		
		m_eState          = Word_State_Choice;
    }
    return self;
}

- (void)setState:(Word_State) pState
{
	m_eState = pState;
	
	
}

- (void)setFileName:(NSString *) pStr
{
	if(pStr)
	{
		m_bHaveWord        = true;
		
		self.m_strFileName = pStr;
		
		[self setAllBg:NO];
		
		switch (m_eState) 
		{
			case Word_State_Choice:
			{
				CCSprite * word_choice = (CCSprite*)[self getChildByTag:Word_Tag_Choice_Bg];
				if(word_choice)
				{
					word_choice.visible = YES;
				}
			}
				break;
			case Word_State_Answer:
			{
				CCSprite * word_answer = (CCSprite*)[self getChildByTag:Word_Tag_Answer_Bg];
				if(word_answer)
				{
					word_answer.visible = YES;
				}
			}
				break;
			case Word_State_Wrong:
			{
				CCSprite * word_wrong  = (CCSprite*)[self getChildByTag:Word_Tag_Wrong_Bg];
				if(word_wrong)
				{
					word_wrong.visible = YES;
				}
			}
				break;
			default:
				break;
		}
		
		CCSprite * pBgNone  = (CCSprite*)[self getChildByTag:Word_Tag_None_Bg];
		if(pBgNone)
		{
			pBgNone.visible = NO;
		}
		
		CCSprite * old_word_sprite = (CCSprite*)[self getChildByTag:Word_Tag_Word_Sprite];
		if(old_word_sprite)
		{
			[self removeChild:old_word_sprite cleanup:YES];
		}
		
		CCSprite * new_word_sprite = [CCSprite spriteWithFile:pStr];
		if(new_word_sprite)
		{
			//new_word_sprite.position = ccp(6,5);
			[self addChild:new_word_sprite z:0 tag:Word_Tag_Word_Sprite];
			switch (m_eState)
			{
				case Word_State_Choice:
				{
					new_word_sprite.color = WORD_SELECT_COLOR;
				}
					break;
				case Word_State_Answer:
				{
					new_word_sprite.color = WORD_ANSWER_COLOR;
				}
					break;
				case Word_State_Wrong:
				{
					new_word_sprite.color = WORD_WRONG_COLOR;
				}
					break;
				default:
					break;
			}
		}
	}
	else
	{
		//删除单词
		m_bHaveWord = false;
		
		self.m_strFileName = nil;
		
		[self setAllBg:NO];
		
		CCSprite * word_sprite = (CCSprite*)[self getChildByTag:Word_Tag_Word_Sprite];
		if(word_sprite)
		{
			[self removeChild:word_sprite cleanup:YES];
		}
		
		CCSprite * pBgNone  = (CCSprite*)[self getChildByTag:Word_Tag_None_Bg];
		if(pBgNone)
		{
			pBgNone.visible = YES;
		}
	}
}

-(NSString *) getFileName
{
	return m_strFileName;
}

-(CGRect) getTouchRect
{
	return CGRectMake(self.position.x - self.contentSize.width/2,
					  self.position.y - self.contentSize.height/2,
					  self.contentSize.width,
					  self.contentSize.height);
}

-(void) setMovingSelected:(bool)pIsSelected
{
	if(pIsSelected)
	{
		if(!m_bMovingSelected)
		{
			[self setBigAction:true];
			
			m_bMovingSelected = true;
		}
	}
	else
	{
		if(m_bMovingSelected)
		{
			//[self setBigAction:false];
			
			[self setOneClickAction];
			
			m_bMovingSelected = false;
		}
	}
}

-(void) setTouchEndSelected:(bool)pIsSelected
{
	if(pIsSelected)
	{
		if(!m_bMovingSelected)
		{
			[self setBigAction:true];
			
			m_bMovingSelected = true;
		}
	}
	else
	{
		if(m_bMovingSelected)
		{
			[self setBigAction:false];
			
			m_bMovingSelected = false;
		}
	}
}

-(void) setBigAction:(bool) pIsBig
{
	if(pIsBig)
	{
		CCScaleTo *  ScaleTo = [CCScaleTo actionWithDuration:WORD_ACTION_TIME scale:WORD_ACTION_BIG];
		[self runAction:ScaleTo];
	}
	else
	{
		CCScaleTo *  ScaleTo = [CCScaleTo actionWithDuration:WORD_ACTION_TIME scale:1.0f];
		[self runAction:ScaleTo];
	}
}

-(void) setOneClickAction
{
	CCScaleTo *  ScaleTo1 = [CCScaleTo  actionWithDuration:WORD_ACTION_TIME scale:WORD_ACTION_BIG];
	CCScaleTo *  ScaleTo2 = [CCScaleTo  actionWithDuration:WORD_ACTION_TIME scale:1.0f];
	
	CCSequence *  ScaleTo  = [CCSequence actions:ScaleTo1,ScaleTo2,nil];
	
	[self runAction:ScaleTo];
}

+(id) WordWithItems:(CCSprite *) pBgNone :(NSString *) pFileName
{
	id pRet = [[[self alloc] init] autorelease];
	[pRet initWordWithItems:pBgNone :pFileName];
	return pRet;
}

-(void) initWordWithItems:(CCSprite *) pBgNone :(NSString *) pFileName
{
	CCSprite * word_choice = [CCSprite spriteWithSpriteFrameName:@"word_choice.png"];
	[self addChild:word_choice z:0 tag:Word_Tag_Choice_Bg];
	word_choice.visible = NO;
	
	[self setContentSize:word_choice.contentSize];
	
	CCSprite * word_answer = [CCSprite spriteWithSpriteFrameName:@"word_answer.png"];
	[self addChild:word_answer z:0 tag:Word_Tag_Answer_Bg];
	word_answer.visible = NO;
	
	CCSprite * word_wrong = [CCSprite spriteWithSpriteFrameName:@"word_wrong.png"];
	[self addChild:word_wrong z:0 tag:Word_Tag_Wrong_Bg];
	word_wrong.visible = NO;
	
	if(pBgNone)
	{
		[self addChild:pBgNone z:0 tag:Word_Tag_None_Bg];
	}
	
	if(pFileName)
	{
		self.m_strFileName = pFileName;
		
		CCSprite * word_sprite = [CCSprite spriteWithFile:pFileName];
		if(word_sprite)
		{
			//word_sprite.position = ccp(6,5);
			[self addChild:word_sprite z:0 tag:Word_Tag_Word_Sprite];
			word_sprite.color = WORD_SELECT_COLOR;
		}
	}
}

-(void) setAllBg:(BOOL)pVisible
{
	CCSprite * word_choice = (CCSprite*)[self getChildByTag:Word_Tag_Choice_Bg];
	if(word_choice)
	{
		word_choice.visible = pVisible;
	}
	
	CCSprite * word_answer = (CCSprite*)[self getChildByTag:Word_Tag_Answer_Bg];
	if(word_answer)
	{
		word_answer.visible = pVisible;
	}
	
	CCSprite * word_wrong  = (CCSprite*)[self getChildByTag:Word_Tag_Wrong_Bg];
	if(word_wrong)
	{
		word_wrong.visible = pVisible;
	}
}

@end
