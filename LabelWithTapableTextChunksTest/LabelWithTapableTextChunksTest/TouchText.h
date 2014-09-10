//
//  TouchableTextChunk.h
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchText : NSObject

@property (strong, nonatomic) NSString  *touchText;
@property (strong, nonatomic) NSString  *touchTextId;
@property (assign)            NSInteger touchTextLocation;
@property (strong, nonatomic) UIColor   *touchTextColor;

- (NSString *) hexValueOfTextColor;

@end
