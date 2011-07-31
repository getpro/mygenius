//
//  AddressBookAppDelegate.m
//  AddressBook
//
//  Created by Peteo on 11-7-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBookAppDelegate.h"
#import "PublicData.h"

@implementation AddressBookAppDelegate

@synthesize window;
@synthesize back;
@synthesize sceneID;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	switchViewController = [[SwitchViewController alloc] init];
	
	sceneID = [NSMutableArray arrayWithCapacity :5];
	
	NSNumber * n = [NSNumber numberWithInt:0];
	
	[sceneID addObject:n];
	[sceneID addObject:n];
	[sceneID addObject:n];
	
	[sceneID		 retain];
	
	[self.window addSubview:switchViewController.view];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
	[switchViewController release];
    [window				  release];
	[sceneID			  release];
	
    [super dealloc];
}

+(AddressBookAppDelegate*)getAppDelegate
{
    return (AddressBookAppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void) backScene
{
	rightOrLeft = NO;
	teXiao      = YES;
	back        = YES;
	
	NSNumber * n = [sceneID objectAtIndex:[sceneID count] - 2];
	[sceneID removeLastObject];
	backSceneID = [n intValue];
	
	NSString * ss = [NSString stringWithFormat:@"%d" , backSceneID];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScene" object:ss];
	
}

@end
