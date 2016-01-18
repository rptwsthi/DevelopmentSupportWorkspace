//
//  MasterViewController.h
//  PubNubDemo
//
//  Created by Developer on 09/01/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController
@property (strong, nonatomic) DetailViewController *detailViewController;

@end

