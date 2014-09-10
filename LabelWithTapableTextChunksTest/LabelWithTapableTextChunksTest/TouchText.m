//
//  TouchableTextChunk.m
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import "TouchText.h"
#import "UIColor+HexColors.h"

@implementation TouchText

- (NSString *) hexValueOfTextColor{
    if (_touchTextColor == nil) {
        _touchTextColor = [UIColor colorWithRed:47.0f/255.0f green:185.0f/255.0f blue:175.0f/255.0f alpha:1.0f];
    }
    return [UIColor hexValuesFromUIColor:_touchTextColor];
}
@end
