    //
//  SwitchViewController.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewController.h"
#import "PublicData.h"
#import "AddressBookAppDelegate.h"

@implementation SwitchViewController

@synthesize m_pAddressBookVC,m_paccountsVC,m_pdateVC,m_pmemoVC,m_psettingVC,m_pAddressInfoVC,m_pAddressEditVC,m_pAddressAddMoreVC;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changScene:)
	 /*收到消息后的响应函数*/ name:@"ChangeScene"
	 /*消息名字，在发消息时　　指定的*/ object:nil];
	
	[self.view setFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
	
	//加载第一个页面
	AddressBookVC * pAddressBookVC = [[AddressBookVC alloc] init];
	self.m_pAddressBookVC = pAddressBookVC;
	[self.view insertSubview:pAddressBookVC.view atIndex:0];
	[pAddressBookVC release];
	
	
}

-(UIViewController *) checkGoingView
{
	if(self.m_pAddressBookVC.view.superview != nil)
		return self.m_pAddressBookVC;
	
	else if(self.m_paccountsVC.view.superview != nil)
		return self.m_paccountsVC;
	
	else if(self.m_pdateVC.view.superview != nil)
		return self.m_pdateVC;
	
	else if(self.m_pmemoVC.view.superview != nil)
		return self.m_pmemoVC;
	
	else if(self.m_psettingVC.view.superview != nil)
		return self.m_psettingVC;
	
	else if(self.m_pAddressInfoVC.view.superview != nil)
		return self.m_pAddressInfoVC;
	
	else if(self.m_pAddressEditVC.view.superview != nil)
		return self.m_pAddressEditVC;
	
	else if(self.m_pAddressAddMoreVC.view.superview != nil)
		return self.m_pAddressAddMoreVC;
	
	return nil;
}

-(void)changScene:(NSNotification*)notification
{
	NSString * ss = nil;
	
	if([[notification object] isKindOfClass:[NSString class]])
	{
		ss = [notification object];
	}
	
	EViewIndex index = (EViewIndex)[ss intValue];
	
	CATransition *animation = [CATransition animation];
    animation.duration = 0.1f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.type = kCATransitionPush;
	
	if(rightOrLeft)
		animation.subtype = kCATransitionFromRight;
	else 
		animation.subtype = kCATransitionFromLeft;
	
	
	UIViewController *coming = nil;
	UIViewController *going  = nil;
	
	if(index == EViewAddressBook)
	{
		if (self.m_pAddressBookVC == nil)
		{
			AddressBookVC * pAddressBookVC = [[AddressBookVC alloc] init];
			self.m_pAddressBookVC = pAddressBookVC;
			[pAddressBookVC release];
		}
		
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_pAddressBookVC myInit];
		
		coming = self.m_pAddressBookVC;
		going  = [self checkGoingView];
		
	}
	
	else if(index == EViewAccounts)
	{
		if (self.m_paccountsVC == nil)
		{
			accountsVC * paccountsVC = [[accountsVC alloc] init];
			self.m_paccountsVC = paccountsVC;
			[paccountsVC release];
		}
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_paccountsVC myInit];
		
		coming = self.m_paccountsVC;
		going  = [self checkGoingView];
		
	}
	
	else if(index == EViewDate)
	{
		if (self.m_pdateVC == nil)
		{
			dateVC * pdateVC = [[dateVC alloc] init];
			self.m_pdateVC = pdateVC;
			[pdateVC release];
		}
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_pdateVC myInit];
		
		coming = self.m_pdateVC;
		going  = [self checkGoingView];
		
	}
	
	else if(index == EViewMemo)
	{
		if (self.m_pmemoVC == nil)
		{
			memoVC * pmemoVC = [[memoVC alloc] init];
			self.m_pmemoVC = pmemoVC;
			[pmemoVC release];
		}
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_pmemoVC myInit];
		
		coming = self.m_pmemoVC;
		going  = [self checkGoingView];
		
	}
	
	else if(index == EViewSetting)
	{
		if (self.m_psettingVC == nil)
		{
			settingVC * psettingVC = [[settingVC alloc] init];
			self.m_psettingVC = psettingVC;
			[psettingVC release];
		}
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_psettingVC myInit];
		
		coming = self.m_psettingVC;
		going  = [self checkGoingView];
		
	}
	
	else if(index == EViewAddressInfo)
	{
		if (self.m_pAddressInfoVC == nil)
		{
			AddressInfoVC * pAddressInfoVC = [[AddressInfoVC alloc] init];
			self.m_pAddressInfoVC = pAddressInfoVC;
			[pAddressInfoVC release];
		}
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_pAddressInfoVC myInit];
		
		coming = self.m_pAddressInfoVC;
		going  = [self checkGoingView];
		
	}
	
	else if(index == EViewAddressEdit)
	{
		if (self.m_pAddressEditVC == nil)
		{
			AddressEditVC * pAddressEditVC = [[AddressEditVC alloc] init];
			self.m_pAddressEditVC = pAddressEditVC;
			[pAddressEditVC release];
		}
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_pAddressEditVC myInit];
		
		coming = self.m_pAddressEditVC;
		going  = [self checkGoingView];
		
	}
	
	else if(index == EViewAddressAddMore)
	{
		if (self.m_pAddressAddMoreVC == nil)
		{
			AddressAddMoreVC * pAddressAddMoreVC = [[AddressAddMoreVC alloc] init];
			self.m_pAddressAddMoreVC = pAddressAddMoreVC;
			[pAddressAddMoreVC release];
		}
		
		if(![AddressBookAppDelegate getAppDelegate].back)
			[self.m_pAddressAddMoreVC myInit];
		
		coming = self.m_pAddressAddMoreVC;
		going  = [self checkGoingView];
		
	}
	
	[coming viewWillAppear:YES];
	[going viewWillDisappear:YES];
	[going.view removeFromSuperview];
	[self.view insertSubview: coming.view atIndex:0];
	[going viewDidDisappear:YES];
	[coming viewDidAppear:YES];
	
	if(teXiao)
		[self.view.layer addAnimation:animation forKey:@"animation"];
	
	
	if(![AddressBookAppDelegate getAppDelegate].back)
	{
		NSNumber * n = [NSNumber numberWithInt:index];
		[[AddressBookAppDelegate getAppDelegate].sceneID addObject:n];
	}
	
	[AddressBookAppDelegate getAppDelegate].back = NO;	
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
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangeScene" object:nil];
	
	[m_pAddressBookVC release];
	[m_paccountsVC    release];
	[m_pdateVC        release];
	[m_pmemoVC		  release];
	[m_psettingVC     release];
	
	[m_pAddressInfoVC    release];
	[m_pAddressEditVC    release];
	[m_pAddressAddMoreVC release];
	
    [super dealloc];
}


@end
