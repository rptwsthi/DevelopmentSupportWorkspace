//
//  VADetailViewController.h
//  CellIncreaseWithTextTypeTest
//
//  Created by Developer on 19/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VADetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
