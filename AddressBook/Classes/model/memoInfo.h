//
//  memoInfo.h
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface memoInfo : NSObject 
{
	NSString  * m_strmemoID;
	NSString  * m_strmemoSubject;
	NSString  * m_strmemoDes;
	NSString  * m_strmemoDate;
	NSInteger   m_nmemoRemind;
}

@property (nonatomic, retain) NSString*	m_strmemoID;
@property (nonatomic, retain) NSString*	m_strmemoSubject;
@property (nonatomic, retain) NSString*	m_strmemoDes;
@property (nonatomic, retain) NSString*	m_strmemoDate;
@property (nonatomic, assign) NSInteger	m_nmemoRemind;

@end
