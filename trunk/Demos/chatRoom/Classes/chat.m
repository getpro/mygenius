    //
//  chat.m
//  chatRoom
//
//  Created by Peteo on 11-8-7.
//  Copyright 2011 The9. All rights reserved.
//

#import "chat.h"
#import "DialogView.h"

#import "chatRoomAppDelegate.h"

static const float ROWHEIGHT = 60;


@implementation ChatContent

@synthesize direction,labelText;

@end




@implementation chat

//@synthesize advTable;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	//m_pAdArr = [[NSMutableArray alloc] initWithCapacity:10];
	
	//advTable.backgroundColor = [UIColor clearColor];
	//advTable.separatorStyle  = UITableViewCellSeparatorStyleNone;
	
	[chatRoomAppDelegate getAppDelegate].l.delegate = self;
	
	m_nScrollHeight = 0;
	
	[m_pScrollView setContentSize:CGSizeMake(320, m_nScrollHeight)];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	//[m_pAdArr release];
	
    [super dealloc];
}

/*
#pragma make -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return ROWHEIGHT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{	
	return [m_pAdArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *cellIdentifier = @"CELL";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		
		//NSString *text = @"test";
		
		ChatContent * pChatContent = (ChatContent*)[m_pAdArr objectAtIndex:[indexPath row]];
		
		//NSLog(@"ChatContent[%@]",pChatContent.labelText);
		
		//NSString *text = [m_pAdArr objectAtIndex:[indexPath row]];
		
		if(![pChatContent.labelText isEqualToString:@""])
		{
			CGRect frame = cell.frame;
			frame.origin.x = 5;
			frame.origin.y = 5;
			frame.size.height = ROWHEIGHT - 5;
			frame.size.width -= 10;
			DialogView *diaView = [[DialogView alloc] initWithFrame:frame];
			diaView.direction = pChatContent.direction;
			diaView.labelText = pChatContent.labelText;
			[cell addSubview:diaView];
			[diaView release];
		}
	}
	return cell;
}
*/

- (void) MyListenerEventAction:(nByte)eventCode :(NSDictionary*)photonEvent
{
	NSDictionary* eventData = nil;
	//static int i = 0;
	//const nByte POS_X = 101, POS_Y = 102, key2 = 103;
	
	// first access the inner Hash with your userdata inside the outer hash with general event data
	if(!(eventData=[photonEvent objectForKey:[KeyObject withByteValue:P_DATA]]))
		return;
	
	NSLog(@"MyListener_get_string[%@]",[eventData objectForKey:[KeyObject withStringValue:@"NSString"]]);
	
	//ChatContent * pChatContent = [[ChatContent alloc]init];
	
	//pChatContent.direction = 0;
	//pChatContent.labelText = [NSString stringWithFormat:@"%@",[eventData objectForKey:[KeyObject withStringValue:@"NSString"]]];
	
	//[m_pAdArr addObject:pChatContent];
	
	//[advTable reloadData];
	
	//[pChatContent release];
	
	UILabel * pUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, m_nScrollHeight, 320, ROWHEIGHT)];
	
	pUILabel.text = [NSString stringWithFormat:@"%@",[eventData objectForKey:[KeyObject withStringValue:@"NSString"]]];
	
	[m_pScrollView addSubview:pUILabel];
	
	m_nScrollHeight += ROWHEIGHT;
	
	[m_pScrollView setContentSize:CGSizeMake(320, m_nScrollHeight)];
	
}

- (void) MyListenerStatus:(int)statusCode
{
	
}

- (void) MyListenerOperationResult:(nByte)opCode :(int)returnCode :(NSDictionary*)returnValues :(short)invocID
{
	
}


#pragma mark -
#pragma mark 委托方法实现

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	
	if(![textField.text isEqualToString:@""])
	{
		
		//ChatContent * pChatContent = [[ChatContent alloc]init];
		
		//pChatContent.direction = 1;
		//pChatContent.labelText = textField.text;
		
		//[m_pAdArr addObject:pChatContent];
		
		//[advTable reloadData];
		
		
		UILabel * pUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, m_nScrollHeight, 320, ROWHEIGHT)];
		
		pUILabel.text = textField.text;
		
		[m_pScrollView addSubview:pUILabel];
		
		m_nScrollHeight += ROWHEIGHT;
		
		[m_pScrollView setContentSize:CGSizeMake(320, m_nScrollHeight)];
		
		//发送数据
		[[chatRoomAppDelegate getAppDelegate].m_PhotonLib sendData:textField.text];
		
		
		[pUILabel release];
		
		//[pChatContent release];
		
	}
	
	return YES;
}

@end
