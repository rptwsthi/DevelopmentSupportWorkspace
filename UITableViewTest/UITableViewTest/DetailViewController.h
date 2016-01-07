//
//  DetailViewController.h
//  UITableViewTest
//
//  Created by Developer on 07/01/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

