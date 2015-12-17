//
//  ViewController.m
//  ClassTest
//
//  Created by Developer on 13/12/15.
//  Copyright © 2015 Neerav. All rights reserved.
//

#import "ViewController.h"
#import "TestInnerClass.h"

@interface ViewController ()
@property (nonatomic, strong) TestClass *testClass;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _testClass = [[TestClass alloc] init];
    [_testClass printStuff];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTouched:(id)sender {
    TestMiddleClass *testMiddleClass = [_testClass getTestMiddleClass];
    testMiddleClass.anotherInteger += 2;
    [testMiddleClass printStuff];
    
    TestInnerClass *innerClass = [_testClass getTestInnerClass];
    innerClass.integer += 10;
    innerClass.string = @"10.0f";
    [innerClass printStuff];
    
    [_testClass save];
}



@end
