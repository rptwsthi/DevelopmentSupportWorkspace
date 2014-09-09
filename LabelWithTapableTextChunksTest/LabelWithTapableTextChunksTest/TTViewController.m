//
//  ViewController.m
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController ()
@property (strong, nonatomic) NSDictionary *labelTextDictionary;
@property (strong, nonatomic) IBOutlet TouchTextLabel *touchTextLabel;
@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _labelTextDictionary = [self getTouchTextDictionary];

    //set label values
    [_touchTextLabel setTtDatasource:self];
    [_touchTextLabel setTtDelegate:self];

    [_touchTextLabel setText:_labelTextDictionary[@"content"]];;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *) getTouchTextDictionary {
    NSString *textContent = @"This text contains 3 touchable text which are text1, text2, and text3.";
    NSDictionary *touchText1 = @{@"text": @"text1", @"location": @"49"};
    NSDictionary *touchText2 = @{@"text": @"text2", @"location": @"56"};
    NSDictionary *touchText3 = @{@"text": @"text3", @"location": @"64"};
    NSArray * touchTextArray = @[touchText1, touchText2, touchText3];
    NSDictionary *textDetailDictionary = @{@"content": textContent, @"touchDetails": touchTextArray};
    return textDetailDictionary;
}


#pragma mark -  TouchTextLabelDatasource
- (NSInteger) numberOfTouchableText{
    return 2;
}

- (TouchText *) touchText : (NSInteger) position{
    TouchText *touchText = [[TouchText alloc] init];
    NSDictionary *touchTextDictionary = _labelTextDictionary[@"touchDetails"][position];
    touchText.touchText = touchTextDictionary[@"text"];
    touchText.touchTextLocation = [touchTextDictionary[@"location"] integerValue];
    
    return touchText;
}

- (void)touchTextLabel:(TouchTextLabel *)touchLabel textTouched:(NSString *)text atPosition:(NSInteger)position{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


@end
