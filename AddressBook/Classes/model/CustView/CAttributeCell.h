//
//  CAttributeCell.h
//  Pulp Dossier
//
//  Created by Courtney Holmes on 6/7/11.
//  Copyright 2011 CJ Holmes. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CAttributeCell : UITableViewCell 
{
	id dataTarget;
	NSString * dataKey;
	UIViewController * controller;
}

@property (nonatomic, readonly) id dataTarget;
@property (nonatomic, readonly) NSString *dataKey;
@property (nonatomic, retain)   UIViewController *controller;

/**
 *	Set the source of the text data here.  The cell will pull the NSString data
 *	using Key-Value Coding.
 */
- (void)setTarget:(id)target withKey:(NSString*)key;

@end
