//
//  CAttributeString.h
//  Pulp Dossier
//
//  Created by Courtney Holmes on 6/6/11.
//  Copyright 2011 CJ Holmes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAttribute.h"

/*	Attributes for short text strings.
 
 */
@interface CAttributeString : CAttribute 
{
	NSString* stringValue;
}

@property (nonatomic, retain) NSString* stringValue;


@end
