//
//  DetailViewController.h
//  PasscodeTest
//
//  Created by Developer on 02/01/15.
//  Copyright (c) 2015 neerav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

