//
//  CAttributeConstellation.h
//  AddressBook
//
//  Created by Peteo on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  星座
/*
水平座 《1/21～2/18》 狮子座 《 7/23～ 8/23》
双鱼座 《2/19～3/20》 处女座 《 8/24～ 9/22》
牡羊座 《3/21～4/20》 天秤座 《 9/23～10/23》
金牛座 《4/21～5/21》 天蝎座 《10/24～11/22》
双子座 《5/22～6/21》 射手座 《11/23～12/21》
巨蟹座 《6/22～7/22》 摩羯座 《12/22～ 1/20》
*/

#import <Foundation/Foundation.h>

#import "CAttribute.h"

@interface CAttributeConstellation : CAttribute 
{
	NSArray * m_pDateArry;
	
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;

@end
