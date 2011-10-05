    //
//  AddressAddMoreVC.m
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressAddSeniorVC.h"
#import "PublicData.h"
#import "AddressBaseInfoVC.h"
#import "AddressBookAppDelegate.h"
#import "AddFieldVC.h"


typedef enum 
{
	//单项
    AddSenior_TableView_Section_Group,
	AddSenior_TableView_Section_Blood,
	AddSenior_TableView_Section_Constellation,
	AddSenior_TableView_Section_Recommend,
	
	//多项
	AddSenior_TableView_Section_Memo,
	AddSenior_TableView_Section_IM,
	AddSenior_TableView_Section_Account,
	AddSenior_TableView_Section_Certificate,
	AddSenior_TableView_Section_Relate,
	
	//添加
	AddSenior_TableView_Section_AddField,
	
	AddSenior_TableView_Section_Count
}AddSenior_TableView_Section;

@implementation AddressAddSeniorVC

@synthesize m_pTableView_IB;
@synthesize m_pRightDone;
@synthesize m_pContact;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"高级信息";
	self.navigationItem.rightBarButtonItem = m_pRightDone;
	
	m_pContainer			= [[CAttributeContainer alloc] init];
	m_pMemoContainer		= [[CAttributeContainer alloc] init];
	m_pIMContainer          = [[CAttributeContainer alloc] init];
	m_pAccountsContainer	= [[CAttributeContainer alloc] init];
	m_pCertificateContainer = [[CAttributeContainer alloc] init];
	m_pRelateContainer      = [[CAttributeContainer alloc] init];
	
	m_pSectionArr           = [[NSMutableArray alloc] initWithCapacity:AddSenior_TableView_Section_Count];
	
	CAttribute *attr = nil;
	
	attr = [[[CAttributeGroup alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"分组"];
	[m_pSectionArr addObject:@"分组"];
	
	attr = [[[CAttributeBlood alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"血型"];
	[m_pSectionArr addObject:@"血型"];
	
	attr = [[[CAttributeConstellation alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"星座"];
	[m_pSectionArr addObject:@"星座"];
	
	attr = [[[CAttributeRecommend alloc] init] autorelease];
	((CAttributeString*)attr).nvController = self.navigationController;
	[m_pContainer setValue:attr forKey:@"推荐人"];
	[m_pSectionArr addObject:@"推荐人"];
	
	attr = [[[CAttributeMemo alloc] init] autorelease];
	((CAttributeMemo*)attr).nvController = self.navigationController;
	((CAttributeMemo*)attr).m_nType      = Tag_Type_Memo;
	[m_pMemoContainer setValue:attr        forKey:@"纪念日"];
	[m_pSectionArr addObject:@"纪念日"];
	
	attr = [[[CAttributeString alloc] init] autorelease];
	((CAttributeString*)attr).nvController = self.navigationController;
	((CAttributeString*)attr).m_nType      = Tag_Type_InstantMessage;
	[m_pIMContainer setValue:attr          forKey:@"IM帐号"];
	[m_pSectionArr addObject:@"IM帐号"];
	
	attr = [[[CAttributeString alloc] init] autorelease];
	((CAttributeString*)attr).nvController = self.navigationController;
	((CAttributeString*)attr).m_nType      = Tag_Type_Account;
	[m_pAccountsContainer setValue:attr    forKey:@"银行帐号"];
	[m_pSectionArr addObject:@"银行帐号"];
	
	attr = [[[CAttributeString alloc] init] autorelease];
	((CAttributeString*)attr).nvController = self.navigationController;
	((CAttributeString*)attr).m_nType      = Tag_Type_Certificate;
	[m_pCertificateContainer setValue:attr forKey:@"证件"];
	[m_pSectionArr addObject:@"证件"];
	
	//相关联系人
	attr = [[[CAttributeRelate alloc] init] autorelease];
	((CAttributeRelate*)attr).nvController = self.navigationController;
	((CAttributeRelate*)attr).m_nType      = Tag_Type_Relate;
	[m_pRelateContainer setValue:attr forKey:@"相关联系人"];
	[m_pSectionArr addObject:@"相关联系人"];
	
	m_pTableView_IB.allowsSelectionDuringEditing = YES;
	
	[m_pTableView_IB setEditing:YES];
	[m_pTableView_IB reloadData];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pTableView_IB	  release];
	[m_pContact			  release];
	[m_pRightDone		  release];
	[m_pContainer		  release];
	[m_pIMContainer       release];
	[m_pMemoContainer	  release];
	[m_pAccountsContainer release];
	[m_pCertificateContainer release];
	[m_pRelateContainer   release];
	[m_pSectionArr        release];
	
    [super dealloc];
}

-(IBAction)doneItemBtn:  (id)sender
{
	CFErrorRef   errorRef;
	NSError    * error;
	
	ABAddressBookAddRecord(addressBook,m_pContact.record,&errorRef);
	ABAddressBookSave(addressBook, &errorRef);

	ABRecordID  pRecordID  = ABRecordGetRecordID(m_pContact.record);
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	//点击完成
	CAttributeGroup *attrGroup = nil;

	//分组
	attrGroup = [m_pContainer.attributes objectAtIndex:0];
	if(attrGroup && attrGroup.stringValue)
	{
		//设置分组
		ABRecordID pGroupID = [DataStore GetGroupID:attrGroup.stringValue];
		
		//ABGroup * pGroup = [app.m_arrGroup objectAtIndex:2];
		ABGroup * pGroup = nil;
		
		for(pGroup in app.m_arrGroup)
		{
			if(ABRecordGetRecordID(pGroup.record) == pGroupID)
			{
				break;
			}
		}
	
		//没有效果
		if([pGroup addMember:m_pContact withError:&error])
		{
			[DataStore updateGroup:pRecordID:pGroupID];
		}
	}
	
	//血型
	CAttributeBlood *attrBlood = nil;
	attrBlood = [m_pContainer.attributes objectAtIndex:1];
	if(attrBlood && attrBlood.stringValue)
	{
		[DataStore updateBlood:pRecordID:attrBlood.stringValue];
	}
	
	//星座
	CAttributeConstellation *attrConstellation = nil;
	attrConstellation = [m_pContainer.attributes objectAtIndex:2];
	if(attrConstellation && attrConstellation.stringValue)
	{
		[DataStore updateConstellation:pRecordID:attrConstellation.stringValue];
	}
	
	//推荐人
	CAttributeRecommend *attrRecommend = nil;
	attrRecommend = [m_pContainer.attributes objectAtIndex:3];
	if(attrRecommend && attrRecommend.m_pABContact)
	{
		[DataStore updateRecommend:pRecordID:ABRecordGetRecordID(attrRecommend.m_pABContact.record)];
	}
	
	//IM信息
	[DataStore removeInstantMessage:pRecordID:1];
	CAttributeString * attrInstantMessage = nil;
	for(int i = 0;i < [m_pIMContainer.attributes count];i++)
	{
		attrInstantMessage = [m_pIMContainer.attributes objectAtIndex:i];
		NSString *pContent = attrInstantMessage.m_pCell.textField.text;
		if(attrInstantMessage.label && pContent)
		{		
			[DataStore insertInstantMessage:pRecordID:pContent:nil:attrInstantMessage.label:i:1];
		}
	}
	
	//帐号
	[DataStore removeAllAccounts:pRecordID];
	
	CAttributeString * attrAccount = nil;
	for(int i = 0;i < [m_pAccountsContainer.attributes count];i++)
	{
		attrAccount = [m_pAccountsContainer.attributes objectAtIndex:i];
		NSString *pContent = attrAccount.m_pCell.textField.text;
		if(attrAccount.label && pContent)
		{
			[DataStore insertAccounts:pRecordID :pContent
									 :attrAccount.label :i];
		}
	}
	
	//证件
	[DataStore removeAllCertificate:pRecordID];
	
	CAttributeString * attrCertificate = nil;
	for(int i = 0;i < [m_pCertificateContainer.attributes count];i++)
	{
		attrCertificate = [m_pCertificateContainer.attributes objectAtIndex:i];
		NSString *pContent = attrCertificate.m_pCell.textField.text;
		if(attrCertificate.label && pContent)
		{
			[DataStore insertCertificate:pRecordID :pContent
									 :attrCertificate.label :i];
		}
	}
	
	//相关联系人
	[DataStore removeAllRelate:pRecordID];
	CAttributeRelate * attrRelate = nil;
	for(int i = 0;i < [m_pRelateContainer.attributes count];i++)
	{
		attrRelate = [m_pRelateContainer.attributes objectAtIndex:i];
		if(attrRelate && attrRelate.m_pABContact)
		{
			[DataStore insertRelate:pRecordID:ABRecordGetRecordID(attrRelate.m_pABContact.record):attrRelate.label:i];
		}
	}
	
	//纪念日
	[DataStore removeDates:pRecordID];
	CAttributeMemo * attrMemo = nil;
	for(int i = 0;i < [m_pMemoContainer.attributes count];i++)
	{
		attrMemo = [m_pMemoContainer.attributes objectAtIndex:i];
		if(attrMemo && attrMemo.m_pDate && attrMemo.label)
		{
			[DataStore insertDates:pRecordID:[attrMemo.m_pDate timeIntervalSince1970]:attrMemo.label:i:attrMemo.m_nRemindIndex:1];
		}
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

#pragma mark - AddField delegates
- (void)GetAddField:(id)pDic
{
	NSDictionary * resultItem = (NSDictionary * )pDic;
	NSString *text = nil;
	text = [resultItem valueForKey:@"name"];
	if(text)
	{
		CAttribute *attr = nil;
		
		NSLog(@"[%@]",text);
		if([text isEqual:@"纪念日"])
		{
			if([m_pMemoContainer.attributes count] == 0)
			{
				[m_pSectionArr addObject:@"纪念日"];
			}
			attr = [[[CAttributeMemo alloc] init] autorelease];
			((CAttributeMemo*)attr).nvController = self.navigationController;
			((CAttributeMemo*)attr).m_nType      = Tag_Type_Memo;
			[m_pMemoContainer setValue:attr forKey:@"纪念日"];
		}
		else if([text isEqual:@"证件"])
		{
			if([m_pCertificateContainer.attributes count] == 0)
			{
				[m_pSectionArr addObject:@"证件"];
			}
			attr = [[[CAttributeString alloc] init] autorelease];
			((CAttributeString*)attr).nvController = self.navigationController;
			((CAttributeString*)attr).m_nType      = Tag_Type_Certificate;
			[m_pCertificateContainer setValue:attr forKey:@"证件"];
		}
		else if([text isEqual:@"银行帐号"])
		{
			if([m_pAccountsContainer.attributes count] == 0)
			{
				[m_pSectionArr addObject:@"银行帐号"];
			}
			attr = [[[CAttributeString alloc] init] autorelease];
			((CAttributeString*)attr).nvController = self.navigationController;
			((CAttributeString*)attr).m_nType      = Tag_Type_Account;
			[m_pAccountsContainer setValue:attr forKey:@"银行帐号"];
		}
		else if([text isEqual:@"IM帐号"])
		{
			if([m_pIMContainer.attributes count] == 0)
			{
				[m_pSectionArr addObject:@"IM帐号"];
			}
			attr = [[[CAttributeString alloc] init] autorelease];
			((CAttributeString*)attr).nvController = self.navigationController;
			((CAttributeString*)attr).m_nType      = Tag_Type_InstantMessage;
			[m_pIMContainer setValue:attr forKey:@"IM帐号"];
		}
		else if([text isEqual:@"相关联系人"])
		{
			if([m_pRelateContainer.attributes count] == 0)
			{
				[m_pSectionArr addObject:@"相关联系人"];
			}
			attr = [[[CAttributeRelate alloc] init] autorelease];
			((CAttributeRelate*)attr).nvController = self.navigationController;
			((CAttributeRelate*)attr).m_nType      = Tag_Type_Relate;
			[m_pRelateContainer setValue:attr forKey:@"相关联系人"];
		}
		
		[m_pTableView_IB reloadData];
	}
}

#pragma mark - UITableView delegates

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	NSInteger row = [indexPath row];
	
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		//switch (indexPath.section)
		{
			NSString * pSectionName = [m_pSectionArr objectAtIndex:indexPath.section];
			
			if([pSectionName isEqual:@"纪念日"])
			{
				[m_pMemoContainer.attributes removeObjectAtIndex:row];
				if([m_pMemoContainer.attributes count] == 0)
				{
					[m_pSectionArr removeObject:@"纪念日"];
				}
			}
			else if([pSectionName isEqual:@"银行帐号"])
			{
				[m_pAccountsContainer.attributes removeObjectAtIndex:row];
				if([m_pAccountsContainer.attributes count] == 0)
				{
					[m_pSectionArr removeObject:@"银行帐号"];
				}
			}
			else if([pSectionName isEqual:@"证件"])
			{
				[m_pCertificateContainer.attributes removeObjectAtIndex:row];
				if([m_pCertificateContainer.attributes count] == 0)
				{
					[m_pSectionArr removeObject:@"证件"];
				}
			}
			else if([pSectionName isEqual:@"IM帐号"])
			{
				[m_pIMContainer.attributes removeObjectAtIndex:row];
				if([m_pIMContainer.attributes count] == 0)
				{
					[m_pSectionArr removeObject:@"IM帐号"];
				}
			}
			else if([pSectionName isEqual:@"相关联系人"])
			{
				[m_pRelateContainer.attributes removeObjectAtIndex:row];
				if([m_pRelateContainer.attributes count] == 0)
				{
					[m_pSectionArr removeObject:@"相关联系人"];
				}
			}
		}
		
		[tableView reloadData];
		//indexPath.section减1
		//[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
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
	UITableViewCellEditingStyle pRetNum = UITableViewCellEditingStyleNone;
	//NSInteger row = [indexPath row];
	
	if([m_pSectionArr count] == indexPath.section)
	{
		pRetNum = UITableViewCellEditingStyleInsert;
	}
	else
	{
		NSString * pSectionName = [m_pSectionArr objectAtIndex:indexPath.section];
		
		if([pSectionName isEqual:@"分组"])
		{
			pRetNum = UITableViewCellEditingStyleNone;
		}
		else if([pSectionName isEqual:@"血型"])
		{
			pRetNum = UITableViewCellEditingStyleNone;
		}
		else if([pSectionName isEqual:@"星座"])
		{
			pRetNum = UITableViewCellEditingStyleNone;
		}
		else if([pSectionName isEqual:@"推荐人"])
		{
			pRetNum = UITableViewCellEditingStyleNone;
		}
		else if([pSectionName isEqual:@"纪念日"])
		{
			pRetNum = UITableViewCellEditingStyleDelete;
		}
		else if([pSectionName isEqual:@"银行帐号"])
		{
			pRetNum = UITableViewCellEditingStyleDelete;
		}
		else if([pSectionName isEqual:@"证件"])
		{
			pRetNum = UITableViewCellEditingStyleDelete;
		}
		else if([pSectionName isEqual:@"IM帐号"])
		{
			pRetNum = UITableViewCellEditingStyleDelete;
		}
		else if([pSectionName isEqual:@"相关联系人"])
		{
			pRetNum = UITableViewCellEditingStyleDelete;
		}
	}
	return pRetNum;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//return AddSenior_TableView_Section_Count;
	return ([m_pSectionArr count] + 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 1;

	if([m_pSectionArr count] == section)
	{
		pRetNum = 1;
	}
	else
	{
		NSString * pSectionName = [m_pSectionArr objectAtIndex:section];
		
		if([pSectionName isEqual:@"分组"])
		{
			pRetNum = 1;
		}
		else if([pSectionName isEqual:@"血型"])
		{
			pRetNum = 1;
		}
		else if([pSectionName isEqual:@"星座"])
		{
			pRetNum = 1;
		}
		else if([pSectionName isEqual:@"推荐人"])
		{
			pRetNum = 1;
		}
		else if([pSectionName isEqual:@"纪念日"])
		{
			pRetNum = [m_pMemoContainer.attributes count];
		}
		else if([pSectionName isEqual:@"银行帐号"])
		{
			pRetNum = [m_pAccountsContainer.attributes count];
		}
		else if([pSectionName isEqual:@"证件"])
		{
			pRetNum = [m_pCertificateContainer.attributes count];
		}
		else if([pSectionName isEqual:@"IM帐号"])
		{
			pRetNum = [m_pIMContainer.attributes count];
		}
		else if([pSectionName isEqual:@"相关联系人"])
		{
			pRetNum = [m_pRelateContainer.attributes count];
		}
	}
	
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
	CAttribute      *attr = nil;
	
	if([m_pSectionArr count] == indexPath.section)
	{
		static NSString* cellIdentifier = @"AddFieldCell";
		UITableViewCell * cell2 = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		if (![cell2 isKindOfClass:[UITableViewCell class]])
		{
			cell2 = [[[CAttributeCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
			cell2.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		if (cell2 != nil)
		{
			cell2.textLabel.text = @"添加字段";
		}
		return cell2;
	}
	else
	{
		attr = [self getAttribute:indexPath];
	}
	
	cell = [attr cellForTableView:tableView];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UIViewController *vc   = nil;
	CAttribute       *attr = nil;
	//NSInteger row = [indexPath row];
	
	if([m_pSectionArr count] == indexPath.section)
	{
		NSLog(@"AddField");
		
		AddFieldVC * pVC = [[AddFieldVC alloc] init];
		
		pVC.Target   = self;
		pVC.Selector = @selector(GetAddField:);
		
		[self.navigationController pushViewController:pVC animated:YES];
		
		[pVC release];
		
		return;
	}
	else
	{
		attr = [self getAttribute:indexPath];
	}
	
	if (attr)
	{
		vc = [attr detailViewController:self.editing];
	}
	
	if (vc && attr)
	{
		[attr Show:vc];
	}
}

- (CAttribute*) getAttribute:(NSIndexPath *)indexPath
{
	CAttribute       *attr = nil;
	NSString * pSectionName = [m_pSectionArr objectAtIndex:indexPath.section];
	NSInteger row = [indexPath row];
	
	if(pSectionName == nil)
		return nil;
	
	if([pSectionName isEqual:@"分组"])
	{
		attr = [m_pContainer.attributes objectAtIndex:indexPath.section];
	}
	else if([pSectionName isEqual:@"血型"])
	{
		attr = [m_pContainer.attributes objectAtIndex:indexPath.section];
	}
	else if([pSectionName isEqual:@"星座"])
	{
		attr = [m_pContainer.attributes objectAtIndex:indexPath.section];
	}
	else if([pSectionName isEqual:@"推荐人"])
	{
		attr = [m_pContainer.attributes objectAtIndex:indexPath.section];
	}
	else if([pSectionName isEqual:@"纪念日"])
	{
		attr = [m_pMemoContainer.attributes objectAtIndex:row];
	}
	else if([pSectionName isEqual:@"银行帐号"])
	{
		attr = [m_pAccountsContainer.attributes objectAtIndex:row];
	}
	else if([pSectionName isEqual:@"证件"])
	{
		attr = [m_pCertificateContainer.attributes objectAtIndex:row];
	}
	else if([pSectionName isEqual:@"IM帐号"])
	{
		attr = [m_pIMContainer.attributes objectAtIndex:row];
	}
	else if([pSectionName isEqual:@"相关联系人"])
	{
		attr = [m_pRelateContainer.attributes objectAtIndex:row];
	}
	return attr;
}

@end
