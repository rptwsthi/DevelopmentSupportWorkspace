//
//  UILabel+TouchTextLabel.h
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextChunk.h"

@class  TouchTextLabel;
@protocol TouchTextLabelDatasource <NSObject>

@required
- (NSInteger) numberOfTouchableText;
- (NSString *) touchTextAtPosition : (NSInteger) position; //start from 1
- (NSString *) touchTextIdAtPosition : (NSInteger) position; //start from 1

@optional
- (UIColor *) touchTextColorAtPosition : (NSInteger) position; //start from 1


@end

@protocol TouchTextLabelDelegate <NSObject>

@optional
- (void) touchTextLabel : (TouchTextLabel *) touchLabel textTouched : (NSString *) textId;

@end

@interface TouchTextLabel : UILabel

@property (strong, nonatomic) NSArray *textChunkArray;
@property (strong, nonatomic) id <TouchTextLabelDatasource> datasource;
@property (strong, nonatomic) id <TouchTextLabelDelegate>   delegate;
@end
