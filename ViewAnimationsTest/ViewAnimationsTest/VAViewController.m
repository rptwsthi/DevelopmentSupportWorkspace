//
//  VAViewController.m
//  ViewAnimationsTest
//
//  Created by Developer on 10/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import "VAViewController.h"

@interface VAViewController ()

@property (nonatomic, strong) UIView * floatingView;
@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _floatingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_floatingView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_floatingView];
    
    [self circleUIViewFloating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Circle UIView floating

- (void) circleUIViewFloating {
    
    [UIView animateWithDuration:2.0
                     animations:^{
                         _floatingView.transform = CGAffineTransformMakeTranslation([self randomFloatingGenerator : 270], [self randomFloatingGenerator:480]);
                     } completion:^(BOOL finished) {
                         [self circleUIViewFloating];
                     }];
}

- (int) randomFloatingGenerator : (int) max{
    return arc4random() % max;
}
@end
