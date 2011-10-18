//
//  LayerGroup.m
//  AddressBook
//
//  Created by Peteo on 11-10-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LayerGroup.h"

@implementation LayerGroup

@synthesize m_pArrImg;
@synthesize m_pName;

- (id)initWithFrame:(CGRect)frame 
{    
    self = [super initWithFrame:frame];
    if (self) 
	{
        // Initialization code.
		//UIView * view = [[UIView alloc] initWithFrame:frame];
		
		//[self setBackgroundColor:[UIColor blackColor]];
		//[self setAlpha:0.5f];
		
		m_pContentView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 202, 273)];
		[m_pContentView setImage:[UIImage imageNamed:@"gl_blueAll.png"]];
		[m_pContentView setUserInteractionEnabled:YES];
		[self addSubview:m_pContentView];
		
		
		m_pTableView = [[UITableView alloc] initWithFrame:CGRectMake(64, 55, 178, 280)];
		m_pTableView.backgroundColor = [UIColor clearColor];
		
		m_pTableView.scrollEnabled = NO;
		
		m_pTableView.delegate   = self;
		m_pTableView.dataSource = self;
		
		m_pTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		[self addSubview:m_pTableView];
		
		m_pArrImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 80, 13, 30)];
		[m_pArrImg setImage:[UIImage imageNamed:@"gl_leftArrow.png"]];
		[self addSubview:m_pArrImg];
		
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc 
{
	[m_pTableView   release];
	[m_pArrImg      release];
	[m_pContentView release];
	[m_pName        release];
	
    [super dealloc];
}


#pragma mark - UITableView delegates

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 7;
	
	return pRetNum;
}

// to determine specific row height for each cell, override this.  In this example, each row is determined
// buy the its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat result = 35;
	
	switch (indexPath.row)
	{
		case 0:
		{
			result = 35;
			break;
		}
		case 1:
		{
			 result = 36;
			break;
		}
		case 2:
		{
			result = 36;
			break;
		}
		case 3:
		{
			result = 36;
			break;
		}
		case 4:
		{
			result = 37;
			break;
		}
		case 5:
		{
			result = 37;
			break;
		}
		case 6:
		{
			result = 38;
			break;
		}
		default:
			break;
	}
	
	return  result;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	//UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	static NSString* cellIdentifier = @"LayerGroupCell";
	UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryNone;
	}
	if (cell)
	{
		cell.textLabel.textColor     = [UIColor whiteColor];
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		
		switch (row)
		{
			case 0:
			{
				cell.textLabel.text = m_pName;
				break;
			}
			case 1:
			{
				cell.textLabel.text = @"发送群组信息"; 
				break;
			}
			case 2:
			{
				cell.textLabel.text = @"发送群组邮件";
				break;
			}
			case 3:
			{
				cell.textLabel.text = @"重命名分组";
				break;
			}
			case 4:
			{
				cell.textLabel.text = @"删除分组";
				break;
			}
			case 5:
			{
				cell.textLabel.text = @"删除分组成员";
				break;
			}
			case 6:
			{
				cell.textLabel.text = @"完成";
				break;
			}
			default:
				break;
		}
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(indexPath.row == 0)
	{
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
		return;
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	switch (indexPath.row)
	{
		case 0:
		{
			break;
		}
		case 1:
		{
			break;
		}
		case 2:
		{
			break;
		}
		case 3:
		{
			break;
		}
		case 4:
		{
			break;
		}
		case 5:
		{
			break;
		}
		case 6:
		{
			break;
		}
		default:
			break;
	}
	
	[self removeFromSuperview];
}

-(void) setOffSet :(int)y
{
	if(y < 185)
	{
		//屏幕上部分显示
		m_pContentView.frame = CGRectMake(50, 50, 202, 273);
		m_pTableView.frame   = CGRectMake(64, 55, 178, 280);
		
		m_pArrImg.frame = CGRectMake(50, y + 45, 13, 30);
	}
	else
	{
		//屏幕下部分显示
		m_pContentView.frame = CGRectMake(50, 50 + 110, 202, 273);
		m_pTableView.frame   = CGRectMake(64, 55 + 110, 178, 280);
		
		m_pArrImg.frame = CGRectMake(50, y + 45, 13, 30);
	}
}

@end
