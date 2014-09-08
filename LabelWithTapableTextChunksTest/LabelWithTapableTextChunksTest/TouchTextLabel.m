//
//  UILabel+TouchTextLabel.m
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import "TouchTextLabel.h"

@implementation TouchTextLabel

- (void) setText:(NSString *)text{
    _textChunkArray = [self getTextDetailArray];
}

- (NSArray *) getTextDetailArray{
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger numeberOfTextChunk = [_datasource numberOfTouchableText];
    for (NSInteger i = 1; i <= numeberOfTextChunk; i++) {
        TextChunk *textChunk = [[TextChunk alloc] init];
        textChunk.touchableText = [_datasource touchTextAtPosition:i];
        textChunk.touchableTextId = [_datasource touchTextIdAtPosition:i];
        
        //set color
        UIColor *textColor = [_datasource touchTextColorAtPosition:i];
        if (textColor == nil) {//set default color
            textColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.60f];
        }
        textChunk.touchableTextColor = textColor;
        
        [array addObject:textChunk];
    }
    return [NSArray arrayWithArray:array];
}

@end
