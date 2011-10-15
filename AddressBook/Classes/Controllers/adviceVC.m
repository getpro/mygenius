//
//  adviceVC.m
//  AddressBook
//
//  Created by Peteo on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*
类型	名称	是否必须	备注
text/hidden	title	是	留言主题
text/hidden	name	是	留言者姓名
text/hidden	email	是	电子邮箱
textarea	content	是	留言内容
*/

#import "adviceVC.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define ADVICE_URL @"http://www.nilayahome.com/iphone/sybook/booksave.asp"

@implementation adviceVC

@synthesize m_pTextPhone;
@synthesize m_pTextContent;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	m_pTextPhone.tag   = 0;
	m_pTextContent.tag = 1;
	
	m_pTextPhone.delegate   = self;
	m_pTextContent.delegate = self;
	
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
	[m_pTextPhone   release];
	[m_pTextContent release];
	
    [super dealloc];
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{	
    if ([@"\n" isEqualToString:text] == YES)
	{
		if(textView.tag == 0)
		{
			[textView resignFirstResponder];
			[m_pTextContent becomeFirstResponder];
		}
		else if(textView.tag == 1)
		{
			[textView resignFirstResponder];
			
			//发送请求
			
			/*
			NSString *post = @"title=122&name=test&email=11@163.com&content=1122";  
			
			//NSString *post = @"";  
			NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding];
			NSMutableURLRequest *connectionRequest = [NSMutableURLRequest 
													  requestWithURL:[NSURL URLWithString:ADVICE_URL]];
			[connectionRequest setHTTPMethod:@"POST"];
			[connectionRequest setTimeoutInterval:100.0];
			[connectionRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
			[connectionRequest setHTTPBody:postData];
			NSData *data=[NSURLConnection sendSynchronousRequest:connectionRequest returningResponse:nil error:nil];
			NSString *stringdata=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];    
			NSLog(@"%d",[data length]);
			
			NSLog(@"%@",stringdata);
			*/
			
			
			NSURL *url = [NSURL URLWithString:ADVICE_URL];
			ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:url];
			[theRequest setRequestMethod:@"POST"];

			
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
			//[theRequest setShouldContinueWhenAppEntersBackground:YES];
#endif
			
			[theRequest setAllowCompressedResponse:NO];
			ASIHTTPRequest.shouldUpdateNetworkActivityIndicator = YES;
			
			[theRequest appendPostData: [[NSString stringWithFormat:@"title=phone&name=advice&email=%@&content=%@",m_pTextPhone.text,m_pTextContent.text] dataUsingEncoding:NSUTF8StringEncoding]];
			
			[theRequest setTimeOutSeconds:10];
			[theRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded; charset=UTF-8"];
			
			[theRequest buildPostBody];
			
			NSLog(@"theRequest head = %@",[theRequest requestHeaders]);
			
			[theRequest startSynchronous];
			
			NSError *error = [theRequest error];
			if (!error)
			{
                NSString* response = [theRequest responseString];
                //NSLog(@"feedback response = %@",response);
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:response
															   delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
				[alert show];	
				[alert release];
			}
			else
			{
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络无法连接"
															   delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
				[alert show];	
				[alert release];
			}
		}
        return NO;
    }
    return YES;
} 

/*
- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
	NSString *responseString = [request responseString];
	
	NSLog(@"%@",responseString);
	
	// Use when fetching binary data
	NSData *responseData = [request responseData];
	
	NSString *stringdata=[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];  
	
	
	NSLog(@"%@",stringdata);
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	//NSError *error = [request error];
}
*/

@end
