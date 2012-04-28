//
//  CCPlayWordLayer.m
//  DrawSomeThing
//
//  Created by Peteo on 12-3-29.
//  Copyright 2012 The9. All rights reserved.
//

#import "CCPlayWordLayer.h"
#import "CCMACRO.h"


//#import "GuessWordResult.h"

static NSString* gALPHA[26] = 
{
	@"A",@"B",@"C",@"D",@"E",
	@"F",@"G",@"H",@"I",@"J",
	@"K",@"L",@"M",@"N",@"O",
	@"P",@"Q",@"R",@"S",@"T",
	@"U",@"V",@"W",@"X",@"Y",
	@"Z"
};

@interface CCPlayWordLayer (Private)

-(void) ChangeToPinYin;			  //切换到拼音
-(void) ChangeToBuShou;			  //切换到部首
-(void) CheckUseBomb;			  //切换时候，需要检测是否用过炸弹
-(void) ShowBuShouWrong;	      //显示部首答错提示
-(void) ShowAnswerName;	          //显示答对的中文
-(void) AnswerMoveToName;		  //答案移动到中文的效果
-(void) SetNextTurn;			  //进入下一个单词
-(void) CheckAnswer;			  //检查答案是否正确
-(void) ClickChoice:(int) pIndex; //点击单词选择区域的单词
-(void) ClickAnswer:(int) pIndex; //点击答案区域的单词
-(int)  FindIdleAnswer;		      //找出空闲的答案区域
-(int)  FindIdleChoice;		      //找出空闲的选词区域
-(int)  FindWrongChoice;	      //找出一个错误的选择
-(int)  FindLastWord:(int) pLocationIndex;	//找离这个空单词最近位置的单词
-(Word*)itemForTouch:(CGPoint) pLocation :(int*) OutIndex; //找出点击哪个Word
-(Word*)itemByFileName:(NSString*)pFileName;	//通过文件名找出Word
-(void) CheckCollision;           //检测碰撞
@end

@implementation CCPlayWordLayer

@synthesize m_pWordArr;
@synthesize m_pSelectedItem;

typedef enum PlayWordLayer_Tag
{
	PlayWordLayer_AnswerSelBg_tag = 5,   //选中框背景
	PlayWordLayer_AnswerSel_Arrow_tag,   //选中框箭头
	
	PlayWordLayer_WordBlue_BG_tag,		 //蓝色背景(错误时红色)
	PlayWordLayer_BuShouBlue_BG_tag,	 //部首蓝色背景
	PlayWordLayer_WordRed_BG_tag,	     //红色背景
	
	PlayWordLayer_PinYin_Answer_Name_tag = 100,  //拼音中文名字(背景格子)
	PlayWordLayer_PinYin_Label_tag = 110,		 //拼音中文名字
	
	PlayWordLayer_BuShou_Answer_Name_tag = 150,  //部首中文名字(背景格子)
	PlayWordLayer_BuShou_Label_tag = 160,		 //部首中文名字
	
	PlayWordLayer_Tag_Count
}PlayWordLayer_Tag;

typedef enum PlayWordLayer_Z
{
	PlayWordLayer_Z_WordBigBG = 1,   //蓝色背景
	PlayWordLayer_Z_Word,
	PlayWordLayer_Z_Count
}PlayWordLayer_Z;

-(id) init
{
	if( (self=[super init])) 
	{
		m_bIsPingYin = YES;
		
		self.isTouchEnabled			= YES;
		self.isAccelerometerEnabled = YES;
		
		m_pWordArr			  = [[NSMutableArray alloc]initWithCapacity:0];
		m_pReplayListArr      = [[NSMutableArray alloc]initWithCapacity:0];
		m_pAnswerName         = [[NSMutableArray alloc]initWithCapacity:0];
		
		m_pChoiceArr1          = [[NSMutableArray alloc]initWithCapacity:0];
		m_pAnswerArr1          = [[NSMutableArray alloc]initWithCapacity:0];
		
		m_pChoiceArr2          = [[NSMutableArray alloc]initWithCapacity:0];
		m_pAnswerArr2          = [[NSMutableArray alloc]initWithCapacity:0];
		
		m_pTempAnswerArr       = [[NSMutableArray alloc]initWithCapacity:0];
		
		m_LastTime = CFAbsoluteTimeGetCurrent();
		
		m_bIsMoving			  = false;
		
		m_bIsCollision        = false;
		
		m_bHaveUseBomb        = NO;
		
		m_bImmediateShow	  = NO;
		
		m_bIsWrong            = NO;
		
		m_bIsReplay           = NO;
		
		m_bIsCheckAnswer      = NO;
		
		m_pSelectedItem		  = nil;
		
		m_nLastMovingSelected = -1;
		m_nMovingSelected     = -1;
		m_nCollisionIndex     = -1;
		
		m_nCurTurn            = 0;
	}
	return self;
}

-(void) InitWordPlay
{
	/*
	NSLog(@"CurWord[%@][%@]",[GameEngine GetInstance].m_pCurWord.word_name
		  ,[GameEngine GetInstance].m_pCurWord.word_pinying);
	*/
	
	[m_pAnswerArr1 removeAllObjects];
	[m_pChoiceArr1 removeAllObjects];
	
	//NSString * pStrWordName = [GameEngine GetInstance].m_pCurWord.word_name;
	NSString * pStrWordName = @"魔兽世界";
	
	//拼音
	/*
	NSArray * pPinYinArr = [[GameEngine GetInstance].m_pCurWord.word_pinying 
							componentsSeparatedByString:@"|"];
	*/
	NSString * word_pinying = @"MO|SHOU|SHI|JIE";
	
	NSArray * pPinYinArr = [word_pinying componentsSeparatedByString:@"|"];
	
	for(int i = 0; i < [pPinYinArr count]; i ++)
	{
		NSString * pStr = (NSString*)[pPinYinArr objectAtIndex:i];
		
		NSMutableArray * pStrArr = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
		
		for(int j = 0; j < [pStr length];j++)
		{
			NSMutableString * pTemp = [NSMutableString stringWithCapacity:0];
			
			[pTemp appendString:[pStr substringWithRange:NSMakeRange(j,1)]];
			
			[pTemp appendString:FILE_SUFFIX];
			
			[pStrArr addObject:pTemp];
		}
		
		[m_pAnswerArr1 addObject:pStrArr];
	}
	
	NSMutableArray * pStrArr = (NSMutableArray*)[m_pAnswerArr1 objectAtIndex:m_nCurTurn];
	
	m_nAnswerCount = [pStrArr count];
	
	m_nTotalTurn   = [pStrWordName length];
	
	for (int i = 0; i < [pStrWordName length]; i ++) 
	{
		[m_pAnswerName addObject:[pStrWordName substringWithRange:NSMakeRange(i,1)]];
	}
	
	srand((unsigned)time(NULL));
	
	//拼音随机产生选择答案
	for (int i = 0; i < [m_pAnswerArr1 count]; i++) 
	{
		NSMutableArray * pAnswerArr = (NSMutableArray*)[m_pAnswerArr1 objectAtIndex:i];
		if(pAnswerArr == nil)
		{
			continue;
		}
		
		NSMutableArray * pChoiceArr = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
		
		for(int j = 0; j < (CHOICE_NUM - [pAnswerArr count]);j++)
		{
			NSMutableString * pTemp = [NSMutableString stringWithCapacity:0];
			
			int pIndex = arc4random()%26;
			
			[pTemp appendString:gALPHA[pIndex]];
			
			[pTemp appendString:FILE_SUFFIX];
			
			[pChoiceArr addObject:pTemp];
		}
		
		for(int j = 0; j < [pAnswerArr count];j++)
		{
			NSMutableString * pTemp = [NSMutableString stringWithCapacity:0];
			
			int pIndex = arc4random()%[pChoiceArr count];
			
			[pTemp appendString:[pAnswerArr objectAtIndex:j]];
			
			[pChoiceArr insertObject:pTemp atIndex:pIndex];
		}
		
		[m_pChoiceArr1 addObject:pChoiceArr];
	}
	
	NSLog(@"%@",m_pChoiceArr1);
	NSLog(@"%@",m_pAnswerArr1);
	
	//部首
	[m_pAnswerArr2 removeAllObjects];
	[m_pChoiceArr2 removeAllObjects];
	
	/*
	NSArray * pBuShouArr = [[GameEngine GetInstance].m_pCurWord.word_struct 
								  componentsSeparatedByString:@";"];
	*/
	
	NSString * word_struct = @"3%98;2%68,123;3%152;2%39,41";
	NSArray  * pBuShouArr = [word_struct componentsSeparatedByString:@";"];
	
	for(int i = 0; i < [pBuShouArr count]; i ++)
	{
		NSMutableArray * pStrAnswerArr = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
		
		NSString * pStr = (NSString*)[pBuShouArr objectAtIndex:i];
		
		NSArray * pStructArr = [pStr componentsSeparatedByString:@"%"];
		
		if([pStructArr count] != 2)
			return;
		
		NSString * pStructStr = (NSString*)[pStructArr objectAtIndex:0];
		NSString * pPicStr    = (NSString*)[pStructArr objectAtIndex:1];
		
		NSInteger StructNum = [pStructStr intValue];
		
		NSArray * pPicArr = [pPicStr componentsSeparatedByString:@","];
		
		if([pPicArr count] == 0)
			return;
		
		for (int j = 0; j < [pPicArr count]; j ++)
		{
			NSString * pPicName = (NSString*)[pPicArr objectAtIndex:j];
			
			[pStrAnswerArr addObject:[NSString stringWithFormat:@"%d%d%@%@",StructNum,(j+1)
									  ,[NSString stringWithFormat:@"%06d",[pPicName intValue]]
									  ,FILE_SUFFIX]];
		}
		
		[m_pAnswerArr2 addObject:pStrAnswerArr];
	}
	
	//部首随机产生选择答案
	for (int i = 0; i < [m_pAnswerArr2 count]; i++) 
	{
		NSMutableArray * pBuShouAnswerArr = (NSMutableArray*)[m_pAnswerArr2 objectAtIndex:i];
		if(pBuShouAnswerArr == nil)
		{
			continue;
		}
		
		NSMutableArray * pBuShouChoiceArr = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
		
		for(int j = 0; j < (CHOICE_NUM - [pBuShouAnswerArr count]);j++)
		{
			NSMutableString * pTemp = [NSMutableString stringWithCapacity:0];
			
			//
			NSString * pStructStr = [pBuShouAnswerArr objectAtIndex:0];
			NSInteger  pStructNum = [[pStructStr substringWithRange:NSMakeRange(0,1)] intValue];
			
			if(pStructNum == 3)
			{
				//单字结构
				
				int pIndex = arc4random() % MAX_3 + 1;
				
				[pTemp appendString:[NSString stringWithFormat:@"31%06d",pIndex]];
			}
			else
			{
				//左右和上下结构
				int pIndex = arc4random() % 2;
				if(pIndex == 0)
				{
					//1
					int pIndex2 = arc4random() % 2;
					if(pIndex2 == 0)
					{
						//1
						int pIndex3 = arc4random() % MAX_11 + 1;
						[pTemp appendString:[NSString stringWithFormat:@"11%06d",pIndex3]];
					}
					else
					{
						//2
						int pIndex3 = arc4random() % MAX_12 + 1;
						[pTemp appendString:[NSString stringWithFormat:@"12%06d",pIndex3]];
					}
				}
				else 
				{
					//2
					int pIndex2 = arc4random() % 2;
					if(pIndex2 == 0)
					{
						int pIndex3 = arc4random() % MAX_21 + 1;
						[pTemp appendString:[NSString stringWithFormat:@"21%06d",pIndex3]];
					}
					else
					{
						int pIndex3 = arc4random() % MAX_22 + 1;
						[pTemp appendString:[NSString stringWithFormat:@"22%06d",pIndex3]];
					}
				}
			}
			
			[pTemp appendString:FILE_SUFFIX];
			
			[pBuShouChoiceArr addObject:pTemp];
		}
		
		for(int j = 0; j < [pBuShouAnswerArr count];j++)
		{
			NSMutableString * pTemp = [NSMutableString stringWithCapacity:0];
			
			int pIndex = arc4random()%[pBuShouChoiceArr count];
			
			[pTemp appendString:[pBuShouAnswerArr objectAtIndex:j]];
			
			[pBuShouChoiceArr insertObject:pTemp atIndex:pIndex];
		}
		
		[m_pChoiceArr2 addObject:pBuShouChoiceArr];
	}
	
	//NSLog(@"%@",m_pChoiceArr2);
	//NSLog(@"%@",m_pAnswerArr2);
}

-(void) InitWordRePlay
{
	/*
	NSLog(@"ReplayWord[%@][%@]",[GameEngine GetInstance].m_pReplayWord.word_name
		  ,[GameEngine GetInstance].m_pReplayWord.word_pinying);
	*/
	
	[m_pAnswerArr1 removeAllObjects];
	[m_pAnswerArr2 removeAllObjects];
	
	//NSString * pStrWordName = [GameEngine GetInstance].m_pReplayWord.word_name;
	
	NSString * pStrWordName = nil;
	
	//拼音
	/*
	NSArray * pPinYinArr = [[GameEngine GetInstance].m_pReplayWord.word_pinying 
							componentsSeparatedByString:@"|"];
	*/
	NSArray * pPinYinArr = nil;
	
	for(int i = 0; i < [pPinYinArr count]; i ++)
	{
		NSString * pStr = (NSString*)[pPinYinArr objectAtIndex:i];
		
		NSMutableArray * pStrArr = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
		
		for(int j = 0; j < [pStr length];j++)
		{
			NSMutableString * pTemp = [NSMutableString stringWithCapacity:0];
			
			[pTemp appendString:[pStr substringWithRange:NSMakeRange(j,1)]];
			
			[pTemp appendString:FILE_SUFFIX];
			
			[pStrArr addObject:pTemp];
		}
		
		[m_pAnswerArr1 addObject:pStrArr];
	}
	
	//部首
	/*
	NSArray * pBuShouArr = [[GameEngine GetInstance].m_pReplayWord.word_struct
							componentsSeparatedByString:@";"];
	*/
	
	NSArray * pBuShouArr = nil;
	
	for(int i = 0; i < [pBuShouArr count]; i ++)
	{
		NSMutableArray * pStrAnswerArr = [[[NSMutableArray alloc]initWithCapacity:0] autorelease];
		
		NSString * pStr = (NSString*)[pBuShouArr objectAtIndex:i];
		
		NSArray * pStructArr = [pStr componentsSeparatedByString:@"%"];
		
		if([pStructArr count] != 2)
			return;
		
		NSString * pStructStr = (NSString*)[pStructArr objectAtIndex:0];
		NSString * pPicStr    = (NSString*)[pStructArr objectAtIndex:1];
		
		NSInteger StructNum = [pStructStr intValue];
		
		NSArray * pPicArr = [pPicStr componentsSeparatedByString:@","];
		
		if([pPicArr count] == 0)
			return;
		
		for (int j = 0; j < [pPicArr count]; j ++)
		{
			NSString * pPicName = (NSString*)[pPicArr objectAtIndex:j];
			
			[pStrAnswerArr addObject:[NSString stringWithFormat:@"%d%d%@%@",StructNum,(j+1)
									  ,[NSString stringWithFormat:@"%06d",[pPicName intValue]]
									  ,FILE_SUFFIX]];
		}
		
		[m_pAnswerArr2 addObject:pStrAnswerArr];
	}
	
	NSMutableArray * pStrArr = (NSMutableArray*)[m_pAnswerArr1 objectAtIndex:m_nCurTurn];
	
	m_nAnswerCount = [pStrArr count];
	
	m_nTotalTurn   = [pStrWordName length];
	
	for (int i = 0; i < [pStrWordName length]; i ++) 
	{
		[m_pAnswerName addObject:[pStrWordName substringWithRange:NSMakeRange(i,1)]];
	}
	
	//
	//NSLog(@"%@",m_pChoiceArr1);
	//NSLog(@"%@",m_pAnswerArr1);
	//NSLog(@"%@",m_pChoiceArr2);
	//NSLog(@"%@",m_pAnswerArr2);
}

-(void) InitWordArea
{
	CGSize size = [CCDirector sharedDirector].winSize;
	
	CCSprite * LanSeBg  = (CCSprite*)[self getChildByTag:PlayWordLayer_WordBlue_BG_tag];
	if(LanSeBg)
	{
		[self removeChild:LanSeBg cleanup:YES];
	}
	
	CCSprite * HongSeBg = (CCSprite*)[self getChildByTag:PlayWordLayer_WordRed_BG_tag];
	if(HongSeBg)
	{
		[self removeChild:HongSeBg cleanup:YES];
	}
	
	CCSprite * word_lansedi_struct_bg = (CCSprite*)[self getChildByTag:PlayWordLayer_BuShouBlue_BG_tag];
	if(word_lansedi_struct_bg)
	{
		[self removeChild:word_lansedi_struct_bg cleanup:YES];
	}
	
	if(m_bIsPingYin)
	{
		CCSprite * pLanSeBg = [CCSprite spriteWithSpriteFrameName:@"word_lansedi_bg.png"];
		pLanSeBg.position = ccp(size.width/2,ANSWER_POS.y);
		pLanSeBg.tag      = PlayWordLayer_WordBlue_BG_tag;
		[self addChild:pLanSeBg z:PlayWordLayer_Z_WordBigBG];
	}
	else
	{
		CCSprite * lansedi_struct_bg = [CCSprite spriteWithSpriteFrameName:@"word_lansedi_struct_bg.png"];
		lansedi_struct_bg.position = ccp(size.width/2,ANSWER_POS.y);
		lansedi_struct_bg.tag      = PlayWordLayer_BuShouBlue_BG_tag;
		[self addChild:lansedi_struct_bg z:PlayWordLayer_Z_WordBigBG];
	}
	
	//中文答案背景
	
	if(m_bIsPingYin)
	{
		CCSprite * pword_gezi = [CCSprite spriteWithFile:@"file_word_gezi.png"];
		
		float GeziOffSet_X = (size.width - m_nTotalTurn * pword_gezi.contentSize.width - (m_nTotalTurn-1) * ANSWER_OFFSET.x)/2;
		
		for(int i = 0;i < m_nTotalTurn;i ++)
		{
			CCSprite * word_gezi = [CCSprite spriteWithFile:@"file_word_gezi.png"];
			word_gezi.position = ccp(GeziOffSet_X + word_gezi.contentSize.width/2 + i * (word_gezi.contentSize.width + ANSWER_OFFSET.x),310);
			word_gezi.tag      = PlayWordLayer_PinYin_Answer_Name_tag + i;
			[self addChild:word_gezi z:1];
			
			if(i == 0)
			{
				CCSprite * word_geziSel = [CCSprite spriteWithSpriteFrameName:@"word_geziSel.png"];
				word_geziSel.position = word_gezi.position;
				word_geziSel.tag      = PlayWordLayer_AnswerSelBg_tag;
				[self addChild:word_geziSel z:1];
				
				
				CCSprite * word_gezi_arrow = [CCSprite spriteWithSpriteFrameName:@"word_gezi_arrow.png"];
				word_gezi_arrow.position = ccp(word_gezi.position.x,word_gezi.position.y + word_gezi.contentSize.height/2 + 10);
				word_gezi_arrow.tag      = PlayWordLayer_AnswerSel_Arrow_tag;
				[self addChild:word_gezi_arrow z:1];
				
				//上下动作
				CCRepeatForever * pRepeatForever = 
				[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,+5.0f)],
												   [CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,-5.0f)],
												   nil]];
				
				[word_gezi_arrow runAction:pRepeatForever];
			}
		}
	}
	else
	{
		CCSprite * word_left_Right = [CCSprite spriteWithSpriteFrameName:@"word_left_Right.png"];
		
		float GeziOffSet_X = (size.width - m_nTotalTurn * word_left_Right.contentSize.width - (m_nTotalTurn-1) * ANSWER_OFFSET.x)/2;
		
		for(int i = 0;i < m_nTotalTurn;i ++)
		{
			NSMutableArray * pStrArr = (NSMutableArray*)[m_pAnswerArr2 objectAtIndex:i];
			
			NSString * pStrAnswer =  [pStrArr objectAtIndex:0];
			
			NSInteger pStructNum = [[pStrAnswer substringWithRange:NSMakeRange(0,1)] intValue];
			
			if(pStructNum == 1)
			{
				CCSprite * word_left_Right = [CCSprite spriteWithSpriteFrameName:@"word_left_Right.png"];
				word_left_Right.position = ccp(GeziOffSet_X + word_left_Right.contentSize.width/2 + i * (word_left_Right.contentSize.width + ANSWER_OFFSET.x),ANSWER_POS.y);
				word_left_Right.tag      = PlayWordLayer_BuShou_Answer_Name_tag + i;
				[self addChild:word_left_Right z:1];
			}
			else if(pStructNum == 2)
			{
				CCSprite * word_up_down = [CCSprite spriteWithSpriteFrameName:@"word_up_down.png"];
				word_up_down.position = ccp(GeziOffSet_X + word_up_down.contentSize.width/2 + i * (word_up_down.contentSize.width + ANSWER_OFFSET.x),ANSWER_POS.y);
				word_up_down.tag      = PlayWordLayer_BuShou_Answer_Name_tag + i;
				[self addChild:word_up_down z:1];
			}
			else if(pStructNum == 3)
			{
				CCSprite * word_single = [CCSprite spriteWithSpriteFrameName:@"word_single.png"];
				word_single.position = ccp(GeziOffSet_X + word_single.contentSize.width/2 + i * (word_single.contentSize.width + ANSWER_OFFSET.x),ANSWER_POS.y);
				word_single.tag      = PlayWordLayer_BuShou_Answer_Name_tag + i;
				[self addChild:word_single z:1];
			}
		}
	}
	
	
	//底部12个单词
	
	if([m_pChoiceArr1 count] == 0 || [m_pChoiceArr2 count] == 0)
		return;
	
	NSMutableArray * pPinYinChoiceStrArr = (NSMutableArray*)[m_pChoiceArr1 objectAtIndex:m_nCurTurn];
	if(pPinYinChoiceStrArr == nil || [pPinYinChoiceStrArr count] == 0)
		return;
	
	NSMutableArray * pBuShouChoiceStrArr = (NSMutableArray*)[m_pChoiceArr2 objectAtIndex:m_nCurTurn];
	if(pBuShouChoiceStrArr == nil || [pBuShouChoiceStrArr count] == 0)
		return;
	
	for(int j = 0;j < 2;j ++)
	{
		for(int i = 0;i < 6;i ++)
		{
			Word * pWord = [Word WordWithItems:nil :nil];
			
			pWord.position = ccp(size.width - WORD_POS.x - (i+1)* WORD_OFFSET.x - i * pWord.contentSize.width,
								 WORD_POS.y + (j+1)* WORD_OFFSET.y + j * pWord.contentSize.height);
			
			[self addChild:pWord z:PlayWordLayer_Z_Word];
			
			[m_pWordArr addObject:pWord];
			
			NSString * pStr = nil;
			
			if(m_bIsPingYin)
			{
				pStr = [pPinYinChoiceStrArr objectAtIndex:(j * 6 + i)];
			}
			else
			{
				pStr = [pBuShouChoiceStrArr objectAtIndex:(j * 6 + i)];
			}
			
			[pWord setState:Word_State_Choice];
			[pWord setFileName:pStr];
		}
	}
}

-(void) InitAnswerArea
{
	for(int pIndex = CHOICE_NUM;pIndex < [m_pWordArr count];pIndex ++)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		[self removeChild:pItem cleanup:true];
	}
	
	if([m_pWordArr count] > CHOICE_NUM)
	{
		NSRange pRange = NSMakeRange(CHOICE_NUM,([m_pWordArr count] - CHOICE_NUM));
		[m_pWordArr removeObjectsInRange:pRange];
	}
	
	NSMutableArray * pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr1 objectAtIndex:m_nCurTurn];
	m_nAnswerCount = [pStrAnswerArr count];
	
	if(m_bIsPingYin)
	{
		CGSize size = [CCDirector sharedDirector].winSize;
		
		CCSprite * pAnswerBg = [CCSprite spriteWithFile:@"file_word_answer_bg.png"];
		
		float AnswerOffSet_X = (size.width - m_nAnswerCount * pAnswerBg.contentSize.width - (m_nAnswerCount-1) * ANSWER_OFFSET.x)/2;
		
		for(int i = 0;i < m_nAnswerCount;i ++)
		{
			CCSprite   * pNoneBg   = [CCSprite spriteWithFile:@"file_word_answer_bg.png"];
			
			Word * pWord = [Word WordWithItems:pNoneBg :nil];
			pWord.position = ccp(AnswerOffSet_X + i * ANSWER_OFFSET.x + i * pWord.contentSize.width + pWord.contentSize.width/2,
								 ANSWER_POS.y);
			
			[self addChild:pWord z:PlayWordLayer_Z_Word];
			
			[m_pWordArr addObject:pWord];
			
			[pWord setState:Word_State_Answer];
		}
	}
}

-(void) AnswerMoveToName
{
	if(m_bIsPingYin)
	{
		for(int pMoveIndex = CHOICE_NUM;pMoveIndex < [m_pWordArr count];pMoveIndex ++)
		{
			Word * pMoveItem = (Word*)[m_pWordArr objectAtIndex:pMoveIndex];
			
			if(!pMoveItem)
				continue;
			
			CCSprite * word_gezi = (CCSprite*)[self getChildByTag:(PlayWordLayer_PinYin_Answer_Name_tag + m_nCurTurn)];
			
			CCMoveTo   * pMoveTo   = [CCMoveTo   actionWithDuration:0.2f position:word_gezi.position];
			CCScaleTo  * pScaleTo  = [CCScaleTo  actionWithDuration:0.2f scale:0.0f];
			
			if(pMoveIndex == CHOICE_NUM)
			{
				[pMoveItem runAction:[CCSequence actions:[CCSpawn actions:pMoveTo,pScaleTo,nil],[CCCallFunc actionWithTarget:self selector:@selector(SetNextTurn)],nil]];
			}
			else
			{
				[pMoveItem runAction:[CCSpawn actions:pMoveTo,pScaleTo,nil]];
			}
		}
	}
	else
	{
		for(int pMoveIndex = 0;pMoveIndex < [m_pTempAnswerArr count];pMoveIndex ++)
		{
			Word * pItem = [self itemByFileName:[m_pTempAnswerArr objectAtIndex:pMoveIndex]];
			
			if(!pItem)
				continue;
			
			CCSprite * pNoneBg = [CCSprite spriteWithFile:@"file_word_answer_bg.png"];
			
			Word * pMoveItem = [Word WordWithItems:pNoneBg:nil];
			pMoveItem.position = pItem.position;
			
			[pMoveItem setState:pItem.m_eState];
			[pMoveItem setFileName:[pItem getFileName]];
			
			[self addChild:pMoveItem z:PlayWordLayer_Z_Word];
			
			[pItem setFileName:nil];
			
			CCSprite * word_gezi = (CCSprite*)[self getChildByTag:(PlayWordLayer_BuShou_Answer_Name_tag + m_nCurTurn)];
			
			CCMoveTo   * pMoveTo   = [CCMoveTo   actionWithDuration:0.2f position:word_gezi.position];
			CCScaleTo  * pScaleTo  = [CCScaleTo  actionWithDuration:0.2f scale:0.0f];
			
			if(pMoveIndex == 0)
			{
				[pMoveItem runAction:[CCSequence actions:
									  [CCSpawn     actions:pMoveTo,pScaleTo,nil],
									  [CCCallFuncN actionWithTarget:self selector:@selector(MoveItemDone:)],
									  [CCCallFunc  actionWithTarget:self selector:@selector(ShowBuShouRightEnd)],
									  [CCCallFunc  actionWithTarget:self selector:@selector(SetNextTurn)],
									  nil]];
			}
			else
			{
				[pMoveItem runAction:[CCSequence actions:
									  [CCSpawn	   actions:pMoveTo,pScaleTo,nil],
									  [CCCallFuncN actionWithTarget:self selector:@selector(MoveItemDone:)],
									  nil]];
			}
		}
		
		/*
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2f],
							  [CCCallFunc actionWithTarget:self selector:@selector(ShowBuShouRightEnd)],
							  [CCCallFunc actionWithTarget:self selector:@selector(SetNextTurn)],
							  nil]];
		*/
	}
}

-(void) MoveItemDone:(id)sender
{
	CCNode * pNode = (CCNode*)sender;
	
	[self removeChild:pNode cleanup:YES];
}

-(void) ShowBuShouRightEnd
{
	[m_pTempAnswerArr removeAllObjects];
	
	m_bIsCheckAnswer = NO;
}

-(void) ShowBuShouWrongEnd
{
	for(int i = 0;i < [m_pTempAnswerArr count];i++)
	{
		NSString * pStr = [m_pTempAnswerArr objectAtIndex:i];
		Word * pItem = [self itemByFileName:pStr];
		if(pItem)
		{
			[pItem setState:Word_State_Choice];
			[pItem setFileName:[pItem getFileName]];
		}
	}
	
	[m_pTempAnswerArr removeAllObjects];
	
	m_bIsCheckAnswer = NO;
}

-(void) ShowBuShouWrong
{
	if(m_nCurTurn < m_nTotalTurn)
	{
		CCSprite * word_struct_wrong = [CCSprite spriteWithSpriteFrameName:@"word_struct_wrong.png"];
		
		CCSprite * word_gezi = (CCSprite*)[self getChildByTag:(PlayWordLayer_BuShou_Answer_Name_tag + m_nCurTurn)];
		
		word_struct_wrong.position = word_gezi.position;
		word_struct_wrong.scale    = 0.1f;
		word_struct_wrong.opacity  = 0;
		[self addChild:word_struct_wrong z:1];
		
		CCScaleTo * pScaleTo = [CCScaleTo actionWithDuration:0.2f scale:1.0f];
		CCFadeTo  * pFadeTo  = [CCFadeTo  actionWithDuration:0.2f opacity:255];
		
		CCSequence * pSequence = [CCSequence actions:
								  [CCSpawn actions:pScaleTo,pFadeTo,nil],
								  [CCFadeTo  actionWithDuration:0.2f opacity:0],
								  [CCCallFunc actionWithTarget:self selector:@selector(ShowBuShouWrongEnd)],
								  nil
								  ];
		
		[word_struct_wrong runAction:pSequence];
	}
}

-(void) ShowAnswerName
{
	if(m_nCurTurn < m_nTotalTurn)
	{
		if(m_bIsPingYin)
		{
			CCLabelTTF * label = [CCLabelTTF labelWithString:[m_pAnswerName objectAtIndex:m_nCurTurn]
													fontName:WORD_FONT_NAME 
													fontSize:WORD_FONT_SIZE];
			
			CCSprite * word_gezi = (CCSprite*)[self getChildByTag:(PlayWordLayer_PinYin_Answer_Name_tag + m_nCurTurn)];
			
			label.position = word_gezi.position;
			label.tag	   = PlayWordLayer_PinYin_Label_tag + m_nCurTurn;
			label.color    = ccBLACK;
			label.scale    = 0.1f;
			label.opacity  = 0;
			[self addChild:label z:1];
			
			CCScaleTo * pScaleTo = [CCScaleTo actionWithDuration:0.2f scale:1.0f];
			CCFadeTo  * pFadeTo  = [CCFadeTo  actionWithDuration:0.2f opacity:255];
			
			[label runAction:[CCSpawn actions:pScaleTo,pFadeTo,nil]];
		}
		else
		{
			CCLabelTTF * label = [CCLabelTTF labelWithString:[m_pAnswerName objectAtIndex:m_nCurTurn]
													fontName:WORD_FONT_NAME 
													fontSize:WORD_FONT_SIZE];
			
			CCSprite * word_gezi = (CCSprite*)[self getChildByTag:(PlayWordLayer_BuShou_Answer_Name_tag + m_nCurTurn)];
			
			label.position = word_gezi.position;
			label.tag	   = PlayWordLayer_BuShou_Label_tag + m_nCurTurn;
			label.color    = ccBLACK;
			label.scale    = 0.1f;
			label.opacity  = 0;
			[self addChild:label z:1];
			
			CCScaleTo * pScaleTo = [CCScaleTo actionWithDuration:0.2f scale:1.0f];
			CCFadeTo  * pFadeTo  = [CCFadeTo  actionWithDuration:0.2f opacity:255];
			
			[label runAction:[CCSpawn actions:pScaleTo,pFadeTo,nil]];
		}
	}
}

- (void) dealloc
{
	[m_pChoiceArr1     release];
	[m_pAnswerArr1     release];
	
	[m_pChoiceArr2     release];
	[m_pAnswerArr2     release];
	
	[m_pTempAnswerArr  release];
	
	[m_pAnswerName    release];
	[m_pWordArr		  release];
	[m_pReplayListArr release];
	[m_pSelectedItem  release];
	
	[super dealloc];
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(m_nCurTurn >= m_nTotalTurn)
	{
		return NO;
	}
	
	if(m_bIsPingYin)
	{
		CGPoint touchLocation = [touch locationInView: [touch view]];
		touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
		
		int pIndex = 0;
		
		Word * pItem = [self itemForTouch:touchLocation:&pIndex];
		
		if(pItem && pItem.m_bHaveWord)
		{
			CCSprite   * pNoneBg   = [CCSprite spriteWithFile:@"file_word_answer_bg.png"];
			
			m_pSelectedItem = [Word WordWithItems:pNoneBg:nil];
			m_pSelectedItem.position = pItem.position;
			
			[m_pSelectedItem setState:pItem.m_eState];
			[m_pSelectedItem setFileName:[pItem getFileName]];
			
			[self addChild:m_pSelectedItem z:PlayWordLayer_Z_Word];
			
			[m_pSelectedItem setBigAction:true];
			
			m_nMovingSelected = pIndex;
			
			[pItem setFileName:nil];
		}
	}
	
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(m_bIsPingYin)
	{
		if(m_bIsMoving)
		{
			//滑动的逻辑
			if(m_bIsCollision)
			{
				//有碰撞，交换单词位子
				if(m_pSelectedItem && m_nCollisionIndex != -1)
				{
					[self oneReplage:m_nMovingSelected :m_nCollisionIndex];
					
					m_nCollisionIndex = -1;
				}
			}
			else
			{
				//没有碰撞，放回单词
				if(m_nMovingSelected != -1 && m_pSelectedItem)
				{
					Word * pItem = (Word*)[m_pWordArr objectAtIndex:m_nMovingSelected];
					
					[pItem setFileName:[m_pSelectedItem getFileName]];
				}
			}
			
			if(m_pSelectedItem)
			{
				[self removeChild:m_pSelectedItem cleanup:true];
				m_pSelectedItem   = nil;
				
				m_nMovingSelected = -1;
			}
			
			if(m_nLastMovingSelected != -1)
			{
				Word * pItem = (Word*)[m_pWordArr objectAtIndex:m_nLastMovingSelected];
				if(pItem)
				{
					[pItem setTouchEndSelected:false];
				}
				
				m_nLastMovingSelected = -1;
			}
		}
		else
		{
			//单击的逻辑
			CGPoint touchLocation = [touch locationInView: [touch view]];
			touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
			
			if(m_pSelectedItem)
			{
				if(m_nMovingSelected < CHOICE_NUM)
				{
					//点中选词
					[self ClickChoice:m_nMovingSelected]; 
				}
				else
				{
					//点中答案
					[self ClickAnswer:m_nMovingSelected];
				}
				
				[self removeChild:m_pSelectedItem cleanup:true];
				m_pSelectedItem = nil;
				
				m_nMovingSelected = -1;
			}
		}
		
		m_bIsMoving  = false;
	}
	else
	{
		if(!m_bIsCheckAnswer)
		{
			CGPoint touchLocation = [touch locationInView: [touch view]];
			touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
			
			int pIndex = -1;
			
			if([self itemForTouch:touchLocation:&pIndex])
			{
				[self oneClickBuShou:pIndex];
			}
		}
	}
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(m_bIsPingYin)
	{
		CGPoint touchLocation = [touch locationInView: [touch view]];
		CGPoint prevLocation  = [touch previousLocationInView: [touch view]];	
		
		touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
		prevLocation  = [[CCDirector sharedDirector] convertToGL: prevLocation ];
		
		CGPoint diff = ccpSub(touchLocation, prevLocation);
		
		m_bIsMoving = true;
		
		if(m_pSelectedItem)
		{
			CGPoint currentPos = m_pSelectedItem.position;
			
			m_pSelectedItem.position = ccpAdd(currentPos, diff);
			
			[self CheckCollision];
		}
	}
}

- (void) ClickAnswer:(int) pIndex
{
	//找出Choice有空的位子
	
	int pChoiceIdle = [self FindIdleChoice];
	
	if(pChoiceIdle == -1)
	{
		//已经满了
		
	}
	else
	{
		//找到空位
		//删除pIndex
		//添加pAnswerIdle
		[self oneClick:pIndex :pChoiceIdle];
	}
	
}

- (void) ClickChoice:(int) pIndex
{
	//找出Answer有空的位子
	
	int pAnswerIdle = [self FindIdleAnswer];
	
	if(pAnswerIdle == -1)
	{
		//已经满了，放回原位子
		
		Word * pAddItem = (Word *)[m_pWordArr objectAtIndex:pIndex];
		if(pAddItem && m_pSelectedItem)
		{
			[pAddItem setFileName:[m_pSelectedItem getFileName]];
		}
	}
	else
	{
		//找到空位
		//删除pIndex
		//添加pAnswerIdle
		[self oneClick:pIndex :pAnswerIdle];
	}	
}

-(void) oneClickBuShou:(int) pIndex
{
	Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
	if(pItem)
	{
		if(pItem.m_eState == Word_State_Choice)
		{
			[pItem setState:Word_State_Answer];
			[pItem setFileName:[pItem getFileName]];
			
			[m_pTempAnswerArr addObject:[pItem getFileName]];
		}
		else if(pItem.m_eState == Word_State_Answer)
		{
			[pItem setState:Word_State_Choice];
			[pItem setFileName:[pItem getFileName]];
			
			[m_pTempAnswerArr removeObject:[pItem getFileName]];
		}
		
		if(!m_bIsReplay)
		{
			CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
			
			OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_ClickBuShou :pIndex :0 :(pNow - m_LastTime)];
			
			m_LastTime = pNow;
			
			[m_pReplayListArr addObject:pGuess_Event];
		}
		
		//[SoundHelp playEffect:TOUCH_EFFECT];
	}
	
	[self CheckAnswer];
}

- (void) ReOrderChoice
{	
	//是否有单词移动过
	bool bHaveMoing = false;
	
	for(int pIndex = CHOICE_NUM - 1;pIndex >= 0;pIndex --)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		//找空单词
		
		if(!pItem.m_bHaveWord)
		{
			//找离这个空单词最近位置的单词，移动过来替换
			
			int pLastWordIndex = [self FindLastWord:pIndex];
			
			if(pLastWordIndex == -1)
			{
				//后面已经么有单词了
				break;
			}
			else
			{
				//pLastWordIndex移动过来，pItem直接替换过去
				
				bHaveMoing = true;
				
				Word * pLastWordItem = (Word*)[m_pWordArr objectAtIndex:pLastWordIndex];
				
				[pItem setFileName:[pLastWordItem getFileName]];
				[pLastWordItem setFileName:nil];
				
				CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
				
				//替换动作
				OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Replace :pIndex :pLastWordIndex :(pNow - m_LastTime)];
				
				m_LastTime = pNow;
				
				[m_pReplayListArr addObject:pGuess_Event];
			}
		}
	}
	
	//重排
	//int ReOrderNum = 0;
	
	//ReOrderNum = CHOICE_NUM - FindIdleChoice() - 1;
	
	int pIdleIndex = [self FindIdleChoice];
	
	//srand((unsigned)time(NULL));
	
	for(int pReOrderIndex = CHOICE_NUM - 1;pReOrderIndex > pIdleIndex + 1;pReOrderIndex --)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pReOrderIndex];
		
		if(!pItem)
			continue;
		
		//从[pIdleIndex + 1,pReOrderIndex - 1]选一个替换
		
		int pRandomIndex = arc4random() % (pReOrderIndex - 1 - pIdleIndex) + pIdleIndex + 1 ;
		
		Word * pRandomItem = (Word*)[m_pWordArr objectAtIndex:pRandomIndex];
		
		if(pRandomItem)
		{
			NSString * pTempStr = nil;
			
			if([pRandomItem getFileName])
			{
				pTempStr = [NSString stringWithString:[pRandomItem getFileName]];
			}
			
			[pRandomItem setFileName:[pItem getFileName]];
			[pItem setFileName:pTempStr];
			
			CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
			
			OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Replace :pReOrderIndex :pRandomIndex :(pNow - m_LastTime)];
			
			m_LastTime = pNow;
			
			[m_pReplayListArr addObject:pGuess_Event];
		}
	}
}

-(void) LoadWordPlay
{
	[m_pReplayListArr removeAllObjects];
	
	[m_pChoiceArr1     removeAllObjects];
	[m_pChoiceArr2     removeAllObjects];
	
	/*
	[m_pReplayListArr  addObjectsFromArray:[GameEngine GetInstance].m_pReplayListArr];
	
	[m_pChoiceArr1     addObjectsFromArray:[GameEngine GetInstance].m_pPinYinChoiceArr];
	[m_pChoiceArr2     addObjectsFromArray:[GameEngine GetInstance].m_pBuShouChoiceArr];
	*/
}

-(void) Pass
{
	if(!m_bIsReplay)
	{
		CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
		//放弃事件
		OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Pass :0 :0 :(pNow - m_LastTime)];
		m_LastTime = pNow;
		[m_pReplayListArr addObject:pGuess_Event];
	}
}

-(void) Success
{
	if(!m_bIsReplay)
	{
		CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
		//猜对事件事件
		OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Success :0 :0 :(pNow - m_LastTime)];
		m_LastTime = pNow;
		[m_pReplayListArr addObject:pGuess_Event];
	}
}

-(void) ChangeMode
{
	m_bIsPingYin = !m_bIsPingYin;
	
	if(m_bIsPingYin)
	{
		[self ChangeToPinYin];
	}
	else
	{
		[self ChangeToBuShou];
	}
	
	if(!m_bIsReplay)
	{
		CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
		OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_ChangeMode :0 :0 :(pNow - m_LastTime)];
		m_LastTime = pNow;
		[m_pReplayListArr addObject:pGuess_Event];
	}
	
	[self NotifiyChangeMode];
}

-(void) CheckUseBomb
{
	if(m_bHaveUseBomb)
	{
		for (int i = 0; i < BOMB_COUNT; i++)
		{
			int pWrongIndex = [self FindWrongChoice];
			if(pWrongIndex == -1)
			{
				CCLOG(@"WrongIndex == -1");
				break;
			}
			
			Word * pItem = (Word*)[m_pWordArr objectAtIndex:pWrongIndex];
			if(pItem)
			{
				[pItem setFileName:nil];
			}
		}
		
		//填补空的位置
		for(int i = CHOICE_NUM - 1; i >= 0; i--)
		{
			Word * pItem = (Word*)[m_pWordArr objectAtIndex:i];
			if (pItem && [pItem getFileName] == nil)
			{
				for(int j = i-1; j >= 0; j--)
				{
					Word * pCollisionItem = (Word*)[m_pWordArr objectAtIndex:j];
					
					NSString * tmpStr = [pCollisionItem getFileName];
					if(tmpStr != nil)
					{
						[pItem		    setFileName:tmpStr];
						[pCollisionItem setFileName:nil];
						break;
					}
				}
			}
		}
	}
}

-(void) ChangeToPinYin
{
	CGSize size = [CCDirector sharedDirector].winSize;
	
	CCSprite * LanSeBg  = (CCSprite*)[self getChildByTag:PlayWordLayer_WordBlue_BG_tag];
	if(LanSeBg)
	{
		[self removeChild:LanSeBg cleanup:YES];
	}
	
	CCSprite * HongSeBg = (CCSprite*)[self getChildByTag:PlayWordLayer_WordRed_BG_tag];
	if(HongSeBg)
	{
		[self removeChild:HongSeBg cleanup:YES];
	}
	
	CCSprite * word_lansedi_struct_bg = (CCSprite*)[self getChildByTag:PlayWordLayer_BuShouBlue_BG_tag];
	if(word_lansedi_struct_bg)
	{
		[self removeChild:word_lansedi_struct_bg cleanup:YES];
	}
	
	CCSprite * pLanSeBg = [CCSprite spriteWithSpriteFrameName:@"word_lansedi_bg.png"];
	pLanSeBg.position = ccp(size.width/2,ANSWER_POS.y);
	pLanSeBg.tag      = PlayWordLayer_WordBlue_BG_tag;
	[self addChild:pLanSeBg z:PlayWordLayer_Z_WordBigBG];
	
	//移除先前
	for(int i = 0;i < m_nTotalTurn;i ++)
	{
		CCSprite * word_gezi = (CCSprite*)[self getChildByTag:PlayWordLayer_PinYin_Answer_Name_tag + i];
		if(word_gezi)
		{
			[self removeChild:word_gezi cleanup:YES];
		}
		CCSprite * word_struct = (CCSprite*)[self getChildByTag:PlayWordLayer_BuShou_Answer_Name_tag + i];
		if(word_struct)
		{
			[self removeChild:word_struct cleanup:YES];
		}
		
		CCLabelTTF * PinYinLabel = (CCLabelTTF*)[self getChildByTag:PlayWordLayer_PinYin_Label_tag + i];
		if(PinYinLabel)
		{
			[self removeChild:PinYinLabel cleanup:YES];
		}
		
		CCLabelTTF * BuShouLabel = (CCLabelTTF*)[self getChildByTag:PlayWordLayer_BuShou_Label_tag + i];
		if(BuShouLabel)
		{
			[self removeChild:BuShouLabel cleanup:YES];
		}
	}
	CCSprite * word_geziSel = (CCSprite*)[self getChildByTag:PlayWordLayer_AnswerSelBg_tag];
	if(word_geziSel)
	{
		[self removeChild:word_geziSel cleanup:YES];
	}
	CCSprite * word_gezi_arrow = (CCSprite*)[self getChildByTag:PlayWordLayer_AnswerSel_Arrow_tag];
	if(word_gezi_arrow)
	{
		[self removeChild:word_gezi_arrow cleanup:YES];
	}
	
	///////

	CCSprite * pword_gezi = [CCSprite spriteWithFile:@"file_word_gezi.png"];
	
	float GeziOffSet_X = (size.width - m_nTotalTurn * pword_gezi.contentSize.width - (m_nTotalTurn-1) * ANSWER_OFFSET.x)/2;
	
	for(int i = 0;i < m_nTotalTurn;i ++)
	{
		CCSprite * word_gezi = [CCSprite spriteWithFile:@"file_word_gezi.png"];
		word_gezi.position = ccp(GeziOffSet_X + word_gezi.contentSize.width/2 + i * (word_gezi.contentSize.width + ANSWER_OFFSET.x),165);
		word_gezi.tag      = PlayWordLayer_PinYin_Answer_Name_tag + i;
		[self addChild:word_gezi z:1];
		
		if(i == m_nCurTurn)
		{
			CCSprite * word_geziSel = [CCSprite spriteWithSpriteFrameName:@"word_geziSel.png"];
			word_geziSel.position = word_gezi.position;
			word_geziSel.tag      = PlayWordLayer_AnswerSelBg_tag;
			[self addChild:word_geziSel z:1];
			
			CCSprite * word_gezi_arrow = [CCSprite spriteWithSpriteFrameName:@"word_gezi_arrow.png"];
			word_gezi_arrow.position = ccp(word_gezi.position.x,word_gezi.position.y + word_gezi.contentSize.height/2 + 10);
			word_gezi_arrow.tag      = PlayWordLayer_AnswerSel_Arrow_tag;
			[self addChild:word_gezi_arrow z:1];
			
			//上下动作
			CCRepeatForever * pRepeatForever = 
			[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,+5.0f)],
											   [CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,-5.0f)],
											   nil]];
			
			[word_gezi_arrow runAction:pRepeatForever];
		}
	}
	
	for(int i = 0;i < m_nCurTurn;i ++)
	{
		CCLabelTTF * label = [CCLabelTTF labelWithString:[m_pAnswerName objectAtIndex:i]
												fontName:WORD_FONT_NAME 
												fontSize:WORD_FONT_SIZE];
		
		CCSprite * word_gezi = (CCSprite*)[self getChildByTag:(PlayWordLayer_PinYin_Answer_Name_tag + i)];
		
		label.position = word_gezi.position;
		label.tag	   = PlayWordLayer_PinYin_Label_tag + i;
		label.color    = ccBLACK;
		label.scale    = 0.1f;
		label.opacity  = 0;
		[self addChild:label z:1];
		
		CCScaleTo * pScaleTo = [CCScaleTo actionWithDuration:0.2f scale:1.0f];
		CCFadeTo  * pFadeTo  = [CCFadeTo  actionWithDuration:0.2f opacity:255];
		
		[label runAction:[CCSpawn actions:pScaleTo,pFadeTo,nil]];
	}
	
	for(int j = 0;j < 2;j ++)
	{
		for(int i = 0;i < 6;i ++)
		{
			Word * pWord = (Word*)[m_pWordArr objectAtIndex:j*6 + i];
			
			NSMutableArray * pChoiceStrArr = (NSMutableArray*)[m_pChoiceArr1 objectAtIndex:m_nCurTurn];
			
			[pWord setState:Word_State_Choice];
			[pWord setFileName:[pChoiceStrArr objectAtIndex:(j*6 + i)]];
			
			[pWord setOneClickAction];
		}
	}
	
	[self InitAnswerArea];
	
	[self CheckUseBomb];
}

-(void) ChangeToBuShou
{
	CGSize size = [CCDirector sharedDirector].winSize;
	
	CCSprite * LanSeBg  = (CCSprite*)[self getChildByTag:PlayWordLayer_WordBlue_BG_tag];
	if(LanSeBg)
	{
		[self removeChild:LanSeBg cleanup:YES];
	}
	
	CCSprite * HongSeBg = (CCSprite*)[self getChildByTag:PlayWordLayer_WordRed_BG_tag];
	if(HongSeBg)
	{
		[self removeChild:HongSeBg cleanup:YES];
	}
	
	CCSprite * word_lansedi_struct_bg = (CCSprite*)[self getChildByTag:PlayWordLayer_BuShouBlue_BG_tag];
	if(word_lansedi_struct_bg)
	{
		[self removeChild:word_lansedi_struct_bg cleanup:YES];
	}
	
	CCSprite * lansedi_struct_bg = [CCSprite spriteWithSpriteFrameName:@"word_lansedi_struct_bg.png"];
	lansedi_struct_bg.position = ccp(size.width/2,ANSWER_POS.y);
	lansedi_struct_bg.tag      = PlayWordLayer_BuShouBlue_BG_tag;
	[self addChild:lansedi_struct_bg z:PlayWordLayer_Z_WordBigBG];
	
	//移除先前
	for(int i = 0;i < m_nTotalTurn;i ++)
	{
		CCSprite * word_gezi = (CCSprite*)[self getChildByTag:PlayWordLayer_PinYin_Answer_Name_tag + i];
		if(word_gezi)
		{
			[self removeChild:word_gezi cleanup:YES];
		}
		CCSprite * word_struct = (CCSprite*)[self getChildByTag:PlayWordLayer_BuShou_Answer_Name_tag + i];
		if(word_struct)
		{
			[self removeChild:word_struct cleanup:YES];
		}
		
		CCLabelTTF * PinYinLabel = (CCLabelTTF*)[self getChildByTag:PlayWordLayer_PinYin_Label_tag + i];
		if(PinYinLabel)
		{
			[self removeChild:PinYinLabel cleanup:YES];
		}
		
		CCLabelTTF * BuShouLabel = (CCLabelTTF*)[self getChildByTag:PlayWordLayer_BuShou_Label_tag + i];
		if(BuShouLabel)
		{
			[self removeChild:BuShouLabel cleanup:YES];
		}
	}
	CCSprite * word_geziSel = (CCSprite*)[self getChildByTag:PlayWordLayer_AnswerSelBg_tag];
	if(word_geziSel)
	{
		[self removeChild:word_geziSel cleanup:YES];
	}
	CCSprite * word_gezi_arrow = (CCSprite*)[self getChildByTag:PlayWordLayer_AnswerSel_Arrow_tag];
	if(word_gezi_arrow)
	{
		[self removeChild:word_gezi_arrow cleanup:YES];
	}
	
	///////
	
	CCSprite * word_left_Right = [CCSprite spriteWithSpriteFrameName:@"word_left_Right.png"];
	
	float GeziOffSet_X = (size.width - m_nTotalTurn * word_left_Right.contentSize.width - (m_nTotalTurn-1) * ANSWER_OFFSET.x)/2;
	
	for(int i = 0;i < m_nTotalTurn;i ++)
	{
		NSMutableArray * pStrArr = (NSMutableArray*)[m_pAnswerArr2 objectAtIndex:i];
		
		NSString * pStrAnswer =  [pStrArr objectAtIndex:0];
		
		NSInteger pStructNum = [[pStrAnswer substringWithRange:NSMakeRange(0,1)] intValue];
		
		if(pStructNum == 1)
		{
			CCSprite * word_left_Right = [CCSprite spriteWithSpriteFrameName:@"word_left_Right.png"];
			word_left_Right.position = ccp(GeziOffSet_X + word_left_Right.contentSize.width/2 + i * (word_left_Right.contentSize.width + ANSWER_OFFSET.x),ANSWER_POS.y);
			word_left_Right.tag      = PlayWordLayer_BuShou_Answer_Name_tag + i;
			[self addChild:word_left_Right z:1];
		}
		else if(pStructNum == 2)
		{
			CCSprite * word_up_down = [CCSprite spriteWithSpriteFrameName:@"word_up_down.png"];
			word_up_down.position = ccp(GeziOffSet_X + word_up_down.contentSize.width/2 + i * (word_up_down.contentSize.width + ANSWER_OFFSET.x),ANSWER_POS.y);
			word_up_down.tag      = PlayWordLayer_BuShou_Answer_Name_tag + i;
			[self addChild:word_up_down z:1];
		}
		else if(pStructNum == 3)
		{
			CCSprite * word_single = [CCSprite spriteWithSpriteFrameName:@"word_single.png"];
			word_single.position = ccp(GeziOffSet_X + word_single.contentSize.width/2 + i * (word_single.contentSize.width + ANSWER_OFFSET.x),ANSWER_POS.y);
			word_single.tag      = PlayWordLayer_BuShou_Answer_Name_tag + i;
			[self addChild:word_single z:1];
		}
		
		if(i == m_nCurTurn)
		{
			CCSprite * word_gezi = (CCSprite*)[self getChildByTag:PlayWordLayer_BuShou_Answer_Name_tag + m_nCurTurn];
			
			CCSprite * word_gezi_arrow = [CCSprite spriteWithSpriteFrameName:@"word_gezi_arrow.png"];
			word_gezi_arrow.position = ccp(word_gezi.position.x,word_gezi.position.y + word_gezi.contentSize.height/2 + 10);
			word_gezi_arrow.tag      = PlayWordLayer_AnswerSel_Arrow_tag;
			[self addChild:word_gezi_arrow z:1];
			
			//上下动作
			CCRepeatForever * pRepeatForever = 
			[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,+5.0f)],
											   [CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,-5.0f)],
											   nil]];
			
			[word_gezi_arrow runAction:pRepeatForever];
		}
	}
	
	for(int i = 0;i < m_nCurTurn;i ++)
	{
		CCLabelTTF * label = [CCLabelTTF labelWithString:[m_pAnswerName objectAtIndex:i]
												fontName:WORD_FONT_NAME 
												fontSize:WORD_FONT_SIZE];
		
		CCSprite * word_gezi = (CCSprite*)[self getChildByTag:(PlayWordLayer_BuShou_Answer_Name_tag + i)];
		
		label.position = word_gezi.position;
		label.tag	   = PlayWordLayer_BuShou_Label_tag + i;
		label.color    = ccBLACK;
		label.scale    = 0.1f;
		label.opacity  = 0;
		[self addChild:label z:1];
		
		CCScaleTo * pScaleTo = [CCScaleTo actionWithDuration:0.2f scale:1.0f];
		CCFadeTo  * pFadeTo  = [CCFadeTo  actionWithDuration:0.2f opacity:255];
		
		[label runAction:[CCSpawn actions:pScaleTo,pFadeTo,nil]];
	}
	
	for(int j = 0;j < 2;j ++)
	{
		for(int i = 0;i < 6;i ++)
		{
			Word * pWord = (Word*)[m_pWordArr objectAtIndex:j*6 + i];
			
			NSMutableArray * pChoiceStrArr = (NSMutableArray*)[m_pChoiceArr2 objectAtIndex:m_nCurTurn];
			
			/*
			 pWord.scale    = 1.0f;
			 pWord.position = ccp(size.width - WORD_POS.x - (i+1)* WORD_OFFSET.x - i * pWord.contentSize.width,
			 WORD_POS.y + (j+1)* WORD_OFFSET.y + j * pWord.contentSize.height);
			 */
			
			[pWord setState:Word_State_Choice];
			[pWord setFileName:[pChoiceStrArr objectAtIndex:(j*6 + i)]];
			
			[pWord setOneClickAction];
		}
	}
	
	[self InitAnswerArea];
	
	[self CheckUseBomb];
}

-(void) UseBomb
{
	m_bHaveUseBomb = YES;
	
	for (int i = 0; i < BOMB_COUNT; i++)
	{
		int pWrongIndex = [self FindWrongChoice];
		if(pWrongIndex == -1)
		{
			CCLOG(@"WrongIndex == -1");
			break;
		}
		
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pWrongIndex];
		if(pItem)
		{
			[pItem setFileName:nil];
		}
	}
	
	//填补空的位置
	for(int i = CHOICE_NUM - 1; i >= 0; i--)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:i];
		if (pItem && [pItem getFileName] == nil)
		{
			for(int j = i-1; j >= 0; j--)
			{
				Word * pCollisionItem = (Word*)[m_pWordArr objectAtIndex:j];
				
				NSString * tmpStr = [pCollisionItem getFileName];
				if(tmpStr != nil)
				{
					[pItem		    setFileName:tmpStr];
					[pCollisionItem setFileName:nil];
					break;
				}
			}
		}
	}
	
	if(!m_bIsReplay)
	{
		CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
		//炸弹事件
		OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Bomb :0 :0 :(pNow - m_LastTime)];
		m_LastTime = pNow;
		[m_pReplayListArr addObject:pGuess_Event];
	}
	
	[self NotifiyBomb];
	
	[self CheckAnswer];
}

- (void) RemoveAnswer
{
	if(m_nCurTurn >= m_nTotalTurn)
	{
		return;
	}
	
	if(m_bIsPingYin)
	{
		for(int pDeleteIndex = CHOICE_NUM;pDeleteIndex < [m_pWordArr count];pDeleteIndex ++)
		{
			Word * pDeleteItem = (Word*)[m_pWordArr objectAtIndex:pDeleteIndex];
			
			if(!pDeleteItem)
				continue;
			
			if(pDeleteItem.m_bHaveWord)
			{
				//答案区的单词
				
				int pAddIdle = [self FindIdleChoice];
				
				if(pAddIdle == -1)
				{
					//已经满了
					
					return;
				}
				else
				{
					//把单词放下去
					
					Word * pDeleteItem = (Word*)[m_pWordArr objectAtIndex:pDeleteIndex];
					Word * pAddItem    = (Word*)[m_pWordArr objectAtIndex:pAddIdle];
					
					//NSString * pTempStr = [NSString stringWithString:[pDeleteItem getWord]];
					
					if(pAddItem)
					{
						[pAddItem setFileName:[pDeleteItem getFileName]];
					}
					
					if(pDeleteItem)
					{
						[pDeleteItem setFileName:nil];
					}
					
					//m_pSelectedItem 和 pAddItem 放大一下，缩小一下
					[pDeleteItem setOneClickAction];
					[pAddItem    setOneClickAction];
					
					CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
					
					OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Replace :pDeleteIndex :pAddIdle :(pNow - m_LastTime)];
					
					m_LastTime = pNow;
					
					[m_pReplayListArr addObject:pGuess_Event];
				}
			}
		}
		[self CheckAnswer];
	}
}

-(int) FindIdleAnswer
{
	int pRet = -1;
	
	for(int pIndex = CHOICE_NUM;pIndex < [m_pWordArr count];pIndex ++)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		if(!pItem.m_bHaveWord)
		{
			pRet = pIndex;
			break;
		}
	}
	
	return pRet;
}

-(int) FindIdleChoice
{
	int pRet = -1;
	
	for(int pIndex = CHOICE_NUM - 1;pIndex >= 0;pIndex --)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		if(!pItem.m_bHaveWord)
		{
			pRet = pIndex;
			break;
		}
	}
	
	return pRet;
}

-(int) FindWrongChoice
{
	int pRet = -1;
	
	for(int pIndex = 0;pIndex < [m_pWordArr count];pIndex ++)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		if(pItem.m_bHaveWord)
		{
			NSMutableArray * pStrAnswerArr = nil;
			
			if(m_bIsPingYin)
			{
				pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr1 objectAtIndex:m_nCurTurn];
			}
			else
			{
				pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr2 objectAtIndex:m_nCurTurn];
			}
			
			BOOL bIsRight = NO;
			
			for(int pAnswerIndex = 0;pAnswerIndex < [pStrAnswerArr count];pAnswerIndex ++)
			{
				NSString * pStr = [pStrAnswerArr objectAtIndex:pAnswerIndex];
				if([[pItem getFileName] isEqualToString:pStr])
				{
					bIsRight = YES;
					break;
				}
			}
			
			if(!bIsRight)
			{
				pRet = pIndex;
				break;
			}
		}
	}
	
	return pRet;
}

-(int) FindLastWord:(int) pLocationIndex
{
	int pRet = -1;
	
	for(int pIndex = pLocationIndex - 1;pIndex >= 0;pIndex --)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		if(pItem.m_bHaveWord)
		{
			pRet = pIndex;
			break;
		}
	}
	
	return pRet;
}

-(void) oneClick:(int) pDeleteIndex     :(int) pAddIndex
{
	//if(m_pSelectedItem)
	{
		Word * pAddItem = (Word*)[m_pWordArr objectAtIndex:pAddIndex];
		
		NSString * pTempStr = [NSString stringWithString:[m_pSelectedItem getFileName]];
		
		if(pAddItem)
		{
			[pAddItem setFileName:pTempStr];
		}
		
		//m_pSelectedItem 和 pAddItem 放大一下，缩小一下
		[m_pSelectedItem setOneClickAction];
		[pAddItem	     setOneClickAction];
		
		//[SoundHelp playEffect:TOUCH_EFFECT];
		
		if(!m_bIsReplay)
		{
			CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
			
			OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Replace :pDeleteIndex :pAddIndex :(pNow - m_LastTime)];
			
			m_LastTime = pNow;
			
			[m_pReplayListArr addObject:pGuess_Event];
		}
		
		[self CheckAnswer];
	}
}

- (void) oneReplage:(int) pSelectedIndex :(int) pCollisionIndex
{
	//CCLOG("pSelectedIndex[%d]",pSelectedIndex);
	//CCLOG("pCollisionIndex[%d]",pCollisionIndex);
	
	if(m_pSelectedItem)
	{
		Word * pSelectedItem     = (Word*)[m_pWordArr objectAtIndex:pSelectedIndex];
		Word * pCollisionItem    = (Word*)[m_pWordArr objectAtIndex:pCollisionIndex];
		
		if(pSelectedItem)
		{
			[pSelectedItem setFileName:[pCollisionItem getFileName]];
		}
		
		if(pCollisionItem)
		{
			[pCollisionItem setFileName:[m_pSelectedItem getFileName]];
		}
		
		[pSelectedItem   setOneClickAction];
		[pCollisionItem	 setOneClickAction];
		
		//[SoundHelp playEffect:TOUCH_EFFECT];
		
		if(!m_bIsReplay)
		{
			CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
			
			OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_Replace :pSelectedIndex :pCollisionIndex :(pNow - m_LastTime)];
			
			m_LastTime = pNow;
			
			[m_pReplayListArr addObject:pGuess_Event];
		}
		
		[self CheckAnswer];
	}
}

-(Word*) itemForTouch:(CGPoint) pLocation :(int *) OutIndex
{
	for(int pIndex = 0; pIndex < [m_pWordArr count]; pIndex++)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		if(pItem.m_bHaveWord && CGRectContainsPoint([pItem getTouchRect]
															 ,pLocation))
		{
			//CCLOG(@"itemForTouch[%d]",pIndex);
			
			* OutIndex = pIndex;
			
			return pItem;
		}
	}
	
	return nil;
}

-(Word*)itemByFileName:(NSString*)pFileName
{
	if(pFileName == nil)
	{
		return nil;
	}
	
	for(int pIndex = 0; pIndex < [m_pWordArr count]; pIndex++)
	{
		Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
		
		if(!pItem)
			continue;
		
		if(pItem.m_bHaveWord && [pFileName isEqualToString:[pItem getFileName]])
		{
			return pItem;
		}
	}
	
	return nil;
}

-(void) GuessWordSuccess
{
	//猜单词成功
	[self NotifiySuccess];
}

-(void) NotifiySuccess
{
	
}

-(void) NotifiyPass
{
	
}

-(void) NotifiyBomb
{
	
}

-(void) NotifiyChangeMode
{
	
}

-(void) SetNextTurn
{
	m_nCurTurn ++;
	
	m_bHaveUseBomb = NO;
	
	if(m_nCurTurn >= m_nTotalTurn)
	{
		//结束，恭喜答对
		CCLOG(@"END");
		
		CGSize size = [CCDirector sharedDirector].winSize;
		
		CCSprite * word_guess_right = [CCSprite spriteWithSpriteFrameName:@"word_guess_right.png"];
		word_guess_right.position = ccp(size.width/2 + 40,260);
		[self addChild:word_guess_right];
		
		CCScaleTo  *  ScaleTo1 = [CCScaleTo  actionWithDuration:0.2f scale:1.3f];
		CCScaleTo  *  ScaleTo2 = [CCScaleTo  actionWithDuration:0.2f scale:1.0f];
		CCCallFunc *  CallFunc = [CCCallFunc actionWithTarget:self selector:@selector(GuessWordSuccess)];
		
		CCSequence *  ScaleTo  = [CCSequence actions:ScaleTo1,ScaleTo2,CallFunc,nil];
		
		[word_guess_right runAction:ScaleTo];
		
		//[self performSelector:@selector(GuessWordSuccess) withObject:nil afterDelay:0.5f];
		
		return;
	}
	
	if(m_bIsPingYin)
	{
		//答案选择背景和箭头移动
		CCSprite * old_word_gezi_arrow = (CCSprite*)[self getChildByTag:PlayWordLayer_AnswerSel_Arrow_tag];
		if(old_word_gezi_arrow)
		{
			[self removeChild:old_word_gezi_arrow cleanup:YES];
		}
		
		CCSprite * word_geziSel    = (CCSprite*)[self getChildByTag:PlayWordLayer_AnswerSelBg_tag];
		CCSprite * word_gezi       = (CCSprite*)[self getChildByTag:(PlayWordLayer_PinYin_Answer_Name_tag + m_nCurTurn)];
		
		CCMoveTo   * pMoveTo1   = [CCMoveTo   actionWithDuration:0.2f position:word_gezi.position];
		//CCMoveTo   * pMoveTo2   = [CCMoveTo   actionWithDuration:0.2f position:ccp(word_gezi.position.x,word_gezi.position.y + word_gezi.contentSize.height/2 + 10)];
		
		[word_geziSel	 runAction:pMoveTo1];
		//[word_gezi_arrow runAction:pMoveTo2];
		
		CCSprite * word_gezi_arrow = [CCSprite spriteWithSpriteFrameName:@"word_gezi_arrow.png"];
		word_gezi_arrow.position = ccp(word_gezi.position.x,word_gezi.position.y + word_gezi.contentSize.height/2 + 10);
		word_gezi_arrow.tag      = PlayWordLayer_AnswerSel_Arrow_tag;
		[self addChild:word_gezi_arrow z:1];
		
		//上下动作
		CCRepeatForever * pRepeatForever = 
		[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,+5.0f)],
										   [CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,-5.0f)],
										   nil]];
		
		[word_gezi_arrow runAction:pRepeatForever];
		
		NSMutableArray * pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr1 objectAtIndex:m_nCurTurn];
		m_nAnswerCount = [pStrAnswerArr count];
		
		for(int j = 0;j < 2;j ++)
		{
			for(int i = 0;i < 6;i ++)
			{
				Word * pWord = (Word*)[m_pWordArr objectAtIndex:j*6 + i];
				
				NSMutableArray * pChoiceStrArr = (NSMutableArray*)[m_pChoiceArr1 objectAtIndex:m_nCurTurn];
				
				[pWord setState:Word_State_Choice];
				[pWord setFileName:[pChoiceStrArr objectAtIndex:(j*6 + i)]];
				
				[pWord setOneClickAction];
			}
		}
		
		[self InitAnswerArea];
	}
	else
	{
		CCSprite * old_word_gezi_arrow = (CCSprite*)[self getChildByTag:PlayWordLayer_AnswerSel_Arrow_tag];
		if(old_word_gezi_arrow)
		{
			[self removeChild:old_word_gezi_arrow cleanup:YES];
		}
		
		CCSprite * word_gezi = (CCSprite*)[self getChildByTag:PlayWordLayer_BuShou_Answer_Name_tag + m_nCurTurn];
		
		CCSprite * word_gezi_arrow = [CCSprite spriteWithSpriteFrameName:@"word_gezi_arrow.png"];
		word_gezi_arrow.position = ccp(word_gezi.position.x,word_gezi.position.y + word_gezi.contentSize.height/2 + 10);
		word_gezi_arrow.tag      = PlayWordLayer_AnswerSel_Arrow_tag;
		[self addChild:word_gezi_arrow z:1];
		
		//上下动作
		CCRepeatForever * pRepeatForever = 
		[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,+5.0f)],
										   [CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,-5.0f)],
										   nil]];
		
		[word_gezi_arrow runAction:pRepeatForever];
		
		NSMutableArray * pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr2 objectAtIndex:m_nCurTurn];
		m_nAnswerCount = [pStrAnswerArr count];
		
		//CGSize size = [CCDirector sharedDirector].winSize;
		
		for(int j = 0;j < 2;j ++)
		{
			for(int i = 0;i < 6;i ++)
			{
				Word * pWord = (Word*)[m_pWordArr objectAtIndex:j*6 + i];
				
				NSMutableArray * pChoiceStrArr = (NSMutableArray*)[m_pChoiceArr2 objectAtIndex:m_nCurTurn];
				
				/*
				pWord.scale    = 1.0f;
				pWord.position = ccp(size.width - WORD_POS.x - (i+1)* WORD_OFFSET.x - i * pWord.contentSize.width,
									 WORD_POS.y + (j+1)* WORD_OFFSET.y + j * pWord.contentSize.height);
				*/
				
				[pWord setState:Word_State_Choice];
				[pWord setFileName:[pChoiceStrArr objectAtIndex:(j*6 + i)]];
				
				[pWord setOneClickAction];
			}
		}
		
		[self InitAnswerArea];
	}
}

-(void) DoReplayEvent:(OC_Guess_Event*) pEvent
{
	if(pEvent)
	{
		switch (pEvent.m_nType) 
		{
			case Guess_Event_Type_Delete:
			{
				Word * pItem = (Word *)[m_pWordArr objectAtIndex:pEvent.m_nIndex];
				
				if(pItem)
				{
					[pItem setFileName:nil];
				}
				
				break;
			}
			case Guess_Event_Type_Replace:
			{
				//[self oneReplage:pEvent.m_nIndex:pEvent.m_nChange];
				Word * pSelectedItem     = (Word*)[m_pWordArr objectAtIndex:pEvent.m_nIndex];
				Word * pCollisionItem    = (Word*)[m_pWordArr objectAtIndex:pEvent.m_nChange];
				
				NSString * pTemp = [pSelectedItem getFileName];
				
				if(pSelectedItem)
				{
					[pSelectedItem setFileName:[pCollisionItem getFileName]];
				}
				
				if(pCollisionItem)
				{
					[pCollisionItem setFileName:pTemp];
				}
				
				[pSelectedItem   setOneClickAction];
				[pCollisionItem	 setOneClickAction];
				
				//[SoundHelp playEffect:TOUCH_EFFECT];
			}
				break;
				
			case Guess_Event_Type_ClickBuShou:
			{
				[self oneClickBuShou:pEvent.m_nIndex];
			}
				break;
			case Guess_Event_Type_NextTurn:
			{
				[self AnswerMoveToName];
				[self ShowAnswerName];
			}
				break;
			case Guess_Event_Type_ChangeMode:
			{
				[self ChangeMode];
			}
				break;
			case Guess_Event_Type_Bomb:
			{
				[self UseBomb];
			}
				break;
			case Guess_Event_Type_Pass:
			{
				[self NotifiyPass];
			}
				break;
			case Guess_Event_Type_Success:
			{
				[self NotifiySuccess];
			}
				break;
			default:
				break;
		}
	}
}

-(void) CheckAnswer
{
	if(m_nCurTurn >= m_nTotalTurn)
	{
		return;
	}
	
	BOOL bIsRight = YES;
	
	if(m_bIsPingYin)
	{
		for(int pIndex = CHOICE_NUM;pIndex < [m_pWordArr count];pIndex ++)
		{
			Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndex];
			
			if(!pItem)
			{
				bIsRight = NO;
				break;
			}
			
			if(!pItem.m_bHaveWord)
			{
				bIsRight = NO;
				break;
			}
			
			NSMutableArray * pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr1 objectAtIndex:m_nCurTurn];
			if(![[pItem getFileName] isEqualToString:[pStrAnswerArr objectAtIndex:(pIndex - CHOICE_NUM)]])
			{
				bIsRight = NO;
				break;
			}
		}
		
		if(bIsRight)
		{
			if(!m_bIsReplay)
			{
				CCLOG(@"bIsRight");
				
				[self AnswerMoveToName];
				[self ShowAnswerName];
				
				CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
				
				OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_NextTurn :0 :0 :(pNow - m_LastTime)];
				
				m_LastTime = pNow;
				
				[m_pReplayListArr addObject:pGuess_Event];
			}
			
			if(m_bIsWrong)
			{
				CCSprite * pRedBg = (CCSprite*)[self getChildByTag:PlayWordLayer_WordRed_BG_tag];
				if(pRedBg)
				{
					[self removeChild:pRedBg cleanup:YES];
				}
				
				CGSize size = [CCDirector sharedDirector].winSize;
				//蓝色底背景
				CCSprite * pLanSeBg = [CCSprite spriteWithSpriteFrameName:@"word_lansedi_bg.png"];
				pLanSeBg.position = ccp(size.width/2,ANSWER_POS.y);
				pLanSeBg.tag      = PlayWordLayer_WordBlue_BG_tag;
				//pLanSeBg.opacity  = 200.0f;
				[self addChild:pLanSeBg z:PlayWordLayer_Z_WordBigBG];
				
				m_bIsWrong = NO;
			}
		}
		else
		{
			//检测背景颜色
			if([self FindIdleAnswer] == -1)
			{
				if(!m_bIsWrong)
				{
					CCSprite * pLanSeBg = (CCSprite*)[self getChildByTag:PlayWordLayer_WordBlue_BG_tag];
					if(pLanSeBg)
					{
						[self removeChild:pLanSeBg cleanup:YES];
					}
					
					CGSize size = [CCDirector sharedDirector].winSize;
					CCSprite * pRedBg = [CCSprite spriteWithSpriteFrameName:@"word_wrong_bg.png"];
					pRedBg.position = ccp(size.width/2,ANSWER_POS.y);
					pRedBg.tag      = PlayWordLayer_WordRed_BG_tag;
					//pLanSeBg.opacity  = 200.0f;
					[self addChild:pRedBg z:PlayWordLayer_Z_WordBigBG];
					
					m_bIsWrong = YES;
				}
			}
			else
			{
				if(m_bIsWrong)
				{
					CCSprite * pRedBg = (CCSprite*)[self getChildByTag:PlayWordLayer_WordRed_BG_tag];
					if(pRedBg)
					{
						[self removeChild:pRedBg cleanup:YES];
					}
					
					CGSize size = [CCDirector sharedDirector].winSize;
					//蓝色底背景
					CCSprite * pLanSeBg = [CCSprite spriteWithSpriteFrameName:@"word_lansedi_bg.png"];
					pLanSeBg.position = ccp(size.width/2,ANSWER_POS.y);
					pLanSeBg.tag      = PlayWordLayer_WordBlue_BG_tag;
					//pLanSeBg.opacity  = 200.0f;
					[self addChild:pLanSeBg z:PlayWordLayer_Z_WordBigBG];
					
					m_bIsWrong = NO;
				}
			}
		}
	}
	else
	{
		NSLog(@"m_pTempAnswerArr[%@]",m_pTempAnswerArr);
		
		if([m_pTempAnswerArr count] > 0)
		{
			NSString * pStructStr = [m_pTempAnswerArr objectAtIndex:0];
			NSInteger  pStructNum = [[pStructStr substringWithRange:NSMakeRange(0,1)] intValue];
			
			if(pStructNum == 3)
			{
				NSMutableArray * pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr2 objectAtIndex:m_nCurTurn];
				
				if([pStructStr isEqualToString:[pStrAnswerArr objectAtIndex:0]])
				{
					bIsRight = YES;
				}
				else
				{
					bIsRight = NO;
				}
			}
			else
			{
				if([m_pTempAnswerArr count] == 1)
				{
					return;
				}
				if([m_pTempAnswerArr count] == 2)
				{
					//2个时候才取检测
					NSMutableArray * pStrAnswerArr = (NSMutableArray*)[m_pAnswerArr2 objectAtIndex:m_nCurTurn];
					
					int i = 0;
					NSString * pAnswer1 = (NSString*)[pStrAnswerArr objectAtIndex:0];
					NSString * pAnswer2 = (NSString*)[pStrAnswerArr objectAtIndex:1];
					
					NSString * pTemp1   = (NSString*)[m_pTempAnswerArr objectAtIndex:0];
					NSString * pTemp2   = (NSString*)[m_pTempAnswerArr objectAtIndex:1];
					
					if([pTemp1 isEqualToString:pAnswer1])
					{
						bIsRight = YES;
						i = 1;
					}
					else if([pTemp1 isEqualToString:pAnswer2])
					{
						bIsRight = YES;
						i = 2;
					}
					else
					{
						bIsRight = NO;
					}
					
					if(bIsRight)
					{
						if(i == 1)
						{
							if([pTemp2 isEqualToString:pAnswer2])
							{
								bIsRight = YES;
							}
							else
							{
								bIsRight = NO;
							}
						}
						else
						{
							if([pTemp2 isEqualToString:pAnswer1])
							{
								bIsRight = YES;
							}
							else
							{
								bIsRight = NO;
							}
						}
					}
				}
			}
			
			if(bIsRight)
			{
				if(!m_bIsReplay)
				{
					CCLOG(@"bIsRight");
					
					m_bIsCheckAnswer = YES;
					
					[self AnswerMoveToName];
					[self ShowAnswerName];
					
					CFTimeInterval pNow = CFAbsoluteTimeGetCurrent();
					
					OC_Guess_Event * pGuess_Event = [OC_Guess_Event GuessEventWithItems:Guess_Event_Type_NextTurn :0 :0 :(pNow - m_LastTime)];
					
					m_LastTime = pNow;
					
					[m_pReplayListArr addObject:pGuess_Event];
				}
			}
			else
			{
				//显示叉
				CCLOG(@"bIsWrong");
				
				m_bIsCheckAnswer = YES;
				
				[self ShowBuShouWrong];
			}
		}
	}
}

- (void) CheckCollision
{
	if(m_pSelectedItem)
	{
		CGRect pSelectRect = [m_pSelectedItem getTouchRect];
		
		//Word * pItem = NULL;
		
		bool pIsCollision = false;
		
		for(int pIndexCollision = 0; pIndexCollision < [m_pWordArr count]; pIndexCollision++)
		{
			Word * pItem = (Word*)[m_pWordArr objectAtIndex:pIndexCollision];
			
			if(!pItem)
				continue;
			
			//if(pItem == pSelectItem)
			//	continue;
			
			CGRect pRect = [pItem getTouchRect];
			
			CGPoint pInterRectLeftUp;
			CGPoint pInterRectRightDown;
			
			if(CGRectIntersectsRect(pSelectRect,pRect))
			{
				/* 相交区域左上点X为2个矩形左上点X的最大值 */ 
				pInterRectLeftUp.x = MAX(pSelectRect.origin.x,pRect.origin.x);
				
				/* 相交区域左上点Y为2个矩形左上点Y的最大值 */ 
				pInterRectLeftUp.y = MAX(pSelectRect.origin.y,pRect.origin.y);  
				
				/* 相交区域右下点X为2个矩形右下点X的最小值 */ 
				pInterRectRightDown.x = MIN(pSelectRect.origin.x + pSelectRect.size.width,
											pRect.origin.x       + pRect.size.width);  
				
				/* 相交区域右下点Y为2个矩形右下点Y的最小值 */
				pInterRectRightDown.y = MIN(pSelectRect.origin.y + pSelectRect.size.height,
											pRect.origin.y       + pRect.size.height);
				
				if( (pInterRectRightDown.x - pInterRectLeftUp.x) >= (m_pSelectedItem.contentSize.width/2 - WORD_OFFSET.x) 
				   && (pInterRectRightDown.y - pInterRectLeftUp.y)>= (m_pSelectedItem.contentSize.height/2 - WORD_OFFSET.y))
				{
					pIsCollision = true;
					
					//CCLOG(@"CheckCollision[%d]",pIndexCollision);
					
					m_nCollisionIndex = pIndexCollision;
					
					//先把上一次设为false
					//再把这一次设为true
					
					if(m_nLastMovingSelected != -1 && pIndexCollision != m_nLastMovingSelected)
					{
						//没有碰撞
						Word * pItem = (Word*)[m_pWordArr objectAtIndex:m_nLastMovingSelected];
						if(pItem)
						{
							[pItem setMovingSelected:false];
						}
					}
					
					[pItem setMovingSelected:true];
					
					m_nLastMovingSelected = pIndexCollision;
					
					break;
				}
			}
		}
		
		if(!pIsCollision)
		{
			//没有碰撞
			
			m_nCollisionIndex = -1;
			
			if(m_nLastMovingSelected != -1)
			{
				Word * pItem = (Word*)[m_pWordArr objectAtIndex:m_nLastMovingSelected];
				if(pItem)
				{
					[pItem setMovingSelected:false];
				}
			}
		}
		
		m_bIsCollision = pIsCollision;
	}
}

@end
