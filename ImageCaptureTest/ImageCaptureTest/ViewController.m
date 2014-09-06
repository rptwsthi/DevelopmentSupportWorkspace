//
//  ViewController.m
//  ImageCaptureTest
//
//  Created by Developer on 06/09/14.
//  Copyright (c) 2014 Arpit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)takePhoto:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@property int tag;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    _tag = ((UIButton *)sender).tag;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];


}

#pragma mark - UIImagePickerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    [[self getImageView:_tag] setImage:image];
    
}

- (UIImageView *) getImageView : (int) tag{
    for (UIImageView *imageView in _imageViews) {
        if (imageView.tag == tag) {
            return imageView;
        }
    }
    return nil;
}

@end