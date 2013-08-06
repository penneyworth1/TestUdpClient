//
//  RootViewController.m
//  TestUdpClient
//
//  Created by The Parking Spot on 8/6/13.
//  Copyright (c) 2013 The Parking Spot. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    //CFSocketRef _cfSocket;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSLog(@"rootViewController viewDidLoad");
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    _btnSend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnSend addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSend setTitle:@"Send" forState:UIControlStateNormal];
    _btnSend.frame = CGRectMake(10, 10, 80, 40);
    [self.view addSubview:_btnSend];
    
}

- (void)sendButtonPressed:(UIButton*)sender
{
    
    
    CFSocketRef socketRef = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_DGRAM, IPPROTO_UDP, 0, NULL, NULL);
    int socketInt = CFSocketGetNative(socketRef); //CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_DGRAM, IPPROTO_UDP, kCFSocketNoCallBack, NULL, NULL);
    if(socketInt >= 0)
    {
        //NSLog(@"socket initialized");
        
        struct sockaddr_in destination;
        memset(&destination, 0, sizeof(struct sockaddr_in));
        destination.sin_len = sizeof(struct sockaddr_in);
        destination.sin_family = AF_INET;
        
        NSString *ip = @"38.98.173.2";
        destination.sin_addr.s_addr = inet_addr([ip UTF8String]);
        destination.sin_port = htons(58642); //port
        
        char messageCharArray[]= "helloworld from iphone ^_^";
        CFDataRef Data = CFDataCreate(NULL, (const UInt8*)messageCharArray, sizeof(messageCharArray));
        
        //CFSocketSetAddress(socketRef, CFDataCreate(NULL, (const UInt8*)&destination, sizeof(destination)));
        CFSocketSendData(socketRef, CFDataCreate(NULL, (const UInt8*)&destination, sizeof(destination)), Data, 10);
    
        CFRelease(Data);
        
        
        
        //try to receive
        int                     err;
        struct sockaddr_storage addr;
        socklen_t               addrLen;
        uint8_t                 buffer[1024];
        ssize_t                 bytesRead;
        
        addrLen = sizeof(addr);
        bytesRead = recvfrom(socketInt, buffer, sizeof(buffer), 0, (struct sockaddr *) &addr, &addrLen);
        err = 1;
        
    }
    
    CFRelease(socketRef);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
