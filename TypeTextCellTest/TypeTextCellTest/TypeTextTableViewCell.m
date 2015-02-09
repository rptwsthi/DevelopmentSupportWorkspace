//
//  TypeTextTableViewCell.m
//  TypeTextCellTest
//
//  Created by Developer on 19/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import "TypeTextTableViewCell.h"

@interface TypeTextTableViewCell(){
}
@property (strong, nonatomic) UIButton *resignTouchButton;
- (void)resignTouchButtonTouched:(id)sender;

@end

@implementation TypeTextTableViewCell{
    CGFloat lastHeight;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _resignTouchButton = [self getKeyboardAccesaryView];
        [_ttcTextView setDelegate:self];
        [_ttcTextView setBackgroundColor:[UIColor redColor]];
        [_ttcTextView setInputAccessoryView:_resignTouchButton];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    _resignTouchButton = [self getKeyboardAccesaryView];
    [_ttcTextView setDelegate:self];
    [_ttcTextView setBackgroundColor:[UIColor redColor]];
    [_ttcTextView setInputAccessoryView:_resignTouchButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIButton *) getKeyboardAccesaryView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor darkGrayColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 320.0f, 34.0f)];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [button addTarget:self action:@selector(resignTouchButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [button.layer setBorderColor:[UIColor blackColor].CGColor];
    [button.layer setBorderWidth:1.0f];
    return button;
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [textView setScrollEnabled:YES];
    NSLog(@"textView.scroll = %d", textView.isScrollEnabled);
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [textView setScrollEnabled:NO];
    NSLog(@"textView.scroll = %d", textView.isScrollEnabled);
    
    CGRect textBoundingFrame = [self boundingFrameOfText:textView];
    textBoundingFrame.origin = textView.frame.origin;
    textBoundingFrame.size.width = textView.frame.size.width;
    textBoundingFrame.size.height += 40;//padding
    textView.frame = textBoundingFrame;
    
    //height change
    if (textBoundingFrame.size.height >= (lastHeight + textView.font.pointSize)) {
        [_delegate typeText:textView.text cell:self heightChange:textBoundingFrame.size.height];
        lastHeight = textBoundingFrame.size.height;
    }
}

//- (CGFloat) heightOfText : (NSString *) text forWidth : (CGFloat) width font : (UIFont *) font{
- (CGRect) boundingFrameOfText : (UITextView*) textView{
    NSDictionary *attributes = @{NSFontAttributeName: textView.font};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    
    return [textView.text boundingRectWithSize:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];
}

- (void)resignTouchButtonTouched:(id)sender {
    [_ttcTextView resignFirstResponder];
}
@end
