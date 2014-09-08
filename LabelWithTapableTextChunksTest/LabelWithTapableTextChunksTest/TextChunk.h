//
//  TouchableTextChunk.h
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextChunk : NSObject

@property (strong, nonatomic) NSString *touchableText;
@property (strong, nonatomic) NSString *touchableTextId;
@property (strong, nonatomic) UIColor  *touchableTextColor;

@end
