//
//  PasscodeViewController.m
//  PasscodeTest
//
//  Created by Developer on 02/01/15.
//  Copyright (c) 2015 neerav. All rights reserved.
//

#import "PasscodeViewController.h"

@interface PasscodeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *passcodeFieldContainerView;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *passCodeTextFields;
@property (strong, nonatomic) NSString *passCode;


@end

@implementation PasscodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    int i = 0;
    for (UITextField *textField in _passCodeTextFields){
        textField.tag = i++;
        [textField setDelegate:self];
    }
    _passCode = @"";
    [_passCodeTextFields[0] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_passCode stringByAppendingString:textField.text];
//    if (textField.tag == kLastTextFieldTag) {
//        [self matchPasscode:_passCode];
//        [textField resignFirstResponder];
//    }
//    else if ([textField.text length] == 1) {
//        [_passCodeTextFields[textField.tag+1] becomeFirstResponder];
//    }
//}
//- (IBAction)textFieldValueChanged:(id)sender {
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{   // return NO to not change text
    
    if (![string length]) {
        textField.text = @"";
        [_passCodeTextFields[((textField.tag-1) < 0) ? 0 : textField.tag-1] becomeFirstResponder];
        return NO;
    }
    
    _passCode = [NSString stringWithFormat:@"%@%@", _passCode, string];
//    textField.text = string;
//    if (textField.tag == kLastTextFieldTag - 1) {
//        [self matchPasscode:_passCode];
//        [textField resignFirstResponder];
//    }
    if ([textField.text length] == 1) {
        NSInteger tag = textField.tag+1;
        [_passCodeTextFields[tag] becomeFirstResponder];
        if (textField.tag == kLastTextFieldTag - 1) {
            UITextField *lastTextField = _passCodeTextFields[tag];
            lastTextField.text = string;
            [lastTextField resignFirstResponder];
            [self matchPasscode:_passCode];
            return NO;
        }
    }
    
    return YES;
}

- (void) matchPasscode : (NSString *) passcode{
    NSLog(@"passcode = %@", passcode);
    _passCode = @"";
    
//    for (UITextField *textField in _passCodeTextFields)
//        textField.text = @"";
//    [_passCodeTextFields[0] becomeFirstResponder];
    
}

@end