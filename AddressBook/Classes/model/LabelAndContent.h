//
//  LabelAndContent.h
//  AddressBook
//
//  Created by Peteo on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LabelAndContent : NSObject 
{
	NSString  * m_strLabel;
	NSString  * m_strContent;
}

@property (nonatomic, retain) NSString*	m_strLabel;
@property (nonatomic, retain) NSString*	m_strContent;

@end
