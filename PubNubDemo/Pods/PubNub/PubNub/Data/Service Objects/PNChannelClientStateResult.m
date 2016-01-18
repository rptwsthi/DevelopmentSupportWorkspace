/**
 @author Sergey Mamontov
 @since 4.0
 @copyright © 2009-2015 PubNub, Inc.
 */
#import "PNChannelClientStateResult.h"
#import "PNServiceData+Private.h"
#import "PNResult+Private.h"


#pragma mark Interface implementation

@implementation PNChannelClientStateData


#pragma mark - Information

- (NSDictionary *)state {
    
    return self.serviceData[@"state"];
}

#pragma mark -


@end


#pragma mark - Interface implementation

@implementation PNChannelClientStateResult


#pragma mark - Information

- (PNChannelClientStateData *)data {
    
    return [PNChannelClientStateData dataWithServiceResponse:self.serviceData];
}

#pragma mark -


@end
