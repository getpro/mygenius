//
//  FtpGet.h
//  AddressBook
//
//  Created by Peteo on 11-8-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// FTP传输下载模块

#import <Foundation/Foundation.h>


@interface FtpGet : NSObject < NSStreamDelegate >
{
	UITextField *               _urlText;
    UIImageView *               _imageView;
    UILabel *                   _statusLabel;
    UIActivityIndicatorView *   _activityIndicator;
    UIBarButtonItem *           _getOrCancelButton;
    
    NSInputStream *             _networkStream;
    NSString *                  _filePath;
    NSOutputStream *            _fileStream;
}

@property (nonatomic, readonly) BOOL              isReceiving;
@property (nonatomic, retain)   NSInputStream *   networkStream;
@property (nonatomic, copy)     NSString *        filePath;
@property (nonatomic, retain)   NSOutputStream *  fileStream;

@property (nonatomic, retain) IBOutlet UITextField *               urlText;
@property (nonatomic, retain) IBOutlet UIImageView *               imageView;
@property (nonatomic, retain) IBOutlet UILabel *                   statusLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *   activityIndicator;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *           getOrCancelButton;

// Starts a connection to download the current URL.
- (void)startReceive;


- (void)stopReceiveWithStatus:(NSString *)statusString;

@end
