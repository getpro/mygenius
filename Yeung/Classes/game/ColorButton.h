//
//  ColorButton.h
//  GuessWhat
//
//  Created by Peteo on 12-4-11.
//  Copyright 2012 The9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorButton : UIButton
{
	SEL      m_pCB;
	id       m_pTarget;
}

@property (nonatomic,assign) SEL m_pCB;
@property (nonatomic,assign) id  m_pTarget;

- (id)initWithFrame:(CGRect)frame Color:(UIColor *)theColor;

@end
