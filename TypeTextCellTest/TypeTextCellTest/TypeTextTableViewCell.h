//
//  TypeTextTableViewCell.h
//  TypeTextCellTest
//
//  Created by Developer on 19/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TypeTextTableViewCell;
@protocol TypeTextTableViewCellDelegate <NSObject>

- (void) typeText : (NSString *) string cell : (TypeTextTableViewCell*) cell heightChange : (CGFloat) newHeight;

@end

@interface TypeTextTableViewCell : UITableViewCell<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *ttcTextView;
@property (weak, nonatomic) UITableView *parentTableView;
@property (weak, nonatomic) id <TypeTextTableViewCellDelegate> delegate;
@end
