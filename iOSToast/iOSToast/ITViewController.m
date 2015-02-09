//
//  ITViewController.m
//  iOSToast
//
//  Created by Developer on 29/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import "ITViewController.h"
#import "UIAlertView+iOSToast.h"

@interface ITViewController ()

@end

@implementation ITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    UIAlertView *alert = [[UIAlertView  alloc] init];
    [alert showToast:@"Toast" withFrame:CGRectMake(0, 0, 200, 100)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
