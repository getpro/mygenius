//
//  syncButtonCell.m
//  AddressBook
//
//  Created by Peteo on 11-9-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "syncButtonCell.h"
#import "PublicData.h"

@implementation syncButtonCell

NSString *KsyncButtonCell_ID = @"syncButtonCell";

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(ESyncButtonType)type
{    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        // Initialization code.
		if(type == ESyncButtonType_Sync)
		{
			UIImage * pImg = [UIImage imageNamed:@"synchronous.png"];
			UIImageView * pImgView = [[[UIImageView alloc] initWithFrame:CGRectMake(25,10, pImg.size.width, pImg.size.height)] autorelease];
			[pImgView setImage:pImg];
			[self addSubview:pImgView];
			
			UILabel * pLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,0,50,self.frame.size.height)];
			pLabel.textAlignment = UITextAlignmentLeft;
			pLabel.backgroundColor = [UIColor clearColor];
			pLabel.font = [UIFont fontWithName:FONT_NAME size:20];
			pLabel.textColor = [UIColor blackColor];
			pLabel.text = @"同步";
			[self addSubview:pLabel];
			
			UILabel * pTip = [[UILabel alloc] initWithFrame:CGRectMake(190,0,110,self.frame.size.height)];
			pTip.textAlignment = UITextAlignmentLeft;
			pTip.backgroundColor = [UIColor clearColor];
			pTip.font = [UIFont fontWithName:FONT_NAME size:12];
			pTip.textColor = [UIColor grayColor];
			pTip.text = @"同步联系人到手机";
			[self addSubview:pTip];
			
		}
		else if(type == ESyncButtonType_BackUp)
		{
			UIImage * pImg = [UIImage imageNamed:@"backup.png"];
			UIImageView * pImgView = [[[UIImageView alloc] initWithFrame:CGRectMake(25,10, pImg.size.width, pImg.size.height)] autorelease];
			[pImgView setImage:pImg];
			[self addSubview:pImgView];
			
			UILabel * pLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,0,50,self.frame.size.height)];
			pLabel.textAlignment = UITextAlignmentLeft;
			pLabel.backgroundColor = [UIColor clearColor];
			pLabel.font = [UIFont fontWithName:FONT_NAME size:20];
			pLabel.textColor = [UIColor blackColor];
			pLabel.text = @"备份";
			[self addSubview:pLabel];
			
			UILabel * pTip = [[UILabel alloc] initWithFrame:CGRectMake(190,0,110,self.frame.size.height)];
			pTip.textAlignment = UITextAlignmentLeft;
			pTip.backgroundColor = [UIColor clearColor];
			pTip.font = [UIFont fontWithName:FONT_NAME size:12];
			pTip.textColor = [UIColor grayColor];
			pTip.text = @"备份联系人到云端";
			[self addSubview:pTip];
		}
		
		//右箭头
		UIImage * pArrowImg = [UIImage imageNamed:@"arrow.png"];
		UIImageView * pArrowView = [[[UIImageView alloc] initWithImage:pArrowImg] autorelease];
		[pArrowView setFrame:CGRectMake(290, 15, pArrowImg.size.width, pArrowImg.size.height)];
		[self addSubview:pArrowView];
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
