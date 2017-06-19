//
//  RPTTextView.m
//  RptUITextView
//
//  Created by Developer on 09/10/15.
//  Copyright (c) 2015 Technologies33. All rights reserved.
//

#import "RPTTextView.h"

@implementation RPTTextView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id) init{
	if (self = [super init]) {
		[self setUITextViewProperties];
	}
	return self;
}

- (void) awakeFromNib {
	[super awakeFromNib];
	[self setUITextViewProperties];
}

- (void) setUITextViewProperties {
	[self setDelegate:self];
	_cusomTextColor = [UIColor blackColor];
	_charectorLimit = 1000.0f;//default charector limit for text view
}

- (void) setPlaceHolder:(NSString *)placeHolder {
	_placeHolder = placeHolder;
	[self setText:placeHolder];
	_placeHolderColor = (_placeHolderColor!=nil) ? _placeHolderColor : [UIColor lightGrayColor];
	[self setTextColor:_placeHolderColor];
}

- (void) setText_:(NSString *)text_ {
	_text_ = text_;
	[self setText:text_];
	_cusomTextColor = (_cusomTextColor != nil) ? _cusomTextColor : [UIColor blackColor];
	[self setTextColor:_cusomTextColor];
}

- (void) setPlaceHolderColor:(UIColor *)placeHolderColor {
	_placeHolderColor = placeHolderColor;
	if (_placeHolder!=nil)
		[self setTextColor:_placeHolderColor];
}


- (void) setCusomTextColor:(UIColor *)cusomTextColor {
	_cusomTextColor = cusomTextColor;
	if (_placeHolder == nil || ![self textViewShowingPlaceHolder])
		[self setTextColor:_cusomTextColor];
}

- (BOOL) textViewShowingPlaceHolder{
	return ([self.text isEqualToString:_placeHolder] && [self.textColor isEqual:_placeHolderColor]);
}

- (void) setCharectorLimit:(NSInteger)charectorLimit {
	_charectorLimit = charectorLimit;
}

- (NSString *) editedText {
	return ([self.text length] && ![self.text isEqualToString:_placeHolder]) ? self.text : nil;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	if ([self textViewShowingPlaceHolder]) {
		self.text = @"";
		[self setTextColor:_cusomTextColor];
	}

	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textViewShouldBeginEditing:)])
		return [_delegate_ textViewShouldBeginEditing:self];

	return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textViewShouldEndEditing:)])
		return [_delegate_ textViewShouldEndEditing:self];

	return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textViewDidBeginEditing:)])
		[_delegate_ textViewDidBeginEditing:self];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	if ([self.text isEqualToString:@""]) {
		self.text = _placeHolder;
		[self setTextColor:_placeHolderColor];
	}

	//
	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textViewDidEndEditing:)])
		[_delegate_ textViewDidEndEditing:self];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	NSInteger newLength = [textView.text stringByAppendingString:text].length;
	if (newLength > _charectorLimit)
		return NO;

	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
		return [_delegate_ textView:self shouldChangeTextInRange:range replacementText:text];

	return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textViewDidChange:)])
		[_delegate_ textViewDidChange:self];
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textViewDidChangeSelection:)])
		[_delegate_ textViewDidChangeSelection:self];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)])
		return [_delegate_ textView:self shouldInteractWithURL:URL inRange:characterRange];
	return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){
	if (_delegate_!=nil && [_delegate_ respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)])
		return [_delegate_ textView:self shouldInteractWithTextAttachment:textAttachment inRange:characterRange];;
	return YES;
}


@end
