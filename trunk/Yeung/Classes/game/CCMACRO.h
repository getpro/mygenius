/*
 *  CCMACRO.h
 *  DrawSomeThing
 *
 *  Created by Peteo on 12-3-29.
 *  Copyright 2012 The9. All rights reserved.
 *
 *  全局的宏定义
 */


#ifndef __CC_MACRO_H
#define __CC_MACRO_H

#define DEVICE_TYPE    @"IOS"
#define VERSION_PATH   [[NSBundle mainBundle] pathForResource:@"Version" ofType:@"plist"]

#define GAME_FONT_NAME @"Arial Rounded MT Bold"

#define BADGE_RATE 20

//当前轮数 字体颜色
#define TURN_COLOR ccc3(50,79,133)

//单词的字体和大小
#define WORD_FONT_NAME @"Arial"

#define WORD_FONT_SIZE (30)

#define MAX_BOMBLIST_NUMBER  3
#define MAX_COINLIST_NUMBER  4
#define MAX_COLORLIST_NUMBER 3

//炸弹条目编号--只设置三个条目,炸弹上点的数目以及价格可以动态在服务器修改
#define BOMB_NUMBER_KEY             @"BOMB_NUMBER_KEY"
#define BOMB_PRICE_KEY              @"BOMB_PRICE_KEY"
#define BOMB_DISCOUNT_KEY           @"BOMB_DISCOUNT_KEY"

#define COIN_NUMBER_KEY             @"COIN_NUMBER_KEY"
#define COIN_PRICE_KEY              @"COIN_PRICE_KEY"
#define COIN_DISCOUNT_KEY           @"COIN_DISCOUNT_KEY"

#define COLOR_BAR_ID_KEY            @"COLOR_BAR_ID_KEY"
#define COLOR_BAR_PRICE_KEY         @"COLOR_BAR_PRICE_KEY"
#define COLOR_BAR_LIST_KEY          @"COLOR_BAR_LIST_KEY"

#define PRODUCT_KEY   (_UINT8)0
#define BOMB_KEY(ID)  [NSString stringWithFormat:@"%d", ID]

//金币条目编号
#define COIN_KEY(ID)  [NSString stringWithFormat:@"%d", ID]

#define COLOR_KEY(ID) [NSString stringWithFormat:@"%d", ID]

#define BUY_BOMB_SUCCESSED          240
#define BUY_BOMB_FAILED             241

#define BUY_COIN_SUCCESSED          250
#define BUY_COIN_FAILED             251

#define BUY_COLOR_SUCCESSED         260
#define BUY_COLOR_REPEAT            261     //颜色已购买
#define BUY_COLOR_FAILED            262


//画图Replay数据
#define DRAWDATA_FILE @"DrawData.dat"

//单词Replay数据
#define WORDDATA_FILE @"WordData.dat"

#define CC_SAFE_DELETE(p)			if(p) { delete (p); (p) = 0; }
#define CC_SAFE_DELETE_ARRAY(p)		if(p) { delete[] (p); (p) = 0; }
#define CC_SAFE_FREE(p)				if(p) { free(p); (p) = 0; }
#define CC_SAFE_RELEASE(p)			if(p) { (p)->release(); }
#define CC_SAFE_RELEASE_NULL(p)		if(p) { (p)->release(); (p) = 0; }
#define CC_SAFE_RETAIN(p)			if(p) { (p)->retain(); }
#define CC_BREAK_IF(cond)			if(cond) break;

#define IPHONE_RESOURCE_PATH(name)  [NSString stringWithFormat:@"iphone/%@",name]

#endif

