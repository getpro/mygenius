//
//  Ftp.m
//  AddressBook
//
//  Created by Peteo on 11-8-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <CFNetwork/CFNetwork.h>

#import "AddressBookAppDelegate.h"
#import "FtpUpLoad.h"


@implementation FtpUpLoad

#pragma mark * Core transfer code

// This is the code that actually does the networking.

@synthesize networkStream = _networkStream;
@synthesize fileStream    = _fileStream;
@synthesize bufferOffset  = _bufferOffset;
@synthesize bufferLimit   = _bufferLimit;

#pragma mark * View controller boilerplate

@synthesize statusLabel       = _statusLabel;
@synthesize activityIndicator = _activityIndicator;

#pragma mark * Status management

// These methods are used by the core transfer code to update the UI.

- (void)_sendDidStart
{
    self.statusLabel.text = @"Sending";
    //self.cancelButton.enabled = YES;
    [self.activityIndicator startAnimating];
    [[AddressBookAppDelegate getAppDelegate] didStartNetworking];
}

- (void)_updateStatus:(NSString *)statusString
{
    assert(statusString != nil);
    self.statusLabel.text = statusString;
}

- (void)_sendDidStopWithStatus:(NSString *)statusString
{
    if (statusString == nil) {
        statusString = @"Put succeeded";
    }
    self.statusLabel.text = statusString;
    //self.cancelButton.enabled = NO;
    [self.activityIndicator stopAnimating];
    [[AddressBookAppDelegate getAppDelegate] didStopNetworking];
}

// Because buffer is declared as an array, you have to use a custom getter.  
// A synthesised getter doesn't compile.

- (uint8_t *)buffer
{
    return self->_buffer;
}

- (BOOL)isSending
{
    return (self.networkStream != nil);
}

- (void)startSend:(NSString *)filePath
{
	BOOL                    success;
    NSURL *                 url;
    CFWriteStreamRef        ftpStream;
    
    assert(filePath != nil);
    assert([[NSFileManager defaultManager] fileExistsAtPath:filePath]);
	
    //assert( [filePath.pathExtension isEqual:@"png"] || [filePath.pathExtension isEqual:@"jpg"] );
    
    assert(self.networkStream == nil);      // don't tap send twice in a row!
    assert(self.fileStream == nil);         // ditto
	
    // First get and check the URL.
    
    url = [[AddressBookAppDelegate getAppDelegate] smartURLForString:FTP_URL];
    success = (url != nil);
    
    if (success) 
	{
        // Add the last part of the file name to the end of the URL to form the final 
        // URL that we're going to put to.
        
        url = [NSMakeCollectable(
								 CFURLCreateCopyAppendingPathComponent(NULL, (CFURLRef) url, (CFStringRef) [filePath lastPathComponent], false)
								 ) autorelease];
        success = (url != nil);
    }
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
	
    if ( ! success) 
	{
        self.statusLabel.text = @"Invalid URL";
    } 
	else 
	{
		
        // Open a stream for the file we're going to send.  We do not open this stream; 
        // NSURLConnection will do it for us.
        
        self.fileStream = [NSInputStream inputStreamWithFileAtPath:filePath];
        assert(self.fileStream != nil);
        
        [self.fileStream open];
        
        // Open a CFFTPStream for the URL.
		
        ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (CFURLRef) url);
        assert(ftpStream != NULL);
        
        self.networkStream = (NSOutputStream *) ftpStream;
		
        //if (self.usernameText.text.length != 0) 
		{
#pragma unused (success) //Adding this to appease the static analyzer.
            success = [self.networkStream setProperty:USERNAME forKey:(id)kCFStreamPropertyFTPUserName];
            assert(success);
            success = [self.networkStream setProperty:PASSWORD forKey:(id)kCFStreamPropertyFTPPassword];
            assert(success);
        }
		
        self.networkStream.delegate = self;
        [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.networkStream open];
		
        // Have to release ftpStream to balance out the create.  self.networkStream 
        // has retained this for our persistent use.
        
        CFRelease(ftpStream);
		
        // Tell the UI we're sending.
        
        [self _sendDidStart];
    }
}

- (void)stopSendWithStatus:(NSString *)statusString
{
	if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }
    [self _sendDidStopWithStatus:statusString];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our 
// network stream.
{
#pragma unused(aStream)
    assert(aStream == self.networkStream);
	
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            [self _updateStatus:@"Opened connection"];
        } break;
        case NSStreamEventHasBytesAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventHasSpaceAvailable: {
            [self _updateStatus:@"Sending"];
            
            // If we don't have any data buffered, go read the next chunk of data.
            
            if (self.bufferOffset == self.bufferLimit) {
                NSInteger   bytesRead;
                
                bytesRead = [self.fileStream read:self.buffer maxLength:kSendBufferSize];
                
                if (bytesRead == -1) 
				{
                    [self stopSendWithStatus:@"File read error"];
                } 
				else if (bytesRead == 0) 
				{
                    [self stopSendWithStatus:nil];
                } 
				else 
				{
                    self.bufferOffset = 0;
                    self.bufferLimit  = bytesRead;
                }
            }
            
            // If we're not out of data completely, send the next chunk.
            
            if (self.bufferOffset != self.bufferLimit) 
			{
                NSInteger   bytesWritten;
                bytesWritten = [self.networkStream write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
                assert(bytesWritten != 0);
                if (bytesWritten == -1) 
				{
                    [self stopSendWithStatus:@"Network write error"];
                } 
				else 
				{
                    self.bufferOffset += bytesWritten;
                }
            }
        } break;
        case NSStreamEventErrorOccurred: 
		{
            [self stopSendWithStatus:@"Stream open error"];
        } 
			break;
        case NSStreamEventEndEncountered: 
		{
            // ignore
        } 
			break;
        default: 
		{
            assert(NO);
        } 
			break;
    }
}

- (void)dealloc
{
    [self stopSendWithStatus:@"Stopped"];
	
    [self->_statusLabel release];
    [self->_activityIndicator release];
    
    [super dealloc];
}

@end
