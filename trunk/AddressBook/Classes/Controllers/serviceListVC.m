//
//  serviceListVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "serviceListVC.h"
#import "serviceInfo.h"
#import "AddressBookAppDelegate.h"

@implementation serviceListVC

@synthesize m_pTableView_IB;
@synthesize m_pButtonItemEdit;
@synthesize m_pButtonItemDone;
@synthesize m_pButtonItemCancel;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"运营商规则";
	
	self.navigationItem.rightBarButtonItem = m_pButtonItemEdit;
	
	m_pTableView_IB.backgroundColor = [UIColor clearColor];
	
	m_pTableView_IB.allowsSelectionDuringEditing = YES;
	
	m_arrRule = [[NSMutableArray alloc] initWithCapacity:10];
	
	[self LoadRule];
	
	[m_pTableView_IB setEditing:NO];
	
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
	[m_pTableView_IB release];
	[m_arrRule       release];
	
    [super dealloc];
}


#pragma mark - UITableView delegates

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	//NSInteger row = [indexPath row];
	
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[tableView reloadData];
    }   
    //else if (editingStyle == UITableViewCellEditingStyleInsert) 
	//{
	//	[self presentAttributeTypeChooser];
    //}
}

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//UITableViewCellEditingStyle pRetNum = UITableViewCellEditingStyleNone;
	//NSInteger row = [indexPath row];
	/*
	if([m_pSectionArr count] == indexPath.section)
	{
		pRetNum = UITableViewCellEditingStyleInsert;
	}
	else
	{
		
	}
	*/
	return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if(!self.editing)
	{
		return ([m_arrRule count]);
	}
	return ([m_arrRule count] + 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 1;
	
	return pRetNum;
}

// to determine specific row height for each cell, override this.  In this example, each row is determined
// buy the its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat result = 40.0f;
	return  result;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//NSInteger row = [indexPath row];
	UITableViewCell *cell = nil;
	
	if([m_arrRule count] == indexPath.section)
	{
		static NSString* cellIdentifier = @"AddFieldCell";
		cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		if (cell != nil)
		{
			cell.textLabel.text = @"添加新规则";
		}
	}
	else
	{
		static NSString* cellIdentifier = @"serviceListCell";
		cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		LabelAndContent * pLabelAndContent = (LabelAndContent*)[m_arrRule objectAtIndex:indexPath.section];
		
		if (cell != nil)
		{
			cell.textLabel.text       = pLabelAndContent.m_strLabel;
			cell.detailTextLabel.text = pLabelAndContent.m_strContent;
		}
	}
	
	return cell;
}

-(void)getInfoResult:(id)labelcontent :(id)index
{
	NSString *        pIndex        = (NSString*)index;
	LabelAndContent * pLabelcontent = (LabelAndContent*)labelcontent;
	
    //NSIndexPath * pIndexPath = [NSIndexPath indexPathForRow:0 inSection:[pIndex intValue]];
	
	//UITableViewCell * pCell = [m_pTableView_IB cellForRowAtIndexPath:pIndexPath];
	
	//LabelAndContent * pArryContent = [m_arrRule objectAtIndex:[pIndex intValue]];
	
	[m_arrRule replaceObjectAtIndex:[pIndex intValue] withObject:pLabelcontent];
	
	/*
	if(pArryContent)
	{
		pArryContent.m_strLabel    = pLabelcontent.m_strLabel;
		pArryContent.m_strContent  = pLabelcontent.m_strContent;
		[m_pTableView_IB reloadData];
	}
	*/
	
	[m_pTableView_IB reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if(self.editing)
	{
		serviceInfo * pServiceInfo = [[serviceInfo alloc] init];
		
		if([m_arrRule count] != indexPath.section)
		{
			LabelAndContent * pLabelAndContent = (LabelAndContent*)[m_arrRule objectAtIndex:indexPath.section];
		
			pServiceInfo.m_strRule  = pLabelAndContent.m_strContent;
			pServiceInfo.m_strTitle = pLabelAndContent.m_strLabel;
		}
		
		pServiceInfo.m_nSection = indexPath.section;
		pServiceInfo.Target     = self;
		pServiceInfo.Selector   = @selector(getInfoResult::);
		
		[self.navigationController pushViewController:pServiceInfo animated:YES];
		
		[pServiceInfo release];
	}
	
}


-(IBAction)doneItemBtn:    (id)sender
{
	//保存属性
	
	[self setEditing:NO animated:YES];
}

-(IBAction)cancelItemBtn:  (id)sender
{
	[self setEditing:NO animated:YES];
}

-(IBAction)editItemBtn:    (id)sender
{
	[self setEditing:YES animated:YES];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animate 
{
	[super setEditing:editing animated:animate];
	[m_pTableView_IB setEditing:editing animated:animate];
	
	if (editing)
	{
		self.navigationItem.rightBarButtonItem = m_pButtonItemDone;
		//self.navigationItem.leftBarButtonItem  = m_pButtonItemCancel;
	} 
	else
	{
		self.navigationItem.rightBarButtonItem = m_pButtonItemEdit;
		//self.navigationItem.leftBarButtonItem  = m_pButtonItemReturn;
	}
 	[m_pTableView_IB reloadData];
}

-(void)LoadRule
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	[m_arrRule removeAllObjects];
	
	for(LabelAndContent * pLabelAndContent in app.m_arrServicerRule)
	{
		BOOL bHasSame = NO;
		LabelAndContent * pArrRule = nil;
		
		for(int index = 0;index < [m_arrRule count];index++)
		{
			pArrRule = (LabelAndContent*)[m_arrRule objectAtIndex:index];
			
			if([pLabelAndContent.m_strLabel isEqual:pArrRule.m_strLabel])
			{
				bHasSame = YES;
				
				//存在相同项目
				NSMutableString * pStr = [NSMutableString stringWithCapacity:10];
				
				[pStr appendString:pArrRule.m_strContent];
				
				[pStr appendString:@","];
				
				[pStr appendString:pLabelAndContent.m_strContent];
				
				pArrRule.m_strContent = pStr;
				
				break;
			}
		}
		
		if(!bHasSame)
		{
			LabelAndContent * pNew = [[LabelAndContent alloc] init];
			
			pNew.m_strContent = pLabelAndContent.m_strContent;
			pNew.m_strLabel   = pLabelAndContent.m_strLabel;
			
			[m_arrRule addObject:pNew];
			
			[pNew release];
		}
	}
	
	
	for(LabelAndContent * pLabelAndContent in m_arrRule)
	{
		NSLog(@"Label[%@]",pLabelAndContent.m_strLabel);
		NSLog(@"Content[%@]",pLabelAndContent.m_strContent);
	}
	
	[m_pTableView_IB reloadData];
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	//[self LoadRule];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

@end
