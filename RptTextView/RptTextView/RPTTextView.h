//
//  RPTTextView.h
//  RptTextView
//
//  Created by Developer on 09/10/15.
//  Copyright (c) 2015 Technologies33. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPTTextView;

@protocol RPTTextViewDelegate <NSObject>
- (BOOL)textViewShouldBeginEditing:(RPTTextView *)textView;
- (BOOL)textViewShouldEndEditing:(RPTTextView *)textView;

- (void)textViewDidBeginEditing:(RPTTextView *)textView;
- (void)textViewDidEndEditing:(RPTTextView *)textView;

- (BOOL)textView:(RPTTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(RPTTextView *)textView;

- (void)textViewDidChangeSelection:(RPTTextView *)textView;

- (BOOL)textView:(RPTTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
- (BOOL)textView:(RPTTextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
@end

@interface RPTTextView : UITextView <UITextViewDelegate>

@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) UIColor *placeHolderColor;
@property (nonatomic, strong) UIColor *cusomTextColor;

@property (nonatomic, assign) id <RPTTextViewDelegate> delegate_;
@property (nonatomic, assign) NSInteger charectorLimit;
@end
