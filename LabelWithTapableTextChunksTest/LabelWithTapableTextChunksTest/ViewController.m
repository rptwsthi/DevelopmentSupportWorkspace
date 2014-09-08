//
//  ViewController.m
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //add button grid to view
    UIView *buttonView = [self view:CGSizeMake(self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f) withButtons:84];
    [buttonView setBackgroundColor:[UIColor redColor]];
    buttonView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [self.view addSubview:buttonView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *) view : (CGSize) viewSize withButtons : (int) numberOfButtons{
    CGRect frame = CGRectZero;
    frame.size = viewSize;
    UIView *view = [[UIView alloc]initWithFrame:frame];//considering View size is after margine
    
    CGSize buttonSize = [self getButton:numberOfButtons sizeFor:viewSize];
    
    for (int i = 1; i <= numberOfButtons; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:[self getButton:buttonSize frameForIndex:i inView:viewSize]];
        [button setTitle:[[NSNumber numberWithInt:i] stringValue] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [button.layer setBorderWidth:1.0f];
        [view addSubview:button];
    }
    return view;
}

- (CGRect) getButton : (CGSize) buttonSize frameForIndex : (int) buttonIndex inView : (CGSize) containerSize{
    int x = buttonIndex % (int)(containerSize.width / buttonSize.width);
    x *= buttonSize.width;
    int y = buttonIndex % (int)(containerSize.height / buttonSize.height);
    y *= buttonSize.height;
    
    CGRect frame = CGRectZero;
    frame.origin = CGPointMake(x, y);
    frame.size = buttonSize;
    
    return frame;
}

- (CGSize) getButton : (int) numberOfButtons sizeFor : (CGSize) containerSize{
    double containerArea = containerSize.width * containerSize.height;
    double areaOfOneButton = containerArea / numberOfButtons;
    double edgeOfOneButton = sqrt(areaOfOneButton);
    edgeOfOneButton = (edgeOfOneButton > containerSize.width) ? containerSize.width : edgeOfOneButton;
    
    return CGSizeMake(edgeOfOneButton, edgeOfOneButton);
}

@end
