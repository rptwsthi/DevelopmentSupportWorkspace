//
//  ViewController.m
//  RptTextView
//
//  Created by Developer on 09/10/15.
//  Copyright (c) 2015 Technologies33. All rights reserved.
//

#import "ViewController.h"
#import "RPTTextView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet RPTTextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_textView setBackgroundColor:[UIColor greenColor]];
    [_textView setPlaceHolder:@"Hello!"];
    [_textView setCharectorLimit:10];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)resignTextView:(id)sender {
    [_textView resignFirstResponder];
}

@end
