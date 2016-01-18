/**
 @brief Global client constants declared here.

 @author Sergey Mamontov
 @since 4.0
 @copyright © 2009-2015 PubNub, Inc.
 */
#import <Foundation/Foundation.h>


#ifndef PNConstants_h
#define PNConstants_h

#pragma mark General information constants

// Stores client library version number
static NSString * const kPNLibraryVersion = @"4.2.3";

// Stores information about SDK codebase
static NSString * const kPNCommit = @"42106505560db45434ff00131f0d8fd9b16e102d";

#if TARGET_OS_WATCH
    static NSString * const kPNClientName = @"ObjC-watchOS";
#elif __IPHONE_OS_VERSION_MIN_REQUIRED
    static NSString * const kPNClientName = @"ObjC-iOS";
#elif __MAC_OS_X_VERSION_MIN_REQUIRED
    static NSString * const kPNClientName = @"ObjC-MacOS";
#endif // __MAC_OS_X_VERSION_MIN_REQUIRED


#pragma mark - Default client configuration

static NSString * const kPNDefaultOrigin = @"pubsub.pubnub.com";

static NSTimeInterval const kPNDefaultSubscribeMaximumIdleTime = 310.0f;
static NSTimeInterval const kPNDefaultNonSubscribeRequestTimeout = 10.0f;

static BOOL const kPNDefaultIsTLSEnabled = YES;
static BOOL const kPNDefaultShouldKeepTimeTokenOnListChange = YES;
static BOOL const kPNDefaultShouldRestoreSubscription = YES;
static BOOL const kPNDefaultShouldTryCatchUpOnSubscriptionRestore = YES;

#endif // PNConstants_h
