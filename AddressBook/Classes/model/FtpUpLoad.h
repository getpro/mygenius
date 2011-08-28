//
//  Ftp.h
//  AddressBook
//
//  Created by Peteo on 11-8-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// FTP传输上传模块

#import <Foundation/Foundation.h>

#define USERNAME @"jiadong"

#define PASSWORD @"jiadong"

#define FTP_URL  @"ftp://61.147.124.46"

enum 
{
    kSendBufferSize = 32768
};

@interface FtpUpLoad : NSObject < NSStreamDelegate >
{
    UILabel *                   _statusLabel;
    UIActivityIndicatorView *   _activityIndicator;
	
    NSOutputStream *            _networkStream;
    NSInputStream *             _fileStream;
    uint8_t                     _buffer[kSendBufferSize];
    size_t                      _bufferOffset;
    size_t                      _bufferLimit;
}

@property (nonatomic, retain) IBOutlet UILabel *                   statusLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *   activityIndicator;

@property (nonatomic, readonly) BOOL              isSending;
@property (nonatomic, retain)   NSOutputStream *  networkStream;
@property (nonatomic, retain)   NSInputStream *   fileStream;
@property (nonatomic, readonly) uint8_t *         buffer;
@property (nonatomic, assign)   size_t            bufferOffset;
@property (nonatomic, assign)   size_t            bufferLimit;

//FTP上传
- (void)startSend:(NSString *)filePath;

- (void)stopSendWithStatus:(NSString *)statusString;

@end
