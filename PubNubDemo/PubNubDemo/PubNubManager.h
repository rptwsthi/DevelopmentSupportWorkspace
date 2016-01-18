//
//  PubNubManager.h
//  PubNubDemo
//
//  Created by Developer on 13/01/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import <Foundation/Foundation.h>

//macro
#define PubNub_MANAGER [PubNubManager instance]

@class PubNubManager;

@protocol PubNubManagerSubscriptionDelegate <NSObject>
- (void) pnmanager:(PubNubManager *) manager subscribed : (BOOL) subscribed toChannels : (NSArray *) channels;

@end


@protocol PubNubManagerMessageDelegate <NSObject>

- (void) pnmanager:(PubNubManager *) manager message : (NSDictionary *) message recieved : (NSString *) channel;
- (void) pnmanager:(PubNubManager *) manager message : (NSDictionary *) message published : (NSString *) channel;

@end

@interface PubNubManager : NSObject
//instance
+ (id) instance;

@property (nonatomic, strong) id<PubNubManagerMessageDelegate> messageDelegate;
@property (nonatomic, strong) id<PubNubManagerSubscriptionDelegate> subscriptionDelegate;

- (void) publishMessage : (NSString *) message toChannel : (NSString *) channel;

//sub/unsub
- (void) subscribeToChannels : (NSArray *) channelArray withDelegate : (id<PubNubManagerSubscriptionDelegate>) delegate;
- (void) unsubscribeToChannels : (NSArray *) channelArray;
- (void) subscribeToPresence : (NSArray *) channelArray;

//
- (void) setActiveChannel : (NSString *) channelName;
@end