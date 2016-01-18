//
//  PubNubManager.m
//  PubNubDemo
//
//  Created by Developer on 13/01/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import "PubNubManager.h"
#import <PubNub/PubNub.h>

@interface PubNubManager()<PNObjectEventListener> {
    NSString *activeChannel_;
}
// Stores reference on PubNub client to make sure what it won't be released.
@property (nonatomic) PubNub *client;
@end

@implementation PubNubManager

+ (id) instance {
    static PubNubManager *instance = nil;
    @synchronized(self) {
        if (instance == nil) {
            instance = [[PubNubManager alloc] init];
        }
    }
    return instance;
}

- (id) init {
    if (self = [super init]) {
        [self initilizePubNub];
    }
    return self;
}

- (void) initilizePubNub {
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:@"YOUR PUB KEY"
                                                                     subscribeKey:@"YOUR SUB KEY"];
    self.client = [PubNub clientWithConfiguration:configuration];
    [self.client addListener:self];
}

#pragma mark - Support Methods
- (void) subscribeToChannels : (NSArray *) channelArray withDelegate : (id<PubNubManagerSubscriptionDelegate>) delegate {
    _subscriptionDelegate = delegate;
    [self subscribeToChannels:channelArray];
}

- (void) subscribeToChannels : (NSArray *) channelArray {
//        [self.client subscribeToChannels: @[@"my_channel"] withPresence:YES];
    [self.client subscribeToChannels:channelArray withPresence:YES];
}

- (void) unsubscribeToChannels : (NSArray *) channelArray {
    [self.client unsubscribeFromChannels:channelArray withPresence:NO];
}

/*
 Subscribe to realtime Presence events, such as join, leave, and timeout, by UUID. Setting the presence attribute to a callback will subscribe to presents events on `my_channel`
 */
- (void) subscribeToPresence : (NSArray *) channelArray {
    [self.client subscribeToPresenceChannels:channelArray];
}

//
- (void) setActiveChannel : (NSString *) channelName {
    activeChannel_ = channelName;
}

//Call timeWithCompletion to verify the client connectivity to the origin:
- (void) checkForConnectTime {
    [self.client timeWithCompletion:^(PNTimeResult *result, PNErrorStatus *status) {
        // Check whether request successfully completed or not.
        if (!status.isError) {
            // Handle downloaded server time token using: result.data.timetoken
        }
        // Request processing failed.
        else {
            // Handle tmie token download error. Check 'category' property to find
            // out possible issue because of which request did fail.
            //
            // Request can be resent using: [status retry];
        }
    }];
}

//Publish a message to a channel:
- (void) publishMessage : (NSString *) message toChannel : (NSString *) channel {
    NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    NSDictionary *dictionary = @{@"message":message,
                                 @"userId":userId};
    [self.client publish:message toChannel:channel
          withCompletion:^(PNPublishStatus *status) {
              NSLog(@"status.isError = %d, status = %@", status.isError, status.data.information);

              // Check whether request successfully completed or not.
              if (!status.isError) {
                  // Message successfully published to specified channel.
                  if ([_messageDelegate respondsToSelector:@selector(pnmanager:message:published:)]) {
                      [_messageDelegate pnmanager:self message:dictionary published:channel];
                  }
              }
              // Request processing failed.
              else {
                  // Handle message publish error. Check 'category' property to find out possible issue
                  // because of which request did fail.
                  //
                  // Request can be resent using: [status retry];
                  [status retry];
              }
          }];
}

//Get occupancy of who's here now on the channel by UUID:
- (void) checkWhoIsHere : (NSString *) channel {
    [self.client hereNowForChannel: channel withVerbosity:PNHereNowUUID
                        completion:^(PNPresenceChannelHereNowResult *result,
                                     PNErrorStatus *status) {
                            
                            // Check whether request successfully completed or not.
                            if (!status.isError) {
                                // Handle downloaded presence information using:
                                //   result.data.uuids - list of uuids.
                                //   result.data.occupancy - total number of active subscribers.
                            }
                            // Request processing failed.
                            else {
                                
                                // Handle presence audit error. Check 'category' property to find
                                // out possible issue because of which request did fail.
                                //
                                // Request can be resent using: [status retry];
                            }
                        }];
}

- (void) getHistoryFor : (NSString *) channel {
    [self.client historyForChannel: @"my_channel" start:nil end:nil limit:100
                    withCompletion:^(PNHistoryResult *result, PNErrorStatus *status) {
                        
                        // Check whether request successfully completed or not.
                        if (!status.isError) {
                            // Handle downloaded history using:
                            //   result.data.start - oldest message time stamp in response
                            //   result.data.end - newest message time stamp in response
                            //   result.data.messages - list of messages
                            
                        }
                        // Request processing failed.
                        else {
                            
                            // Handle message history download error. Check 'category' property to find
                            // out possible issue because of which request did fail.
                            //
                            // Request can be resent using: [status retry];
                        }
                    }];
}

- (NSString*) uniqueIdentifier {
    CFUUIDRef unqiueId = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, unqiueId);
    CFRelease(unqiueId);
    NSString *uniqueId = [(__bridge NSString*)string stringByReplacingOccurrencesOfString:@"-"withString:@""];
    CFRelease(string);
    return uniqueId;
}


#pragma mark - PNObjectEventListener Protocol
///------------------------------------------------
/// @name Message and Events handler callbacks
///------------------------------------------------

/**
 @brief  Notify listener about new message which arrived from one of remote data object's live feed
 on which client subscribed at this moment.
 
 @param client  Reference on \b PubNub client which triggered this callback method call.
 @param message Reference on \b PNResult instance which store message information in \c data
 property.
 
 @since 4.0
 */
- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    NSLog(@"Received message: %@ on channel %@ at %@ subsChannel = %@", message.data.message,
          message.data.subscribedChannel, message.data.timetoken, message.data.actualChannel);
    // Handle new message stored in message.data.message
//    if (message.data.actualChannel) {
        // Message has been received on channel group stored in
        // message.data.subscribedChannel
        if ([_messageDelegate respondsToSelector:@selector(pnmanager:message:recieved:)]) {
            [_messageDelegate pnmanager:self
                                message:@{@"message":message.data.message}
                               recieved:message.data.subscribedChannel];
            
        }
//    }
//    else {
//        // Message has been received on channel stored in
//        // message.data.subscribedChannel
//    }
}

/**
 @brief  Notify listener about new presence events which arrived from one of remote data object's
 presence live feed on which client subscribed at this moment.
 
 @param client Reference on \b PubNub client which triggered this callback method call.
 @param event  Reference on \b PNResult instance which store presence event information in
 \c data property.
 
 @since 4.0
 */
- (void)client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    NSLog(@"Did receive presence event: %@", event.data.presenceEvent);
    // Handle presence event event.data.presenceEvent (one of: join, leave, timeout, state-change)
    if (event.data.actualChannel) {
        // Presence event has been received on channel group stored in
        // event.data.subscribedChannel
        
    }
    else {
        // Presence event has been received on channel stored in
        // event.data.subscribedChannel
    }
}



///------------------------------------------------
/// @name Status change handler.
///------------------------------------------------

/**
 @brief      Notify listener about subscription state changes.
 @discussion This callback can fire when client tried to subscribe on channels for which it doesn't
 have access rights or when network went down and client unexpectedly disconnected.
 
 @param client Reference on \b PubNub client which triggered this callback method call.
 @param status  Reference on \b PNStatus instance which store subscriber state information.
 
 @since 4.0
 */
- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    NSLog(@"status.category = %zd", status.category);
    switch (status.category ) {
        case PNUnexpectedDisconnectCategory:
            // This event happens when radio / connectivity is lost
            
            break;
        case PNConnectedCategory:
            // Connect event. You can do stuff like publish, and know you'll get it.
            // Or just use the connected event to confirm you are subscribed for
            // UI / internal notifications, etc
//            if ([_subscriptionDelegate respondsToSelector:@selector(pmmanager:subscribed:toChannels:)]) {
//                
//            }
            //call subscription delegate
            if ([_subscriptionDelegate respondsToSelector:@selector(pnmanager:subscribed:toChannels:)]) {
                [_subscriptionDelegate pnmanager:self subscribed:YES toChannels:client.channels];
            }
            
            break;
        case PNReconnectedCategory:
            // Happens as part of our regular operation. This event happens when
            // radio / connectivity is lost, then regained.
            
            break;
        case PNDecryptionErrorCategory:
            // Handle messsage decryption error. Probably client configured to
            // encrypt messages and on live data feed it received plain text.
            
            break;
            
        default:
            break;
    }
}

@end
