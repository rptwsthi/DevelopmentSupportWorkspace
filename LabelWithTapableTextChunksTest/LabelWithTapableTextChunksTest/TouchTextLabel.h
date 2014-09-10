//
//  UILabel+TouchTextLabel.h
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchText.h"

@class  TouchTextLabel;
@protocol TouchTextLabelDatasource <NSObject>

@required
- (NSInteger) numberOfTouchableText;
- (TouchText *) touchText : (NSInteger) position;

@optional
- (UIColor *) touchTextColorAtPosition : (NSInteger) position;


@end

@protocol TouchTextLabelDelegate <NSObject>

@optional
- (void) touchTextLabel : (TouchTextLabel *) touchLabel touchText : (TouchText *) text atPosition  : (NSInteger) position;

@end

@interface TouchTextLabel : UILabel<UIWebViewDelegate>

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) id <TouchTextLabelDatasource> ttDatasource;
@property (strong, nonatomic) id <TouchTextLabelDelegate>   ttDelegate;

- (void) setText : (NSString *) text;
- (void) sizeToFit;
- (void) setTouchLabelFrame : (CGRect)frame;

@end
