//
//  UIAlertView+iOSToast.m
//  iOSToast
//
//  Created by Developer on 29/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import "UIAlertView+iOSToast.h"

@implementation UIAlertView (iOSToast)

- (void) showToast : (NSString *) string withFrame : (CGRect) frame{
    [[self initWithTitle:nil message:@"Toast Shown" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil] show];
    [self performSelector:@selector(removeMeFromSuperview) withObject:nil afterDelay:3.0f];
}

- (void) removeMeFromSuperview{
    [self dismissWithClickedButtonIndex:-1 animated:YES];
}

@end
