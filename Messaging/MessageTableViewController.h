//
//  MessageTableViewController.h
//  Messaging
//
//  Created by Scott Nicol on 11/01/2013.
//  Copyright (c) 2013 Scott Nicol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libPusher/PTPusher.h>
#import <libPusher/PTPusherChannel.h>
#import <libPusher/PTPusherEvent.h>
#import <JSONKit/JSONKit.h>

@interface MessageTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic, strong) PTPusher *client;
@property (nonatomic, strong) NSMutableArray *messages;

@end
