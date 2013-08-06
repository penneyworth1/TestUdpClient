//
//  RootViewController.h
//  TestUdpClient
//
//  Created by The Parking Spot on 8/6/13.
//  Copyright (c) 2013 The Parking Spot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <CFNetwork/CFNetwork.h> //temp //dont leave here put it in a header
#include <arpa/inet.h>

@interface RootViewController : UIViewController

@property UIButton *btnSend;

@end
