//
//  LayerGroup.m
//  AddressBook
//
//  Created by Peteo on 11-10-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LayerGroup.h"


@implementation LayerGroup


- (id)initWithFrame:(CGRect)frame 
{    
    self = [super initWithFrame:frame];
    if (self) 
	{
        // Initialization code.
		//UIView * view = [[UIView alloc] initWithFrame:frame];
		
		//[self setBackgroundColor:[UIColor blackColor]];
		//[self setAlpha:0.5f];
		
		UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 202, 273)];
		[contentView setImage:[UIImage imageNamed:@"gl_blueAll.png"]];
		[contentView setUserInteractionEnabled:YES];
		[self addSubview:contentView];
		[contentView release];
		
		
		m_pTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 58, 202, 273)];
		m_pTableView.backgroundColor = [UIColor clearColor];
		
		m_pTableView.scrollEnabled = NO;
		
		m_pTableView.delegate   = self;
		m_pTableView.dataSource = self;
		
		[self addSubview:m_pTableView];
		
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
	[m_pTableView release];
	
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
				cell.textLabel.text = @"组名"; 
				break;
			}
			case 1:
			{
				cell.textLabel.text = @"发送群组信息"; 
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
		default:
			break;
	}
	
	[self removeFromSuperview];
}

@end
